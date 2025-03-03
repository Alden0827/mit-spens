from celery import Celery
from flask_sqlalchemy import SQLAlchemy
from models import *
import pandas as pd
import time
from datetime import datetime
# import deduplicator_helper
# ---------------------------------

import json
import os            
# from thefuzz import fuzz, process  
from rapidfuzz import process, fuzz#, utils
import time
import pickle
import fuzzy
from colorama import Fore #, Back, Style, init

#load data from dataset
from dataset_helper import dataset_helper as ds
from data_helper import data_helper as dh
import unicodedata




# ---------------------------------


celery = Celery('flaskapi2_app', broker='redis://localhost:8095/0')
celery.conf.update(result_backend='redis://localhost:8095/0')



# @celery.task(name="tasks.deduplicate")  # Explicitly name the task
@celery.task(name="tasks.deduplicate", bind=True)
def deduplicate(self, threshold, subset=1000):
    from app import app, db  # Import inside function to avoid circular imports
    
    # threshold = request.get_json().get('threshold')

    with app.app_context():

        def get_roster(subset):
            from app import db
            records = (
                db.session.query(
                    TblRoster.hh_id,
                    TblRoster.entry_id,
                    TblRoster.province,
                    TblRoster.municipality,
                    TblRoster.barangay,
                    TblRoster.birthday,
                    db.func.concat_ws(' ', TblRoster.first_name, TblRoster.middle_name, TblRoster.last_name).label('fullname')
                )
                .limit(subset)
                .all()
            )

            data = [
                {
                    'fullname': r.fullname,
                    'hh_id': r.hh_id,
                    'entry_id': r.entry_id,
                    'province': r.province,
                    'municipality': r.municipality,
                    'barangay': r.barangay,
                    'birthday': r.birthday
                }
                for r in records
            ]

            status_code=200
            db.session.close()

            return data, status_code
        # -------------------------------------

        def create_task(number_of_rows: int):
            """
            Creates a new deduplication task and returns its ID.
            
            :param number_of_rows: The number of rows involved in the task.
            :return: Tuple (success: bool, task_id or error message)
            """
            try:
                # Ensure number_of_rows is a positive integer
                if not isinstance(number_of_rows, int) or number_of_rows <= 0:
                    return False, "Invalid number_of_rows. Must be a positive integer."

                # Create a new task entry
                new_task = TblDedupeTasks(
                    date_started=datetime.now(),
                    date_complete=None,  # Task is not yet completed
                    number_of_rows=number_of_rows
                )

                # Add to session and commit
                db.session.add(new_task)
                db.session.commit()

                return True, new_task.task_id  # Return task ID
            
            except Exception as e:
                print(f'Unexpected error: {str(e)}')
                db.session.rollback()  # Rollback in case of an error
                return False, str(e)  # Return error message

        def insert_dedupe_results(task_id, df):
            """
            Inserts deduplication results into the database.

            :param task_id: The ID of the deduplication task.
            :param df: The Pandas DataFrame containing results.
            :return: Tuple (success: bool, message)
            """
            try:
                if df.empty:
                    return False, "No duplicates found to insert."

                # Ensure required columns exist
                required_cols = {'entry_id', 'DUPLICATE_ID', 'NAME_SIMILARITY', 'DOB_SCORE', 'ADDRESS_SCORE', 'FINAL_SCORE'}
                if not required_cols.issubset(df.columns):
                    return False, "Missing required columns in DataFrame."

                # Define tag categories based on FINAL_SCORE
                def classify_tag(score):
                    if score >= 95:
                        return 'validated_duplicate'
                    elif score >= 90:
                        return 'high-possibility'
                    elif score >= 85:
                        return 'low-possibility'
                    else:
                        return 'no-match'

                # Create list of TblDedupeResults objects
                dedupe_results = [
                    TblDedupeResults(
                        task_id=task_id,
                        entry_id=int(row['entry_id']),
                        duplicate_id=int(row['DUPLICATE_ID']),
                        similarity_score=float(row['NAME_SIMILARITY']),
                        dob_score=float(row['DOB_SCORE']),
                        address_score=float(row['ADDRESS_SCORE']),
                        final_score=float(row['FINAL_SCORE']),
                        tag=classify_tag(float(row['FINAL_SCORE']))
                    )
                    for _, row in df[df['DUPLICATE_ID'] > 0].iterrows()
                ]

                # Bulk insert
                db.session.bulk_save_objects(dedupe_results)
                db.session.commit()

                return True, f"Inserted {len(dedupe_results)} records successfully."
            
            except Exception as e:
                print(f'Unexpected error: {str(e)}')
                db.session.rollback()
                return False, str(e)

        # -------------------------------------


        class deduplicator_helper(object):

            def normalize_ascii(self,text):
                return ''.join(
                    c for c in unicodedata.normalize('NFKD', text) if ord(c) < 128
                )

            def __init__(self, threshold=90, checkpoint_segment=300, update_state=None):
                self.threshold = threshold
                self.checkpoint_file = 'dedupe_checkpoint.pkl'
                self.checkpoint_segment = checkpoint_segment
                self.update_state = update_state

            def save_checkpoint(self, df, current_index, dedupe_summary):
                """Save the current state of deduplication process to a checkpoint file."""
                with open(self.checkpoint_file, 'wb') as f:
                    pickle.dump((df, current_index, dedupe_summary), f)
                print(Fore.YELLOW + f'Checkpoint saved at index: {current_index}')

            def load_checkpoint(self):
                """Load the checkpoint if it exists."""
                if os.path.exists(self.checkpoint_file):
                    try:
                        with open(self.checkpoint_file, 'rb') as f:
                            df, current_index, dedupe_summary = pickle.load(f)
                        print(f'Resuming from checkpoint at index: {current_index}')
                        return df, current_index, dedupe_summary
                    except (EOFError, pickle.UnpicklingError):
                        print(Fore.RED + f"Checkpoint file {self.checkpoint_file} is corrupted. Restarting from the beginning.")
                        return None, 0, None
                return None, 0, None

            def calculate_dob_score(self, birthday, best_match_birthday):
                dob_score = 0
            
                # If the birthday is exactly the same as the best match birthday
                if birthday == best_match_birthday:
                    dob_score = 100
                
                # If the birth years differ by less than 2 years
                elif abs(birthday.year - best_match_birthday.year) < 2:
                    
                    # If both the month and day are exactly the same
                    if birthday.month == best_match_birthday.month and birthday.day == best_match_birthday.day:
                        dob_score = 90
                    
                    # If the month and day were likely interchanged (e.g., 04/28 vs. 28/04)
                    elif birthday.month == best_match_birthday.day or birthday.day == best_match_birthday.month:
                        dob_score = 90
                        
                    elif abs(birthday.month - best_match_birthday.month) < 2 or abs(birthday.day - best_match_birthday.day) < 2:
                        dob_score = 80
                    
                    # If the year is within 2 years but months and days don't exactly match, assign 70 points
                    else:
                        dob_score = 70
            
                # If the month differs by 9, which could indicate a common data entry mistake
                # (e.g., hitting the wrong key since 9 is close to 0 on a keyboard)
                elif abs(birthday.year - best_match_birthday.year) == 9 and (birthday.year in [0,9] or best_match_birthday.year in [0,9]):
                    dob_score = 90  # Assign a moderately high score for this possible typo
                
                    # Additional check: if both the month and day match exactly despite the year difference
                    if birthday.month == best_match_birthday.month and birthday.day == best_match_birthday.day:
                        dob_score = 70
                    
                    # Additional check: if the month and day were interchanged
                    elif birthday.month == best_match_birthday.day or birthday.day == best_match_birthday.month:
                        dob_score = 60

                    elif abs(birthday.month - best_match_birthday.month) < 2 or abs(birthday.day - best_match_birthday.day) < 2:
                        dob_score = 50

                    # Assign a lower score if none of the above conditions match
                    else:
                        dob_score = 40
                
                # If none of the above conditions match, assign a lower score
                else:
                    dob_score = 30
            
                return dob_score

            def calculate_address_score(self,address1,address2):
                soundex = fuzzy.Soundex(4)        
                address_score = 50
                address1.municipality = self.normalize_ascii(address1.municipality.replace('Ã‘','n'))
                address2.municipality = self.normalize_ascii(address2.municipality.replace('Ã‘','n'))
                address1.barangay = self.normalize_ascii(address1.barangay.replace('Ã‘','n'))
                address2.barangay = self.normalize_ascii(address2.barangay.replace('Ã‘','n'))
                
                if soundex(address1.municipality) == soundex(address2.municipality):
                    address_score = 75
                elif soundex(address1.barangay) == soundex(address2.barangay):
                    address_score= 100
                return address_score

            def find_deduplicates(self, df):
                full_name_list = df['fullname'].tolist()
                duplicate_id_map = {}
                duplicate_id_counter = 1
                total_rows = len(full_name_list)
                start_time = time.time()

                # Load checkpoint if available
                dfs, current_index, dedupe_summary = self.load_checkpoint()

                if dfs is not None:
                    df = dfs.copy()

                if df is None:
                    # If no checkpoint, start from scratch
                    current_index = 0
                    dedupe_summary = {}

                print('Running fuzzy match for deduplication...')

                for i in range(current_index, total_rows):
                    full_name = full_name_list[i]

                    # Skip if already processed
                    if full_name in duplicate_id_map:
                        continue

                    # Create a new list excluding the current full_name to avoid comparing with itself
                    new_list = full_name_list[:i] + full_name_list[i + 1:]

                    # Extract matches using a case-insensitive comparison with a score cutoff of 90
                    similar_names = process.extract(
                        full_name, new_list, scorer=fuzz.ratio, 
                        processor=lambda s: s.upper(), 
                        score_cutoff=self.threshold, 
                        limit=5
                    )

                    

                    for match in similar_names:
                        match_name = match[0]
                        match_score = match[1]
                        match_index = full_name_list.index(match_name)

                        # Only proceed if it's a different name and meets the threshold (>= 90)
                        if match_name != full_name and match_score >= 90:
                            # Assign duplicate ID
                            if full_name in duplicate_id_map:
                                current_duplicate_id = duplicate_id_map[full_name]
                            elif match_name in duplicate_id_map:
                                current_duplicate_id = duplicate_id_map[match_name]
                            else:
                                current_duplicate_id = duplicate_id_counter
                                duplicate_id_counter += 1

                            # Mark both records with the same duplicate ID
                            duplicate_id_map[full_name] = current_duplicate_id
                            duplicate_id_map[match_name] = current_duplicate_id

                            # Calculate scores
                            similarity_score = match_score

                            if i == 9872:
                                i = i

                            # birthday = dh.convert_date(self,df.iloc[i].BIRTHDAY)
                            # match_birthday = dh.convert_date(self,df.iloc[match_index].BIRTHDAY)
                            # print('IlocBday:', i, len(df), subset)
                            birthday = df.iloc[i].birthday
                            match_birthday = df.iloc[match_index].birthday

                            dob_score = self.calculate_dob_score(birthday, match_birthday)
                            address_score = self.calculate_address_score(df.iloc[i], df.iloc[match_index])

                            # Update DataFrame with duplicate and score information
                            df.loc[match_index, 'DUPLICATE_ID'] = current_duplicate_id
                            df.loc[i, 'DUPLICATE_ID'] = current_duplicate_id

                            df.loc[match_index, 'NAME_SIMILARITY'] = similarity_score
                            df.loc[i, 'NAME_SIMILARITY'] = similarity_score

                            df.loc[match_index, 'DOB_SCORE'] = dob_score
                            df.loc[i, 'DOB_SCORE'] = dob_score

                            df.loc[match_index, 'ADDRESS_SCORE'] = address_score
                            df.loc[i, 'ADDRESS_SCORE'] = address_score

                            final_score = (similarity_score * 0.5) + (dob_score * 0.3) + (address_score * 0.2)
                            df.loc[match_index, 'FINAL_SCORE'] = final_score
                            df.loc[i, 'FINAL_SCORE'] = final_score

                    progress = (i + 1) / total_rows * 100
                    elapsed_time = time.time() - start_time
                    estimated_total_time = elapsed_time / (i + 1) * total_rows
                    remaining_time = estimated_total_time - elapsed_time

                    current_status = {
                        'progress':progress,
                        'elapsed_time':elapsed_time,
                        'estimated_total_time':estimated_total_time,
                        'remaining_time':remaining_time
                    }
                    self.update_state(state="PROGRESS", meta=current_status)

                    # print('> ',i)
                    if (i + 1) % 43 == 0 or i == total_rows - 1:
                        print(Fore.RESET + f"row {i + 1: 6}/{total_rows:<6} Progress: {progress: >5.2f}%   Time Remaining: {dh.convert_seconds_to_hms(self,remaining_time)}")

                    # Periodically save checkpoint
                    if i % self.checkpoint_segment == 0:
                        self.save_checkpoint(df, i, dedupe_summary)

                # Generate summary
                summary_table = df.pivot_table(
                    index=['province', 'municipality'],
                    values='DUPLICATE_ID',
                    aggfunc='count'
                ).reset_index()

                # Once done, remove the checkpoint file
                if os.path.exists(self.checkpoint_file):
                    os.remove(self.checkpoint_file)
                    print('Deduplication completed, checkpoint removed.')

                return df, summary_table

        # -------------------------------------

        def deduplicate_commence():

            # try:
            # Get data from DB
            print('fetching data')
            response, status_code = get_roster(subset)
            if status_code != 200:
                response_data = {'success': False, 'message': f'Failed to fetch data from DB: {response}', 'status_code': status_code}
                self.update_state(state="PROGRESS", meta=response_data)
                return response_data
            if not response:
                response_data = {'success': False, 'message': 'No data received from DB'}
                self.update_state(state="PROGRESS", meta=response_data)
                return response_data            

            print('converting to df')
            try:
                df = pd.DataFrame(response)
                print('loaded data: ', len(df))
            except Exception as e:
                response_data = {'success': False, 'message': f'Error converting data to DataFrame: {str(e)}'}
                self.update_state(state="PROGRESS", meta=response_data)
                return response_data

            # Create task
            print('Creating new task!')
            task_created, task_id = create_task(len(df))
            if not task_created:
                response_data = {'success': False, 'message': 'Task creation failed'}
                self.update_state(state="PROGRESS", meta=response_data)
                return response_data

            # Deduplication process
            try:
                print('Finding duplictes!')
                dq = deduplicator_helper(threshold=90, checkpoint_segment=1000, update_state=self.update_state)
                df, dedupe_summary = dq.find_deduplicates(df)
            except Exception as e:
                response_data = {'success': False, 'message': f'Deduplication process failed: {str(e)}'}
                print(response_data)
                self.update_state(state="PROGRESS", meta=response_data)
                return response_data

            # Extract duplicate records
            try:
                df_duplicates = df[df['DUPLICATE_ID'] > 0][['entry_id', 'DUPLICATE_ID', 'NAME_SIMILARITY', 'DOB_SCORE', 'ADDRESS_SCORE', 'FINAL_SCORE']]
            except KeyError as e:
                response_data = {'success': False, 'message': f'Missing expected column in DataFrame: {str(e)}'}
                self.update_state(state="PROGRESS", meta=response_data)
                return response_data

            # Insert deduplication results
            print('Saving deduplication results!')
            is_completed, msg = insert_dedupe_results(task_id, df_duplicates)
            if not is_completed:
                response_data = {'success': False, 'message': f'Failed to insert deduplication results: {msg}'}
                self.update_state(state="PROGRESS", meta=response_data)
                return response_data
            # Save to Excel
            print("[8] Starting Saving file")
            try:

                print("[9] Saving file")
                with pd.ExcelWriter("deduplication_result.xlsx", engine="xlsxwriter") as writer:
                    df.to_excel(writer, sheet_name="Main Data", index=False)
                    dedupe_summary.to_excel(writer, sheet_name="Dedupe Summary", index=False)

                pass

            except Exception as e:
                # return {'success': False, 'message': f'Error saving to Excel: {str(e)}'}
                response_data = {'success': False, 'message': f'Error saving to Excel: {str(e)}'}
                self.update_state(state="PROGRESS", meta=response_data)
                return response_data
            

            response_data = {
                'success': True,
                'task_id': task_id, 
                'threshold': threshold,
                'message': 'Deduplication complete',
                'result': json.loads(dedupe_summary.to_json(orient='records')) 
            }

            self.update_state(state="PROGRESS", meta=response_data)
            return response_data

            # except Exception as e:
            #     response_data = {'success': False, 'message': f'Unexpected error: {str(e)}'}
            #     print(response_data)
            #     self.update_state(state="PROGRESS", meta=response_data)
            #     return response_data



        # -------------------------------------

        deduplicate_commence()

        # df = get_roster(subset)
        # total = len(df)
        # for index, row in df.iterrows():
        #     progress = (index + 1) / total * 100  # Calculate progress
        #     self.update_state(state="PROGRESS", meta={"current": index + 1, "total": total, "percent": progress})

        #     print(f"ID: {row['entry_id']}, Name: {row['fullname']}")
        #     time.sleep(1)

        return "Deduplication completed successfully."
