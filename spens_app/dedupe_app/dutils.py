import pandas as pd
from django.core.files.base import ContentFile
from django.core.files.storage import default_storage
import sqlite3
from rapidfuzz import fuzz
from django.conf import settings
import numpy as np

class DataframeUtil(object):
    @staticmethod
    def get_validated_dataframe(path: str) -> pd.DataFrame:
        df = pd.read_excel(path, dtype=str)
        df.columns = df.columns.str.lower()
        df = df.fillna(-1)
        return df.mask(df == -1, None)


def in_memory_file_to_temp(in_memory_file):
    path = default_storage.save('tmp/%s' % in_memory_file.name, ContentFile(in_memory_file.read()))
    return path


def soundex(name):
    """Compute the soundex value of a given name."""
    if not name:
        return ""
    
    soundex = ""
    
    # Step 1: Save the first letter
    first_letter = name[0].upper()

    # Step 2: Replace consonants with digits
    mappings = {
        'BFPV': '1',
        'CGJKQSXZ': '2',
        'DT': '3',
        'L': '4',
        'MN': '5',
        'R': '6'
    }
    
    for char in name[1:].upper():
        for key in mappings:
            if char in key:
                code = mappings[key]
                if soundex and soundex[-1] == code:
                    continue
                soundex += code

    # Step 3: Remove all vowels and 'H', 'W' (except the first letter)
    soundex = first_letter + soundex

    # Step 4: Append zeros to the end to ensure a length of 4
    soundex = soundex[:4].ljust(4, '0')

    return soundex

def person_find(CRI_FIRST_NAME, CRI_MIDDLE_NAME, CRI_LAST_NAME):
    """Find matching records in the SQLite database using the Soundex algorithm."""
    
    # Connect to the SQLite database
    connection = sqlite3.connect(settings.DATABASE_PATH)

    # Register the soundex function with the connection
    connection.create_function("soundex", 1, soundex)

    # Create a cursor object
    cursor = connection.cursor()

    # Construct the query
    query_part1 = f"""
    SELECT * FROM tbl_roster 
    WHERE soundex(FIRST_NAME) = soundex('{CRI_FIRST_NAME}') 
    """
    query_part2_a = f"""
    AND soundex(MIDDLE_NAME) = soundex('{CRI_MIDDLE_NAME}') 
    """        
    query_part2_b = f"""
    AND soundex(substr(MIDDLE_NAME,1,1)) = soundex('{CRI_MIDDLE_NAME}') 
    """        
    query_part3 = f"""
    AND soundex(LAST_NAME) = soundex('{CRI_LAST_NAME}')
    """

    if len(CRI_MIDDLE_NAME) == 0:
        print('[mode 1] ', end='')
        query = query_part1 + query_part3
    elif len(CRI_MIDDLE_NAME) <= 2:
        print('[mode 2] ', end='')
        query = query_part1 + query_part2_b + query_part3
    else:
        print('[mode 3] ', end='')
        query = query_part1 + query_part2_a + query_part3

    cursor.execute(query)
    print('Searching...')

    # Fetch all results
    results = cursor.fetchall()

    # Load results into a pandas DataFrame
    columns = [description[0] for description in cursor.description]
    df = pd.DataFrame(results, columns=columns)

    # Combine the name columns into a single string
    df['FULL_NAME'] = df['FIRST_NAME'] + ' ' + df['MIDDLE_NAME'] + ' ' + df['LAST_NAME']

    # Calculate similarity
    df['SIMILARITY'] = df['FULL_NAME'].apply(lambda x: fuzz.ratio(x, f"{CRI_FIRST_NAME} {CRI_MIDDLE_NAME} {CRI_LAST_NAME}"))

    # Sort by similarity
    df_sorted = df.sort_values(by='SIMILARITY', ascending=False).reset_index(drop=True)

    # print(df_sorted[['ENTRY_ID', 'FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME', 'SIMILARITY']])

    # Close the cursor and connection
    cursor.close()
    connection.close()

    return df_sorted


# function for counting the number of columns by substring. 
# for the use of template rectification
def count_columns_bykey(df, substring):
    matching_columns = df.columns.map(lambda x: substring.lower() in x.lower())
    boolean_array = np.array(matching_columns)
    # Count the number of True values in the matching_columns
    return boolean_array.sum()