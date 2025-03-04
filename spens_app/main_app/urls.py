from django.urls import path
from .views import user_login, main_page
from . import views
from django.contrib.auth.views import LogoutView

urlpatterns = [
    path("login/", views.user_login, name="user_login"),
    path("registration/", views.user_registration, name="user_registration"),  # Registration URL
    path("for_activation/", views.for_activation, name="for_activation"),  # Activation page URL
    path('logout/', LogoutView.as_view(next_page='/login/'), name='logout'),  # Redirect to the login page after logout
    path("", views.main_page, name="main_page"),
    path("profiling/", views.bdm_page, name="bdm_page"),
    path("waitlist/", views.waitlist_page, name="waitlist_page"),


]

