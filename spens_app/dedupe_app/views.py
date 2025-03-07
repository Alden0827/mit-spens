from django.shortcuts import render
import pandas as pd

import json
import os
from logging import raiseExceptions
from django.db.models import OuterRef, Subquery
from celery_progress.backend import Progress
from django.conf import settings
from django.http import Http404, HttpResponse, HttpResponseBadRequest
from django.views.generic import TemplateView

from django.http import JsonResponse, HttpResponseNotFound
from django.views.decorators.csrf import csrf_exempt

from celery.result import AsyncResult
from django.views import View

from .forms import ImportFileForm
from .tasks import export_user_task, deduplicator_task, pantawid_namematcher_task, dataincon_task
from .dutils import in_memory_file_to_temp, person_find, count_columns_bykey
import uuid
from .models import datasets, transactions, lib_classification, lib_trans_status
from .models import roster
from django.utils import timezone
from datetime import datetime
from django.shortcuts import render, redirect, get_object_or_404
import shutil
# from celery.app.control import revoke
# from celery import revoke
from celery.app.control import Control
from celery import Celery
from pathlib import Path
from django.core import serializers
from rapidfuzz import fuzz
from django.db import IntegrityError, transaction
from django.core.exceptions import ValidationError
import io
from django.contrib.auth.decorators import login_required
from django.db.models import Count, Avg  # Ensure these are imported


from .utils.data_incon_helper import load_observations, get_dataset_id_by_trains_id, get_transaction_info

app = Celery('package') 
app.config_from_object('django.conf:settings', namespace='CELERY')


class TasksListView(View):
    def get(self, request, *args, **kwargs):
        trans_id = request.GET.get('trans_id', None)

        '''

        SELECT 
            t.trans_id,
            (SELECT d.dataset_uid FROM dedupe_app_datasets d WHERE d.dataset_id = t.dataset_id LIMIT 1) AS dataset_uid,
            (SELECT d.description FROM dedupe_app_datasets d WHERE d.dataset_id = t.dataset_id LIMIT 1) AS dataset_desciption,
            (SELECT d.time_added FROM dedupe_app_datasets d WHERE d.dataset_id = t.dataset_id LIMIT 1) AS dataset_date,
            (SELECT c.classification FROM dedupe_app_lib_classification c WHERE c.classification_id = t.classification_id LIMIT 1) AS classification,
            (SELECT s.status FROM dedupe_app_lib_trans_status s WHERE s.status_id = t.status_id LIMIT 1) AS trans_status,
            t.status_id,
            t.process_id,
            t.progress,
            t.description,
            t.row_count,
            t.checkpoint_time,
            t.time_added
        FROM 
            dedupe_app_transactions t
        WHERE 
            t.trans_id = 9;
        '''
        # Perform the query
        transactions_with_dataset_and_classification_info = transactions.objects.filter(
            trans_id=trans_id  # Filter by trans_id
        ).annotate(
            dataset_uid=Subquery(
                datasets.objects.filter(
                    dataset_id=OuterRef('dataset_id')  # Join with datasets based on dataset_id
                ).values('dataset_uid')[:1]  # Select dataset_uid and limit to 1 result
            ),
            dataset_description=Subquery(
                datasets.objects.filter(
                    dataset_id=OuterRef('dataset_id')  # Join with datasets based on dataset_id
                ).values('description')[:1]  # Select description and limit to 1 result
            ),
            dataset_date=Subquery(
                datasets.objects.filter(
                    dataset_id=OuterRef('dataset_id')  # Join with datasets based on dataset_id
                ).values('time_added')[:1]  # Select time_added and limit to 1 result
            ),
            classification=Subquery(
                lib_classification.objects.filter(
                    classification_id=OuterRef('classification_id')  # Join with lib_classification based on classification_id
                ).values('classification')[:1]  # Select classification and limit to 1 result
            ),
            trans_status=Subquery(
                lib_trans_status.objects.filter(
                    status_id=OuterRef('status_id')  # Join with lib_trans_status based on status_id
                ).values('status')[:1]  # Select status and limit to 1 result
            )
        ).values(
            'trans_id',
            'dataset_uid',
            'dataset_description',
            'dataset_date',
            'classification',
            'trans_status',
            'status_id',
            'process_id',
            'progress',
            'description',
            'row_count',
            'checkpoint_time',
            'time_added'
        )

        return JsonResponse(list(transactions_with_dataset_and_classification_info), safe=False)


        # if trans_id:
        #     tasks_list = transactions.objects.filter(trans_id=trans_id).values()  # Filter by trans_id
        # else:
        #     tasks_list = transactions.objects.all().values()  # Get all task records if no trans_id is provided
        
        # tasks_list = list(tasks_list)  # Convert QuerySet to a list
        # return JsonResponse(tasks_list, safe=False)  # Return as JSON response

class IndexTemplateView(TemplateView):
    template_name = "tasks_listing.html"

def test(request):
    # Filter transactions
    transactionsx = transactions.objects.filter(
        process_id__isnull=True,
        trans_id=10,
        status_id=4
    )

    # Check if the queryset contains any results and return the boolean
    return JsonResponse({'result': transactionsx.exists()})
    
    # transactions_with_dataset_and_classification_info = transactions.objects.filter(trans_id=4).annotate(
    #     dataset_uid=Subquery(
    #         datasets.objects.filter(dataset_id=OuterRef('dataset_id')).values('dataset_uid')
    #     ),
    #     classification=Subquery(
    #         lib_classification.objects.filter(classification_id=OuterRef('classification_id')).values('classification')
    #     )
    # ).values('trans_id', 'dataset_uid', 'classification')  # Include necessary fields here

    # return JsonResponse(list(transactions_with_dataset_and_classification_info), safe=False)


def task_cancel(request, process_id):
    try:
        # Create a Control instance with the Celery application
        control = Control(app=app)
        
        # Cancel the Celery task
        control.revoke(process_id, terminate=True)

        # Update the transaction status in a database transaction
        with transaction.atomic():
            transaction_record, _ = transactions.objects.get_or_create(process_id=process_id)
            canceled_status = lib_trans_status.objects.get(pk=4)  # Ensure this exists or handle DoesNotExist
            
            transaction_record.status_id = canceled_status
            transaction_record.process_id = None
            transaction_record.save()

        # Return JSON response indicating successful cancellation
        return JsonResponse({'cancelled': True, 'process_id': process_id})

    except lib_trans_status.DoesNotExist:
        # Handle missing status record
        return JsonResponse({'cancelled': False, 'error': 'Cancellation status not found.'})
    
    except Exception as e:
        # Log the exception for debugging purposes
        print(f"Error while canceling task {process_id}: {e}")
        # Return JSON response indicating failure
        return JsonResponse({'cancelled': False, 'error': str(e)})

@login_required
def dataset_listing(request):

    '''
        select 
        dedupe_app_datasets.dataset_status_id,
        dedupe_app_datasets.dataset_id,
        dedupe_app_datasets.dataset_uid,
        dedupe_app_datasets.description,
        dedupe_app_datasets.row_count,
        dedupe_app_datasets.from_roster,
        dedupe_app_datasets.time_added,
        dedupe_app_datasets.user_id,
        dedupe_app_datasets.dataset_status_id,
        dedupe_app_lib_dataset_status.dataset_status,
        count(dedupe_app_transactions.dataset_id) as task_count,
        AVG(dedupe_app_transactions.progress) as Average_progress

        from dedupe_app_datasets
        inner join dedupe_app_lib_dataset_status
        on dedupe_app_datasets.dataset_status_id = dedupe_app_lib_dataset_status.dataset_status_id
        inner join dedupe_app_transactions
        on dedupe_app_transactions.dataset_id = dedupe_app_datasets.dataset_id
        where 
        dedupe_app_datasets.user_id = 2 
        and dedupe_app_datasets.dataset_status_id <> 1
        and dedupe_app_transactions.status_id in (0,1,2,3,4,5)
        group by 
        dedupe_app_datasets.dataset_status_id,
        dedupe_app_datasets.dataset_id,
        dedupe_app_datasets.dataset_uid,
        dedupe_app_datasets.description,
        dedupe_app_datasets.row_count,
        dedupe_app_datasets.from_roster,
        dedupe_app_datasets.time_added,
        dedupe_app_datasets.user_id,
        dedupe_app_datasets.dataset_status_id,
        dedupe_app_lib_dataset_status.dataset_status;

    '''


    # Fetch the logged-in user's ID
    user_id = request.session.get('_auth_user_id')

    # Query datasets, excluding those with dataset_status_id = 1
    all_datasets = (
        datasets.objects.filter(
            user_id=user_id,  # Filter by user_id
            transactions__status_id__in=[0, 1, 2, 3, 4, 5]  # Filter by transactions status_id
        )
        .exclude(dataset_status_id=1)  # Exclude datasets with dataset_status_id = 1
        .select_related('dataset_status_id')  # Optimize join with lib_dataset_status
        .annotate(
            task_count=Count('transactions__dataset_id'),  # Count transactions per dataset
            average_progress=Avg('transactions__progress')  # Average progress for transactions
        )
        .values(
            'dataset_status_id',
            'dataset_id',
            'dataset_uid',
            'description',
            'row_count',
            'from_roster',
            'time_added',
            'user_id',
            'dataset_status_id__dataset_status',  # Get dataset_status from the related table
            'task_count',
            'average_progress'
        )
    )

    # Get the base URL
    base_url = request.build_absolute_uri('/')

    # Context for the template
    context = {
        'datasets': all_datasets,
        'menu': 'data_processing',
        'sub_menu': 'deduplicator',
        'module_name': 'DATASET CATALOGUE',
        'base_url': base_url
    }

    # Render the template with the context
    return render(request, 'datasets_listing.html', context)


def transactions_listing(request):
    user_id = request.session.get('_auth_user_id')
    all_datasets = datasets.objects.filter(user_id=2).order_by('-dataset_id')
   
    # all_tasks = transactions.objects.filter(user_id=user_id).order_by('-dataset_id')
    base_url = request.build_absolute_uri('/')  # Get the base URL
    
    all_tasks = transactions.objects.select_related('dataset_id', 'classification_id').exclude(
        is_deleted=1
    ).values(
        'dataset_id__dataset_uid',       # Access the dataset_uid field from the related datasets model
        'dataset_id__description',      # Access the description field from the related datasets model
        'dataset_id__time_added',
        'checkpoint_entry',             # transactions field
        'trans_id',                     # transactions field
        'dataset_id',                   # transactions field (raw ID)
        'description',
        'time_added',
        'progress',
        'status_id',
        'classification_id__classification'
    )

    context = {
        'datasets': all_datasets,
        'tasks': all_tasks,
        'menu': 'data_processing',
        'sub_menu': 'transactions',
        'module_name': 'TASK CATALOGUE',
        'base_url': base_url
    }
    # return HttpResponse(json.dumps({"context":context, 'success':True}), content_type='application/json')
    return render(request,'transaction_listing.html',context)


def pantawid_bene_finder(request):

    if request.POST:
        fname = request.POST.get('CRI_FIRST_NAME')
        mname = request.POST.get('CRI_MIDDLE_NAME')
        lname = request.POST.get('CRI_LAST_NAME')

        df_results = person_find(fname, mname, lname)
        json_res = df_results.to_json(orient='records')

        # context = {
        #     'json_res': json_res  
        # }
        # return render(request, 'person_finder.html', context) 
        return HttpResponse(json.dumps(json_res), content_type='application/json')

    context = {
        'menu': 'bene_finder',
        'module_name': 'Pantawid Beneficiary Finder'
    }
    return render(request,'person_finder.html',context)


def fetch_pantawid_roster(request):
    if request.method == 'POST':
        hh_id = '126509009-00126215'  # Example HH_ID or retrieve it from request.POST.get('hh_id')

        # Fetch roster entries from the database
        roster_entries = roster.objects.filter(HH_ID=hh_id).values(
            'ENTRY_ID', 'FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME', 'RELATION_TO_HH_HEAD', 'SEX', 'AGE', 'MEMBER_STATUS', 'BIRTHDAY'
        )

        # Convert QuerySet to a list and handle datetime serialization
        roster_entries_list = []
        for entry in roster_entries:
            if 'BIRTHDAY' in entry and isinstance(entry['BIRTHDAY'], datetime):
                entry['BIRTHDAY'] = entry['BIRTHDAY'].strftime('%Y-%m-%d')  # Convert to string
            roster_entries_list.append(entry)

        return HttpResponse(json.dumps(roster_entries_list), content_type='application/json')

    return HttpResponse(status=403)

def template_rectifier(request,request_id):

    if request.method == 'POST':
        # rectification goes here
        return HttpResponse(json.dumps({'success:',True}), content_type='application/json')

    df = pd.read_pickle(os.path.join(settings.JOBS_ROOT,request_id,"template.pkl"))
    suggestion = 0

    if count_columns_bykey(df,"name") > 1 or count_columns_bykey(df,"given"):
        # suggest column rectification
        suggestion = 0
    else:
        # suggest name splitting
        suggestion = 1

    context = {
        'columns': df.columns.tolist(),
        'task': request_id,
        'sample_data': df.head(5),
        'suggestion': suggestion,
        'options': {
            '0': 'Fix column names',
            '1': 'Split a column containing fullname of person into 3 separate columns (FML)'
        }
    }
    return render(request,'template_rectifier.html',context)

def dashboard1(request):
    return render(request,'dashboard1.html',{})



def task_view(request, trans_id):
    try:
        task = transactions.objects.filter(trans_id=trans_id).select_related('classification_id').first()
        # task = get_transaction_info(trans_id)
        if not task:
            return JsonResponse({"error": "Transaction not found"}, status=404)
        
        if task.classification_id.classification_id == 1:  # deduplication
            data  = {}
            return render(request, 'deduplicate_task.html', {
                'data': data,
                'task': task,
                'header_text': "Data deduplicator"
            })

        elif task.classification_id.classification_id == 2:  # pantawid name matching
            return render(request, 'deduplicate_task.html', {
                'task': task,
                'header_text': "Pantawid Name-matcher"
            })
        elif task.classification_id.classification_id == 3 and  task.status_id.status_id == 0:  # data incon
            # dataincon_task.html
            return render(request, 'dataincon_task.html', {
                'task': task,
                'header_text': "Data Inconsistencies Finder"
            })

        # if trans in data incon and status is finished
        elif task.classification_id.classification_id == 3 and task.status_id.status_id == 2: 
            observation_list , observation_count, total_affected_records = load_observations(trans_id)
            print('Observation Count: ', total_affected_records)
            # dataincon_task.html
            return render(request, 'dataincon_task.html', {
                'task': task,
                'header_text': "Data Inconsistencies Finder",
                'observations':observation_list,
                'observation_count':observation_count,
                'total_affected_records':total_affected_records,  
            })
            pass


        # Serialize task for JSON response
        task_data = {
            "trans_id": task.trans_id,
            "dataset_id": task.dataset_id_id,  # Reference to foreign key
            "description": task.description,
            "progress": task.progress,
            "status_id": task.status_id,
            "time_added": task.time_added.isoformat() if task.time_added else None,
            "classification": task.classification_id.classification,
            "threshold": task.threshold,
            "limit": task.limit,
            "scoring_method": task.scoring_method,
            "user_id": task.user_id,
            "row_count": task.row_count,
            "task_type": task.task_type,
        }

        return JsonResponse(task_data)

    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)


def export_user_view(request):
    task = export_user_task.delay()
    return HttpResponse(json.dumps({"task_id": task.id}), content_type='application/json')

def create_dir(dir_path):
    if not os.path.isdir(dir_path):
        os.mkdir(dir_path, 0o666)  

def rectify_columns(df, target_columns, correct_column='', similarity_threshold=95):
    df.columns = df.columns.str.upper()  # Standardize column names to uppercase
    matched_columns = set()

    for col in df.columns:
        for target in target_columns:
            if fuzz.ratio(col, target) >= similarity_threshold and col != correct_column:
                matched_columns.add(target)
                # Rename the column to the correct column name if a match is found
                df.rename(columns={col: correct_column}, inplace=True)
                break  # Exit the inner loop once a match is found to prevent overwriting
    
    # Return True if all target columns are matched and renamed
    
    return len(matched_columns) >0

def transactions_fuzzy_task_post(request):
    if request.method == "POST":
        dataset_id = request.POST.get('dataset', 0)
        description = request.POST.get('description', 'No description provided')
        classification_id = request.POST.get('transaction_classification', 0)
        threshold = request.POST.get('threshold', 90)
        limit = request.POST.get('limit', 5)
        scoring_method = request.POST.get('scoringMethod', 'ratio')
        user_id = request.session.get('_auth_user_id', 1)  # Fallback to 1 if session data is unavailable

        if dataset_id:
            try:
                # Get the datasets instance
                res = datasets.objects.get(dataset_id=dataset_id)

                # check if dataset is eligible for the task
                # only roster data can be used in dataincon task 
                if res.from_roster == 1 and classification_id == 3:
                    return HttpResponse(json.dumps(
                        {
                        'uid': res.dataset_uid, 
                        'success':False, 
                        'from_roster':True,
                        'message': 'Data-incon tasks are specifically designed to process Pantawid roster data and are incompatible with other data formats or sources.'
                        }), content_type='application/json')

                # dataincon: in-case the dataset is eligible, make a counter check by checking dataset columns
                if classification_id == 3:
                    is_di_eligible = False
                    dataset_path = os.path.join(settings.JOBS_ROOT,dataset_uid,"template.pkl")
                    if os.path.exists(dataset_df):
                        dataset_columns = pd.read_pickle(dataset_path).columns
                        di_required_column_lists = []
                        if dataset_columns in di_required_column_lists:
                            is_di_eligible = True
                        else:
                            return HttpResponse(json.dumps(
                                {
                                'uid': res.dataset_uid, 
                                'success':False, 
                                'from_roster':True,
                                'message': 'Pantawid Dataset Error: The dataset is missing one or more required columns. Please ensure all mandatory columns are included before proceeding.'
                                }), content_type='application/json')

                res2 = lib_classification.objects.get(classification_id=classification_id)

                # Create a new transaction with the datasets instance as the foreign key
                transaction = transactions.objects.create(
                    dataset_id=res,  # Assign the actual datasets instance here
                    description=description,
                    classification_id=res2,
                    threshold=threshold,
                    limit=limit,
                    scoring_method=scoring_method,
                    user_id=user_id,
                    time_added=timezone.now().strftime('%Y-%m-%d %H:%M:%S'),  # Set the current timestamp
                    progress=0,
                    status_id=0,  # Default to Pending
                    row_count=res.row_count
                )

                # Return the response with dataset_uid from the 'datasets' instance
                return HttpResponse(json.dumps({"uid": res.dataset_uid, 'success':True}), content_type='application/json')
            except datasets.DoesNotExist:
                raise Http404(f"Error processing the uploaded file: {str(e)}")



def insert_into_row(user_id, row: dict):
    try:
        u, _ = datasets.objects.get_or_create(dataset_id=row.get("dataset_id"))
        u.dataset_uid = row.get("dataset_uid")
        u.description = row.get("description", "")
        u.time_added = row.get("time_added") if row.get("time_added") else timezone.now()
        u.user_id = user_id
        u.row_count = row.get("row_count", 0)
        u.from_roster = row.get("from_roster", 0)
        u.save()
        return u
    except IntegrityError as e:
        print(f"Database integrity error: {e}")
    except ValidationError as e:
        print(f"Validation error: {e}")
    except KeyError as e:
        print(f"Key error: Missing key {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
    return None


def upload_template(request):
    dataset_uid = str(uuid.uuid4())
    form = ImportFileForm(request.POST, request.FILES)

    if form.is_valid():
        try:
            user_id = request.session.get('_auth_user_id', 1)

            task_status = 0

            # Save the uploaded file to a temporary location
            temp_file_path = in_memory_file_to_temp(form.cleaned_data['document_file'])
            file_path = os.path.join(settings.MEDIA_ROOT, temp_file_path)
            
            # Create a directory for this job
            job_dir = os.path.join("./jobs", dataset_uid)
            create_dir(job_dir)
            
            # Convert the uploaded Excel file to a pickle file
            df = pd.read_excel(file_path)
            pickle_path = os.path.join(job_dir, "template.pkl")

            #check if pickle contains columns {'FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME'}
            #if not, try to fix it, else tag as code 6

            if not {'FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME'}.issubset(df.columns):
                rectify_columns(df, {'FIRST_NAME', 'FNAME', 'GIVENNAME', 'FIRSTNAME'},'FIRST_NAME')
                rectify_columns(df, {'MIDDLE_NAME', 'MNAME', 'M.I.','MIDDLENAME','MIDDLE INITIAL','MIDDLE','MID_NAME','MIDNAME'},'MIDDLE_NAME')
                rectify_columns(df, {'LAST_NAME', 'LNAME', 'SURNAME', 'FIRSTNAME'}, 'LAST_NAME')            
                if not {'FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME'}.issubset(df.columns):
                    task_status = 6
                    print('Invalid template')

            insert_into_row(user_id=user_id,row={
                "dataset_uid": dataset_uid,
                "description": form.cleaned_data.get('description'),
                "time_added": timezone.now().strftime('%Y-%m-%d %H:%M:%S'),
                "row_count": df.shape[0]
            })

            #save job
            df.to_pickle(pickle_path)
            
            # Optionally delete the temp file if no longer needed
            if os.path.exists(file_path):
                os.remove(file_path)

            return HttpResponse(json.dumps({"request_id": dataset_uid, 'success':True}), content_type='application/json')
        except Exception as e:
            # Handle the error, log it if necessary
            raise Http404(f"Error processing the uploaded file: {str(e)}")
    else:
        raise Http404("Invalid form submission.")



@csrf_exempt
def dataincon_run_task(request): #import
    # pd.read_excel(os.path.join(settings.MEDIA_ROOT, filepath)).to_pickle(f"./jobs/{dataset_uid}/template.pkl")
    if request.method != 'POST':
        return HttpResponseBadRequest('Expected POST request')

    trans_id = request.POST.get('trans_id')
    # dataset_uid = get_dataset_id_by_trains_id(trans_id)

    # task_class = request.POST.get('task_class')
    # base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    task = dataincon_task.delay(trans_id=trans_id)

    #update the current task_guid

    #return data
    return HttpResponse(json.dumps({"task_id": task.id}), content_type='application/json')

@csrf_exempt
def deduplicator_run_task(request): #import
    if request.method != 'POST':
        return HttpResponseBadRequest('Expected POST request')

    trans_id = request.POST.get('trans_id')
    dataset_uid = get_dataset_id_by_trains_id(trans_id)


    task_class = request.POST.get('task_class')
    task = None


    if task_class == '1': #deduplication
        task = deduplicator_task.delay(trans_id=trans_id)
        print("Process_id [d]:",task.id)
    elif task_class == '2': #pantawid name-matcher
        # baseline_path = os.path.join(base_dir,f"./media/uploads/baseline.min.pkl")
        task = pantawid_namematcher_task.delay(trans_id=trans_id)
        print("Process_id [n]:",task.id)

    #update the current task_guid
    print(f'dataset_uid: {dataset_uid}  task_class: {task_class} ')
    u = transactions.objects.get(trans_id=trans_id)
    u.process_id = task.id
    u.save()
        
    #return data
    return HttpResponse(json.dumps({"task_id": task.id}), content_type='application/json')

def get_progress_view(request):
    task_id = request.GET.get("task_id")
    print('task_id:',task_id)
    if not task_id:
        return HttpResponse(json.dumps({"error": "Task ID not provided"}), content_type='application/json')

    progress = Progress(task_id)

    try:

        task_meta = progress.result._get_task_meta()
        return HttpResponse(json.dumps(progress.get_info()), content_type='application/json')
    except AttributeError:
        return HttpResponse(json.dumps({"error": "Invalid task ID or task not found"}), content_type='application/json')

def download_file_view(request):
    celery_result = AsyncResult(request.GET.get("task_id"))
    filepath = celery_result.result.get("data", {}).get("outfile")
    print(filepath)
    if os.path.exists(filepath):
        with open(filepath, 'rb') as fh:
            response = HttpResponse(fh.read(), content_type="application/ms-excel")
            outfile = os.path.basename(filepath)
            response['Content-Disposition'] = "attachment; filename=%s" % outfile
            return response
    raise Http404


def get_document_instance(request, trans_id):

    dataset_uid = get_dataset_id_by_trains_id(trans_id)

    # Get the file path (replace with your logic)
    file_path = os.path.join(settings.JOBS_ROOT, f"{dataset_uid}/result.xlsx")

    # Check if file exists
    if not os.path.exists(file_path):
        return HttpResponseNotFound('File not found')

    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    filename = f"result_{dataset_uid}_{timestamp}.xlsx"
    with open(file_path, 'rb') as f:
        response = HttpResponse(f.read(), content_type='application/ms-excel')
        response['Content-Disposition'] = f'attachment; filename="{filename}"'
        return response

def dataset_delete(request):

    if request.method != 'POST':
        return HttpResponseBadRequest('Expected POST request')

    dataset_uid = request.POST.get('dataset_uid')
    dataset = get_object_or_404(datasets, dataset_uid=dataset_uid)
    folder_path = os.path.join(settings.JOBS_ROOT,dataset_uid)

    try:
        if os.path.exists(folder_path):
            dataset.delete()
            shutil.rmtree(folder_path)

        return HttpResponse(json.dumps({
            "success": True,
            "redirect_url": "",
            "task_id": dataset.dataset_uid
            }), content_type='application/json')

    except Exception as e:
            return HttpResponse(json.dumps({
                "success": False,
                "task_id": dataset.dataset_uid,
                "message": "You cannot delete this dataset because it has associated tasks."
            }), content_type='application/json')


def task_delete(request):

    if request.method != 'POST':
        return HttpResponseBadRequest('Expected POST request')
    trans_id = request.POST.get('trans_id')
    trans = get_object_or_404(transactions, trans_id=trans_id)
    user_id = request.session.get('_auth_user_id')

    try:
        # shutil.rmtree(folder_path)
        trans.is_deleted = 1
        trans.date_deleted = datetime.now().strftime('%Y%m%d_%H%M%S')
        trans.deleted_by = user_id 
        trans.save()

        return HttpResponse(json.dumps({
            "success": True,
            "redirect_url": "",
            "task_id": trans.trans_id
            }), content_type='application/json')

    except Exception as e:
        return HttpResponseBadRequest(f"unable to delete file! {e}");

def task_reset(request, trans_id):
    try:
        folder_path = os.path.join(settings.JOBS_ROOT,trans_id)
        #remove checkpoint
        checkpoint_file = Path(os.path.join(folder_path,f"checkpoint.pkl"))
        result_file = Path(os.path.join(folder_path,f"result.xlsx"))

        # delete progress files if exists
        result_file.exists() and result_file.unlink()
        checkpoint_file.exists() and checkpoint_file.unlink()

        #update status        
        u, _ = transactions.objects.get_or_create(trans_id=trans_id)
        # u.status_id = 0
        u.status_id = lib_trans_status.objects.get(pk=0)
        u.process_id = None
        u.progress = 0
        u.checkpoint_entry = 0
        u.save()

        # Return JSON response indicating successful cancellation
        return JsonResponse({'success': True, 'trans_id': trans_id})
    except Exception as e:
        # Return JSON response indicating failure
        return JsonResponse({'success': False,'trans_id':trans_id, 'error': str(e)})

