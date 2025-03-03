from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .forms import RegistrationForm
from django.contrib.auth.models import User


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
    return render(request, "index.html")

@login_required
def user_activation():
    user = User.objects.get(username="username_here")
    user.is_active = True
    user.save()