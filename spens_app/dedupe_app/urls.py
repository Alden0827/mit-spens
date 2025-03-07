# myapp/urls.py
from django.urls import path
from . import views
from .views import IndexTemplateView
from .views import TasksListView

urlpatterns = [

    # path("test", views.test, name="test"),


    path("", views.dataset_listing, name="dataset_listing"),


    path("transactions", views.transactions_listing, name="transactions_listing"),
    path("transactions/new", views.transactions_fuzzy_task_post, name="new_fuzzy_task_post"),

    path('d/task/<str:trans_id>/', views.task_view, name='task_view'),
    path('d/task/cancel/<str:process_id>/', views.task_cancel, name='task_cancel'),
    path('d/task/reset/<str:trans_id>/', views.task_reset, name='task_reset'),
    path("d/upload/template", views.upload_template, name="upload-template"),
    path("celery/progress", views.get_progress_view, name="progress"),
    path("api/d/result/filexxxx", views.download_file_view, name="download"), 
    path("dashboard", views.dashboard1, name="dashboard"),

    path('test/', views.test, name='dqatest'),    


    path("pantawid/beneficiay/finder", views.pantawid_bene_finder, name="pantawid_bene_finder"),
    path("pantawid/beneficiay/roster", views.fetch_pantawid_roster, name="fetch_pantawid_roster"),
    path("task/template/rectification/<str:request_id>", views.template_rectifier, name="template_rectifier"),


    path('api/d/result/file/<str:trans_id>/', views.get_document_instance, name='get_document_instance'),   #downloading of dedupe result
    path('task/delete', views.task_delete, name='task_delete'),
    path('dataset/delete', views.dataset_delete, name='dataset_delete'),
    

    path('api/d/task/info/', TasksListView.as_view(), name='tasks-info'),
    path("api/d/task/run", views.deduplicator_run_task, name="deduplicator_run_task"),
    path("api/di/task/run", views.dataincon_run_task, name="dataincon_run_task"),


    path("export-user", views.export_user_view, name="export"),
   ]