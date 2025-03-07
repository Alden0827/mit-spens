import pandas as pd
import os
from django.conf import settings


def generate_sample_data():
    data = {
        'Name': ['John', 'Alice', 'Bob', 'Jane'],
        'Age': [25, 30, 35, 40],
        'City': ['New York', 'Los Angeles', 'Chicago', 'Houston']
    }

    # Create DataFrame
    df = pd.DataFrame(data)
    return df.to_dict('records')

def get_uploaded_xlsx_files():
    uploads_dir = os.path.join(settings.MEDIA_ROOT, 'uploads')
    files = os.listdir(uploads_dir)
    xlsx_files = [f for f in files if f.endswith('.xlsx')]
    return  {'xlsx_files': xlsx_files}

def get_uploaded_image_files():
    uploads_dir = os.path.join(settings.MEDIA_ROOT, 'uploads')
    files = os.listdir(uploads_dir)
    xlsx_files = [f for f in files if f.endswith(('.jpg','.png','.pdf'))]
    return  {'image_files': xlsx_files}