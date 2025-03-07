import pandas as pd  
import warnings
import re
from ..utils.dataset_helper import dataset_helper
from dedupe_app.models import transactions, lib_classification, datasets
import os
from django.conf import settings
#load data from dataset
warnings.filterwarnings("ignore")
import io
#%% dqa class
class data_incon_helper(object):

    def __init__(self):
        pass
    
    """
    Function: has_special_characters
    Syntax: has_special_characters(string)
    Description: Functions to check for special characters
    Return: boolean
    Example: df['has_sc_fullname'] = df['fullname'].apply(self.has_special_characters)
    """
    def has_special_characters(self, s):
        return bool(re.search(r'[^A-Za-z0-9 .-]', s))

    """
    Function: checkextname
    Syntax: checkextname(string)
    Description: Checks if the name contains common name extensions like 'Jr', 'Sr', 'III', etc.
    Return: boolean
    Example: df['has_ext_fullname'] = df['fullname'].apply(self.checkextname)
    """
    def checkextname(self, s):
        return any(ext in s for ext in ['Jr', 'Sr', 'III', 'II', 'JR', 'SR'])

    """
    Function: check_male_pregnancy
    Syntax: check_male_pregnancy(row)
    Description: Checks for male individuals marked with pregnancy status.
    Return: boolean
    Example: df['Male_Pregnancy_Inconsistent'] = df.apply(self.check_male_pregnancy, axis=1)
    """
    def check_male_pregnancy(self, row):
        # print(row['SEX'])
        return str(row['SEX']).upper() == 'MALE' and row['PREGNANCY_STATUS'] in ['1 - Yes', '2 - No']

    """
    Function: check_overage_pregnancy
    Syntax: check_overage_pregnancy(row)
    Description: Checks for individuals aged 50 or older marked as pregnant.
    Return: boolean
    Example: df['Overage_Pregnancy_Inconsistent'] = df.apply(self.check_overage_pregnancy, axis=1)
    """
    def check_overage_pregnancy(self, row):
        return pd.notnull(row['AGE']) and isinstance(row['AGE'], (int, float)) and row['AGE'] >= 50 and row['PREGNANCY_STATUS'] == '1 - Yes'

    """
    Function: check_underage_pregnancy
    Syntax: check_underage_pregnancy(row)
    Description: Checks for individuals aged 10 or younger marked as pregnant.
    Return: boolean
    Example: df['Underage_Pregnancy_Inconsistent'] = df.apply(self.check_underage_pregnancy, axis=1)
    """
    def check_underage_pregnancy(self, row):
        return pd.notnull(row['AGE']) and isinstance(row['AGE'], (int, float)) and row['AGE'] <= 10 and row['PREGNANCY_STATUS'] == '1 - Yes'

    """
    Function: check_age_grade_incon
    Syntax: check_age_grade_incon(row)
    Description: Check inconsistencies in grade level of monitored children (attending).
    Return: boolean
    Example: 
        df['GRADE_LEVEL'] = df['GRADE_LEVEL'].str.replace(' â€“ ', ' - ')#.str.replace('/ ', ' ').str.strip()
        df['Age_Grade_Incon'] = df.apply(
            lambda row: check_age_incon(row) if row['MONITORED_EDUC'] == 'YES' else None, axis=1
        )
                

    """
    def check_age_grade_incon(self, row):
        # Define expected age range mapping
        age_mapping = {
            'Kinder / Day care': '5-6',
            'Grade 1': '6-7',
            'Grade 2': '7-8',
            'Grade 3': '8-9',
            'Grade 4': '9-10',
            'Grade 5': '10-11',
            'Grade 6': '11-12',
            'Grade 7 - Junior High School': '12-13',
            'Grade 8 - Junior High School': '13-14',
            'Grade 9 - Junior High School': '14-15',
            'Grade 10 / 4th Year Junior High School': '15-16',
            'Grade 11 - Senior High School (SHS)': '16-17',
            'Grade 12 - Senior High School (SHS)': '17-18',
            'High School Graduate': None,
            '1st Year College / Vocational': '18-19',
            '2nd Year College / Vocational': '19-20',
            '3rd Year College / Vocational': '20-21',
            '4th Year College / Vocational': '21-22',
            'College Graduate': None,
            'Graduate Studies': None,
            'Senior High School Graduate': None,
            'Missing': None,
            'SPED NON GRADED': None,
            'Kinder-Elementary ADM/ALS': '5-6',
            'Junior High School(JHS) ADM/ALS': None,
            'Senior High School (SHS) ADM/ALS': None,
            'Day Care': '5-6',
        }
    
        expected_age_range = age_mapping.get(row['GRADE_LEVEL'])
        if expected_age_range:
            min_age, max_age = map(int, expected_age_range.split('-'))
            return  not (min_age <= int(row['AGE_ON_EDUC']) and int(row['AGE_ON_EDUC']) <= max_age)  # Updated to include upper limit
        return None  # For rows without expected age range
    
    """
    Function: find_data_incon
    Syntax: find_data_incon(df)
    Description: Finds data inconsistencies based on certain rules (e.g., male pregnancies, age-related pregnancy inconsistencies, etc.).
    Return: DataFrame with flagged inconsistencies, summary table
    Example: df, summary_table = self.find_data_incon(df)
    """
    def find_data_incon(self, df):
        
        df['has_sc_fullname'] = df['fullname'].apply(self.has_special_characters)
        df['has_ext_fullname'] = df['fullname'].apply(self.checkextname)
        df['Male_Pregnancy_Inconsistent'] = df.apply(self.check_male_pregnancy, axis=1)
        df['Overage_Pregnancy_Inconsistent'] = df.apply(self.check_overage_pregnancy, axis=1)
        df['Underage_Pregnancy_Inconsistent'] = df.apply(self.check_underage_pregnancy, axis=1)
        
        df['GRADE_LEVEL'] = df['GRADE_LEVEL'].str.replace(' â€“ ', ' - ')#.str.replace('/ ', ' ').str.strip()
        df['Age_Grade_Incon'] = df.apply(
            lambda row: self.check_age_grade_incon(row) if row['MONITORED_EDUC'] == True else False, axis=1
        )
        
        # summary_table = df.pivot_table(
        #     values=['has_sc_fullname', 'has_ext_fullname', 'Male_Pregnancy_Inconsistent', 'Overage_Pregnancy_Inconsistent', 'Underage_Pregnancy_Inconsistent'],
        #     index=['PROVINCE', 'MUNICIPALITY'],
        #     aggfunc=lambda x: (x == True).sum(),
        #     fill_value=0
        # )
        summary_table = df.pivot_table(
            values=['has_sc_fullname', 'has_ext_fullname', 'Male_Pregnancy_Inconsistent', 'Overage_Pregnancy_Inconsistent', 'Underage_Pregnancy_Inconsistent'],
            index=['PROVINCE'],
            aggfunc=lambda x: (x == True).sum(),
            fill_value=0
        )

        return df, summary_table



def get_transaction_info(trans_id):
    all_tasks = transactions.objects.filter(trans_id=trans_id).select_related(
        'dataset_id', 
        'classification_id'
    ).values(
        'dataset_id__dataset_uid',       
        'dataset_id__description',       
        'dataset_id__time_added',
        'checkpoint_entry',             
        'trans_id',                     
        'dataset_id',                   
        'description',
        'time_added',
        'progress',
        'status_id', 
        'classification_id__classification'
    )

    # Convert QuerySet to a list of dictionaries
    all_tasks_list = list(all_tasks)

    # Return the response as JSON
    return all_tasks_list

def get_dataset_id_by_trains_id(trans_id):
    trans_info = get_transaction_info(trans_id)
    return trans_info[0].get('dataset_id__dataset_uid')


def load_observations(trans_id):
    print('Loading Observertions!')
    try:
        # Attempt to load the DataFrame from the pickle file
        dataset_uid = get_dataset_id_by_trains_id(trans_id)
        file = f"di_{dataset_uid}_{trans_id}.pkl"
        print(dataset_uid, trans_id, os.path.join(settings.JOBS_ROOT,dataset_uid, file))
        df = pd.read_pickle(os.path.join(settings.JOBS_ROOT,dataset_uid, file))
    except FileNotFoundError:
        # Return empty list and 0 if the file is not found
        print('Observertions not found!')
        return [], 0, 0
    except Exception as e:
        print('Error',e)
        # Handle any other errors (e.g., corrupted pickle file)
        return [], 0, 0

    labels = [
        'Male_Pregnancy_Inconsistent',
        'Overage_Pregnancy_Inconsistent',
        'Underage_Pregnancy_Inconsistent',
        'has_sc_fullname',
        'has_ext_fullname',
        'Age_Grade_Incon',
        'summary'
    ]
    
    # Descriptions for each label
    descriptions = {
        'Male_Pregnancy_Inconsistent': 'Male beneficiaries listed as pregnant.',
        'Overage_Pregnancy_Inconsistent': 'Pregnant beneficiaries who are overage.',
        'Underage_Pregnancy_Inconsistent': 'Pregnant beneficiaries who are underage.',
        'has_sc_fullname': 'Beneficiaries names containing special characters.',
        'has_ext_fullname': 'Names with extensions (e.g., Jr., Sr.) that should be placed in a separate column.',
        'Age_Grade_Incon': 'Inconsistencies between students\' grades and their ages.',
        'summary': 'Summary'
    }
    
    observation_list = []
    observation_count = 0
    total_affected_records = 0

    print('Initializing observations:')
    for label in labels:
        # Skip 'summary' or check if label exists and has data

        if label == 'summary':
            continue

        # if label == 'summary' or label not in df or df[label].empty:
        #     print(f'   - {label} -  No Findings!')
        #     continue

        observation_count += 1
        table_html = df[label].head(5).to_html(classes='table table-sm', border=0, escape=False)
        table_html = table_html.replace('<table', '<table style="width: 100%; table-layout: auto;"')
        table_html = table_html.replace('<td>', '<td class="d-none d-sm-table-cell">')

        # Gather table info
        buffer = io.StringIO()
        df[label].info(buf=buffer)
        info_string = buffer.getvalue()
        html_info = f"<pre>{info_string}</pre>"
        row_count = len(df[label])
        total_affected_records += row_count
        print(df[label])
        observation_list.append({
            'num': observation_count,
            'label': label,
            'description': descriptions.get(label, 'No description available'),
            'data': table_html,
            'row_count': row_count,
            'info': html_info
        })
    
    return observation_list, observation_count, total_affected_records


if __name__ == "__main__":
    
    dsl = dataset_helper(subset=1000)
    df = dsl.load_from_file(path='./datasets/DQA Training sample roster data_revised.csv')
    df.columns = df.columns.str.upper()
    df['fullname'] = (df['FIRST_NAME'].fillna('') + ' ' + df['MIDDLE_NAME'].fillna('') + ' ' + df['LAST_NAME'].fillna('')).str.replace(r'\s+', ' ', regex=True).str.strip()

    dqa = data_incon_helper()
    df = dqa.find_data_incon(df)
 