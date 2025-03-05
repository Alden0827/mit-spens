from django.shortcuts import render, redirect
from django.contrib import messages

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

def user_login(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]

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
    return render(request, "blank.html", {'fullname': fullname})

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


def get_sample_data():
    data = [
        {
            "beneficiary_id": "B001",
            "philsys_id": "PH123456789",
            "senior_citizen_id": None,
            "biometric_fp": "FP123ABC",
            "first_name": "Juan",
            "middle_name": "Dela",
            "last_name": "Cruz",
            "birth_date": "1985-06-15",
            "sex": "m",
            "address_psgc": 101010,
            "address": "123 Barangay St., City, Province",
            "contact_number": "09123456789",
            "email": "juan@email.com",
            "status": 2,
            "date_registered": datetime(2023, 1, 10, 10, 30),
            "date_encoded": datetime(2023, 1, 10, 11, 0),
            "last_updated": datetime(2023, 1, 12, 14, 20),
            "last_updated_by": "admin",
            "is_pantawid": True,
            "pantawid_hhid": "HH123456",
            "pantawid_lowb": 2
        },
        {
            "beneficiary_id": "B002",
            "philsys_id": None,
            "senior_citizen_id": "SC987654321",
            "biometric_fp": None,
            "first_name": "Maria",
            "middle_name": None,
            "last_name": "Santos",
            "birth_date": "1960-09-22",
            "sex": "f",
            "address_psgc": 202020,
            "address": "456 Barangay St., City, Province",
            "contact_number": None,
            "email": "maria@email.com",
            "status": 3,
            "date_registered": datetime(2022, 5, 15, 9, 45),
            "date_encoded": datetime(2022, 5, 15, 10, 15),
            "last_updated": datetime(2023, 6, 10, 13, 10),
            "last_updated_by": "encoder1",
            "is_pantawid": False,
            "pantawid_hhid": None,
            "pantawid_lowb": None
        }
    ]

    return data

@login_required
def data_visualization(request):
    import pygwalker as pyg


    data = get_sample_data()
    df = pd.DataFrame(data)

    # Generate the Graphic Walker HTML
    pg_html = pyg.to_html(df)

    # Pass it to the template
    return render(request, "data_visualization.html", {"pg_html": pg_html})