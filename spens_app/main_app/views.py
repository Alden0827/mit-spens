from django.conf import settings
import base64
from .models import Picture
from django.http import JsonResponse
from django.db.models.functions import Coalesce
from django.db.models import OuterRef, Subquery, Value
from django.utils.timezone import localtime

from django.shortcuts import render, redirect
from django.contrib import messages
import os
#for user management
from django.contrib.auth.decorators import login_required
from .forms import RegistrationForm
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User

#for audit trails
from django.db.models.signals import pre_save
# from django.dispatch import receiver

#data analysis
from datetime import datetime
import pandas as pd

#for droidcam
import requests
from django.http import HttpResponse

def user_login(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]
        screen_width = int(request.POST.get("screen_width", 1024)) 

        # First, try to find the user based on the provided username
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            user = None

        if user is None:
            messages.error(request, "Invalid username or password")
        else:
            # Now manually check if the user is active
            if not user.is_active:
                messages.error(request, "Your account is not activated yet. Please contact the administrator.")
                # return redirect('for_activation')  # Redirect back to the login page
                return render(request, "users/login.html")
                pass

            # If the user exists and is active, authenticate the password
            user = authenticate(request, username=username, password=password)
            
            if user is not None:
                # Successful authentication
                login(request, user)
                
                # if viewed in mobile
                if screen_width <= 768:
                    return redirect("mobile")

                return redirect("main_page")  # Redirect to your main page or dashboard
            else:
                # Invalid password
                messages.error(request, "Invalid username or password")

    return render(request, "users/login.html")


def user_registration(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)  # Do not save the user yet
            user.is_active = False  # Set the user as inactive
            user.save()  # Now save the user to the database
            messages.success(request, 'Your account has been created! Please inform the system administrator to activate your account.')
            return redirect('for_activation')  # Redirect to activation page or info page
        else:
            messages.error(request, 'There was an error with your registration form.')
            print(form.errors)  # You can print errors to the console for debugging
    else:
        form = RegistrationForm()

    return render(request, 'users/registration.html', {'form': form})

def for_activation(request):
    return render(request, 'users/for_activation.html')

def get_fullname(request):
    first_name = request.user.first_name
    last_name = request.user.last_name
    return first_name + ' ' + last_name

@login_required
def main_page(request):
    first_name = request.user.first_name
    last_name = request.user.last_name
    fullname = first_name + ' ' + last_name
    return render(request, "index.html", {'fullname': fullname})

@login_required
def bdm_page(request):
    first_name = request.user.first_name
    last_name = request.user.last_name
    fullname = first_name + ' ' + last_name
    return render(request, "profiling.html", {'fullname': fullname})

@login_required
def waitlist_page(request):
    first_name = request.user.first_name
    last_name = request.user.last_name
    fullname = first_name + ' ' + last_name
    return render(request, "waitlist.html", {'fullname': fullname})

@login_required
def empty_page(request):
    first_name = request.user.first_name
    last_name = request.user.last_name
    fullname = first_name + ' ' + last_name
    return render(request, "blank.html", {'fullname': fullname})



@login_required
def user_activation():
    user = User.objects.get(username="username_here")
    user.is_active = True
    user.save()

@login_required
def user_logout(request):
    logout(request)
    return redirect('user_login') 



@login_required
def update_beneficiary(request, beneficiary_id):
    beneficiary = get_object_or_404(Beneficiary, pk=beneficiary_id)

    if request.method == "POST":
        beneficiary.name = request.POST["name"]
        beneficiary.age = request.POST["age"]
        beneficiary.address = request.POST["address"]
        beneficiary.last_updated_by = request.user  # Track user who made the change
        beneficiary.save()

        return redirect("beneficiary_list")  # Redirect to the list view

    return render(request, "update_beneficiary.html", {"beneficiary": beneficiary})

@login_required
def get_sample_data():
    '''
        SELECT
            `tbl_beneficiaries`.`sex`
            , `tbl_region`.`region_name`
            , `tbl_province`.`province_name`
            , `tbl_municipality`.`municipality_name`
            , `tbl_barangay`.`barangay_name`
            , `tbl_beneficiaries`.`status`
            , COUNT(`tbl_beneficiaries`.`id`)
        FROM
            `imt_spens`.`tbl_beneficiaries`
            INNER JOIN `imt_spens`.`tbl_barangay` 
                ON (`tbl_beneficiaries`.`address_psgc_id` = `tbl_barangay`.`id`)
            INNER JOIN `imt_spens`.`tbl_municipality` 
                ON (`tbl_barangay`.`municipality_id` = `tbl_municipality`.`id`)
            INNER JOIN `imt_spens`.`tbl_province` 
                ON (`tbl_municipality`.`province_id` = `tbl_province`.`id`)
            INNER JOIN `imt_spens`.`tbl_region` 
                ON (`tbl_province`.`region_id` = `tbl_region`.`id`)
        GROUP BY `tbl_beneficiaries`.`sex`, `tbl_region`.`region_name`, `tbl_province`.`province_name`, `tbl_municipality`.`municipality_name`, `tbl_barangay`.`barangay_name`, `tbl_beneficiaries`.`status`;
    
    '''
    from .models import Beneficiary
    from django.db.models import Count

    beneficiaries = Beneficiary.objects.select_related(
        "address_psgc__municipality__province__region"
    ).values(
        "sex",
        "address_psgc__municipality__province__region__region_name",  
        "address_psgc__municipality__province__province_name",
        "address_psgc__municipality__municipality_name",
        "address_psgc__barangay_name",  
        "status"
    ).annotate(count=Count("id"))

    data = [
        {
            "sex": b["sex"],
            "region": b["address_psgc__municipality__province__region__region_name"],
            "province": b["address_psgc__municipality__province__province_name"],
            "municipality": b["address_psgc__municipality__municipality_name"],
            "barangay": b["address_psgc__barangay_name"],
            "status": b["status"],
            "count": b["count"]
        }
        for b in beneficiaries
    ]
    return data
    # return data
@login_required
def data_visualization(request):
    import pygwalker as pyg

    data = get_sample_data()

    df = pd.DataFrame(data)

    # Generate the Graphic Walker HTML
    pg_html = pyg.to_html(df)

    # Pass it to the template
    return render(request, "data_visualization.html", {"pg_html": pg_html})

@login_required
def mobile(request):
    # use https to make it work on android.
    fullname = get_fullname(request)
    from .models import Beneficiary
    '''
    SELECT
        `tbl_beneficiaries`.`id`
        , `tbl_beneficiaries`.`first_name`
        , `tbl_beneficiaries`.`middle_name`
        , `tbl_beneficiaries`.`last_name`
        , `tbl_pictures`.`beneficiary_id` AS `pic_id`
    FROM
        `imt_spens`.`tbl_pictures`
        RIGHT JOIN `imt_spens`.`tbl_beneficiaries` 
            ON (`tbl_pictures`.`beneficiary_id` = `tbl_beneficiaries`.`id`)
    WHERE (`tbl_beneficiaries`.`status` =1);
    '''

    waitlisted_beneficiaries = Beneficiary.objects.filter(status=1).annotate(
        pic_id=Coalesce(Picture.objects.filter(beneficiary_id=OuterRef('id')).values('beneficiary_id')[:1], Value(None))
    ).values("id", "first_name", "middle_name", "last_name", "pic_id")


    return render(request, "camera.html", {"beneficiaries": waitlisted_beneficiaries, "fullname":fullname})


def get_beneficiary_picture(request, beneficiary_id):
    sp_id = beneficiary_id #request.GET.get('id')  # Get the Beneficiary ID from the request
    if not sp_id:
        return HttpResponse("No Beneficiary ID provided", status=400)

    # Construct the expected filename
    filename = f"{sp_id}.jpg"  # Assuming saved images are stored as sp_id.jpg
    image_path = os.path.join(settings.MEDIA_ROOT, "bene/pics", filename)

    if os.path.exists(image_path):
        with open(image_path, "rb") as image_file:
            return HttpResponse(image_file.read(), content_type="image/jpeg")
    else:
        return HttpResponse("Image not found", status=404)


def save_picture(request):
    if request.method == "POST":
        UPLOAD_DIR = os.path.join(settings.MEDIA_ROOT, 'bene/pics')
        beneficiary_id = request.POST.get("beneficiary_id")
        image_data = request.POST.get("image")

        if not image_data:
            return JsonResponse({"status": "error", "message": "No image data received"}, status=400)

        try:
            # Since the data is raw base64, set extension manually
            ext = "jpg"  # Default to JPG
            filename = f"{beneficiary_id}.{ext}"
            image_path = os.path.join(UPLOAD_DIR, filename)
            os.makedirs(os.path.dirname(image_path), exist_ok=True)

            # Decode and save the image
            with open(image_path, "wb") as f:
                f.write(base64.b64decode(image_data))

            file_size = os.path.getsize(image_path)
            mimetype = f"image/{ext}"

            # Save in database
            Picture.objects.create(
                filename=filename,
                size=file_size,
                mimetype=mimetype,
                format=ext,
                beneficiary_id=beneficiary_id
            )

            return JsonResponse({"status": "success", "beneficiary_id": beneficiary_id})

        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=400)

    return JsonResponse({"status": "error", "message": "Invalid request"}, status=400)

def proxy_droidcam(request):
    url = "http://172.31.196.103:4747/overide"  # Your DroidCam URL
    response = requests.get(url, stream=True)

    if response.status_code == 200:
        print('Doidcam connected!')
        return HttpResponse(response.content, content_type="image/jpeg")
    else:
        print('Failed!')
        return HttpResponse("Failed to load DroidCam", status=500)