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