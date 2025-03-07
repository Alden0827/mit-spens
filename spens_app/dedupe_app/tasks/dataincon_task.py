import os
import shutil
import tempfile
from os import name
from re import template
import pandas as pd
import pickle
from celery_progress.backend import ProgressRecorder
from package import celery_app
from django.conf import settings
# from django.contrib.auth.models import User
from django.http import Http404, HttpResponse
from django.utils import timezone
from openpyxl import Workbook, load_workbook

from ..dutils import DataframeUtil
from .base import BaseTask
from datetime import datetime, timedelta

import json

from rapidfuzz.fuzz import ratio
from rapidfuzz import process, fuzz
import uuid
import numpy as np
import time
import math
import sys
from django.core.exceptions import ObjectDoesNotExist
from ..models import datasets, transactions
from os.path import exists
from datetime import datetime
from colorama import init, Fore, Back, Style
import os

from ..utils.dataset_helper import dataset_helper
from ..utils.data_incon_helper import data_incon_helper, load_observations, get_dataset_id_by_trains_id, get_transaction_info

class CommenceDataInconTask(BaseTask):
    name = "CommenceDataInconTask"

    def update_row(self,row: dict) -> transactions:
        try:
            u = transactions.objects.get(trans_id=row.get("trans_id"))
        except transactions.DoesNotExist:
            raise ValueError(f"User with trans_id# {row.get('trans_id')} does not exist.")
        
        u.checkpoint_entry = row.get("checkpoint_entry")
        u.checkpoint_time = row.get("checkpoint_time")
        u.progress = row.get("progress")
        u.status_id = row.get("status")
        u.save()
        
        return u

    def update_progress(self,progress_recorder, index,start_time,total_record):
        # Calculate estimated time remaining
        current_time = datetime.now()
        elapsed_time = current_time - start_time
        time_per_record = elapsed_time / (index + 1)
        estimated_remaining_time_seconds = (total_record - index - 1) * time_per_record.total_seconds()

        # Format remaining time into hh:mm:ss
        remaining_time = timedelta(seconds=estimated_remaining_time_seconds)
        hours = remaining_time.seconds // 3600
        minutes = (remaining_time.seconds % 3600) // 60
        seconds = remaining_time.seconds % 60

        # Create formatted remaining time string
        formatted_remaining_time = "{:02d}:{:02d}:{:02d}".format(hours, minutes, seconds)

        # Send formatted remaining time as part of progress update
        progress_recorder.set_progress(
            index + 1, 
            total=total_record, 
            description=json.dumps({
                'sta':formatted_remaining_time,
                'msg':'success'
                })
        )

    def run(self, *args, **kwargs):
        progress_recorder = ProgressRecorder(self)
        
        trans_id = kwargs.get('trans_id')
        dataset_uid = get_dataset_id_by_trains_id(trans_id)
        progress_recorder.set_progress(
            1,
            total=100,
            description=json.dumps({'msg': 'Commencing', 'sta': '00:00:00'}),
        )

        parent_folder = os.path.join(settings.JOBS_ROOT,dataset_uid)
        file_path = os.path.join(settings.JOBS_ROOT,dataset_uid,"template.pkl")

        address_cols = ['REGION', 'PROVINCE', 'MUNICIPALITY', 'BARANGAY']
        name_cols = ['HH_ID', 'ENTRY_ID', 'FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME', 'EXT_NAME', 'GRANTEE', 'BIRTHDAY', 'SEX']
        preg_cols = ['PREGNANCY_STATUS']
        cct_cols = ['CCT_TYPE']

        try:
            # Load CSV
            df = pd.read_pickle(file_path)
            df['fullname'] = (
                df['FIRST_NAME'].fillna('') + ' ' + df['MIDDLE_NAME'].fillna('') + ' ' + df['LAST_NAME'].fillna('')
            ).str.replace(r'\s+', ' ', regex=True).str.strip()

            # Process inconsistencies
            dqa = data_incon_helper()
            processed_df, summary_table = dqa.find_data_incon(df)

            # Ensure columns exist
            # required_cols = address_cols + name_cols + preg_cols + cct_cols
            required_cols = name_cols + preg_cols 
            available_cols = list(set(required_cols).intersection(processed_df.columns))

            # Query inconsistencies
            data = {
                'Male_Pregnancy_Inconsistent': processed_df.query('`Male_Pregnancy_Inconsistent` == True')[available_cols],
                'Overage_Pregnancy_Inconsistent': processed_df.query('`Overage_Pregnancy_Inconsistent` == True')[available_cols],
                'Underage_Pregnancy_Inconsistent': processed_df.query('`Underage_Pregnancy_Inconsistent` == True')[available_cols],
                'has_sc_fullname': processed_df.query('`has_sc_fullname` == True')[available_cols],
                'has_ext_fullname': processed_df.query('`has_ext_fullname` == True')[available_cols],
                'Age_Grade_Incon': processed_df.query('`Age_Grade_Incon` == True')[available_cols],
                'summary': summary_table,
            }

            # Save results to pickle
            output_path = os.path.join(parent_folder, f'di_{dataset_uid}_{trans_id}.pkl')
            print('Saving:',output_path)
            with open(output_path, 'wb') as f:
                pickle.dump(data, f)

            print(f"Data inconsistencies saved to {output_path}")

            progress_recorder.set_progress(
                100,
                total=100,
                description=json.dumps({'sta': '', 'msg': 'finished'}),
            )

        except KeyError as e:
            print(f"Column selection error: {e}")
        except Exception as e:
            print(f"Error processing dataset: {e}")

        row_data = {
            "trans_id": trans_id,
            "checkpoint_entry": 100,
            "checkpoint_time": datetime.now(),
            "progress": 100,
            "status": 2, #Finished
            "process_id":None
        }

        try:
            update_result = self.update_row(row_data)
            print("transactions updated successfully:", update_result)
        except ValueError as e:
            print("Error:", e)

        return {
            "detail": "Task Finished!"
        }


@celery_app.task(bind=True, base=CommenceDataInconTask)
def dataincon_task(self, *args, **kwargs):
    # Pass task_id to the task's run method
    return super(type(self), self).run(*args, **kwargs)