import os
import pickle
import fuzzy
import shutil
import tempfile
from os import name
from re import template
import pandas as pd
import unicodedata


from celery_progress.backend import ProgressRecorder
from package import celery_app
from django.conf import settings
# from django.contrib.auth.models import User
from django.http import Http404, HttpResponse
from django.utils import timezone
from openpyxl import Workbook, load_workbook

from ..dutils import DataframeUtil
from .base import BaseTask
from datetime import datetime, timedelta

import json

from rapidfuzz.fuzz import ratio
from rapidfuzz import process, fuzz
import uuid
import numpy as np
import time
import math
import sys
from django.core.exceptions import ObjectDoesNotExist

from ..models import datasets, transactions, lib_trans_status
from os.path import exists
from datetime import datetime
from colorama import init, Fore, Back, Style
import os
from ..utils.data_incon_helper import load_observations, get_dataset_id_by_trains_id, get_transaction_info
from ..utils.data_helper import data_helper as dh
import logging
logging.basicConfig(level=logging.DEBUG)

class CommenceDeduplicatorTask(BaseTask):
    name = "CommenceDeduplicatorTask"

    # def update_row(self,row: dict) -> transactions:
    #     try:
    #         u = transactions.objects.get(trans_id=row.get("trans_id"))
    #     except transactions.DoesNotExist:
    #         raise ValueError(f"User with trans_id# {row.get('trans_id')} does not exist.")
        
    #     u.checkpoint_entry = row.get("checkpoint_entry")
    #     u.checkpoint_time = row.get("checkpoint_time")
    #     u.progress = row.get("progress")
    #     u.status = row.get("status")
    #     u.save()
        
    #     return u

    def update_row(self, row: dict):
        try:
            u = transactions.objects.get(trans_id=row.get("trans_id"))
        except transactions.DoesNotExist:
            raise ValueError(f"Transaction with trans_id# {row.get('trans_id')} does not exist.")
        
        u.checkpoint_entry = row.get("checkpoint_entry")
        u.checkpoint_time = row.get("checkpoint_time")
        u.progress = row.get("progress")
        
        try:
            status_id = row.get("status")
            if status_id is not None:
                u.status_id = lib_trans_status.objects.get(pk=status_id)  # Ensure correct ForeignKey reference
        except lib_trans_status.DoesNotExist:
            raise ValueError(f"Invalid status ID {status_id}.")
        
        logging.debug(f"Saving transaction: {u}")
        u.save()
        logging.debug(f"Transaction saved successfully: {u}")

    def normalize_string(self,input_str):
        """
        Normalize a string by replacing non-ASCII characters with closest ASCII equivalents.
        """
        # Replace special characters (e.g., Ñ with N)
        normalized = unicodedata.normalize('NFD', input_str).encode('ascii', 'ignore').decode('utf-8')
        return normalized.replace('Ñ', 'N').replace('ñ', 'n')

    def update_progress(self, progress_recorder, index, start_time, total_record):
        # Calculate elapsed time in seconds
        current_time = datetime.now()
        elapsed_time = current_time - start_time
        elapsed_time_seconds = elapsed_time.total_seconds()

        # Calculate the time per record
        time_per_record = elapsed_time_seconds / (index + 1)

        # Estimate remaining time in seconds
        estimated_remaining_time_seconds = (total_record - index - 1) * time_per_record

        # Format remaining time into hh:mm:ss
        remaining_time = timedelta(seconds=estimated_remaining_time_seconds)
        hours = remaining_time.seconds // 3600
        minutes = (remaining_time.seconds % 3600) // 60
        seconds = remaining_time.seconds % 60

        # Create formatted remaining time string
        formatted_remaining_time = "{:02d}:{:02d}:{:02d}".format(hours, minutes, seconds)

        # Send formatted remaining time as part of progress update
        progress_recorder.set_progress(
            index + 1,
            total=total_record,
            description=json.dumps({
                'sta': formatted_remaining_time,
                'msg': 'success'
            })
        )

    """
    Function: __init__
    Syntax: __init__([threshold=90])
    Description: Initializes the DQA class with threshold and subset values.
    Args:
        threshold (int): Threshold value for deduplication.
    """
    def __init__(self, threshold=50):
        self.threshold = threshold
        self.dataset_uid = "dummy1" #will be updated in def run
        self.trans_id = 0 #will be updated in def run
        self.checkpoint_file = "dummy_checkpoint_name"
        self.job_path = "dummy_job_path"
        self.last_checkpont_saved = datetime.now()
        self.is_cancelled_by_user = False

    """
    Function: save_checkpoint
    Syntax: save_checkpoint(df, current_index, dedupe_summary)
    Description: Saves the current state of the deduplication process to a checkpoint file.
    Args:
        df (DataFrame): The dataframe being deduplicated.
        current_index (int): The current index in the deduplication process.
        dedupe_summary (dict): Summary of the deduplication performed so far.
    Return: None
    Example: save_checkpoint(df, 500, summary)
    """
    def save_checkpoint(self, df, current_index, dedupe_summary):
        # Save the current state of deduplication process to a checkpoint file.
        with open(self.checkpoint_file, 'wb') as f:
            pickle.dump((df, current_index, dedupe_summary), f)
        print(Fore.YELLOW + f'Checkpoint saved at index: {current_index}')

        # UPDATE CHECKPOINT STATUS
        try:
            u = transactions.objects.get(trans_id=self.trans_id)
            u.checkpoint_entry = current_index
            u.checkpoint_time = datetime.now()
            u.progress = current_index / self.total_rows * 100
            u.save()
        except transactions.DoesNotExist:
            raise ValueError(f"User with trans_id# {row.get('trans_id')} does not exist.")
        
        # FOR CHECKING OF LAST CHECKPOINT
        self.last_checkpont_saved = datetime.now()


    def is_cancelled(self):
        # Filter transactions
        data = transactions.objects.filter(
            process_id__isnull=True,
            trans_id=self.trans_id,
            status_id=4
        )
        self.is_cancelled_by_user = True
        return data.exists()

    """
    Function: load_checkpoint
    Syntax: load_checkpoint()
    Description: Loads the deduplication process from a checkpoint file if it exists.
    Return: Tuple containing the dataframe, current index, and deduplication summary, or (None, 0, None) if no checkpoint exists.
    Example: df, index, summary = load_checkpoint()
    """
    def load_checkpoint(self):
        """Load the checkpoint if it exists."""
        # self.checkpoint_file = os.path.join(settings.JOBS_ROOT,self.dataset_uid,self.trans_id)
        if os.path.exists(self.checkpoint_file):
            try:
                with open(self.checkpoint_file, 'rb') as f:
                    df, current_index, dedupe_summary = pickle.load(f)

                # cancelling cancelled status on resume
                # with transaction.atomic():
                #     transaction_record, _ = transactions.objects.get_or_create(process_id=process_id)
                #     canceled_status = lib_trans_status.objects.get(pk=4)  # Ensure this exists or handle DoesNotExist
                    
                #     transaction_record.status_id = canceled_status
                #     transaction_record.process_id = None
                #     transaction_record.save()

                print(f'Resuming from checkpoint at index: {current_index}')
                return df, current_index, dedupe_summary
            except (EOFError, pickle.UnpicklingError):
                print(Fore.RED + f"Checkpoint file {self.checkpoint_file} is corrupted. Restarting from the beginning.")
                return None, 0, None
        return None, 0, None

    """
    Function: calculate_dob_score
    Syntax: calculate_dob_score(birthday, best_match_birthday)
    Description: Calculates a similarity score between two dates of birth (DOB). The score is based on 
                 how close the two dates are in terms of year, month, and day, and assigns a score based 
                 on the likelihood of small data entry mistakes.
    Return: int (score between 30 and 100)
    Example: dob_score = calculate_dob_score(str(date(2024, 9, 30)), str(date(2024, 9, 28)))
    """        
    def calculate_dob_score(self, birthday, best_match_birthday, string_date_format="%Y-%m-%d"):
        dob_score = 0

        # Convert the formatted string back to a datetime object
        birthday = datetime.strptime(birthday, string_date_format)
        best_match_birthday = datetime.strptime(best_match_birthday, string_date_format)
    
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

    """
    Function: calculate_address_score
    Syntax: calculate_address_score(address1, address2)
    Description: Compares two address records (as DataFrame rows) using the Soundex algorithm and returns a score 
                 based on how similar the two addresses are. Prioritizes matching the municipality or barangay.
    Return: int (address similarity score)
    Example: address_score = self.calculate_address_score(df.iloc[i], df.iloc[best_full_name_index])
    """
    def calculate_address_score(self, address1, address2):
        soundex = fuzzy.Soundex(4)
        address_score = 50

        # Normalize MUNICIPALITY and BARANGAY fields
        address1_municipality = self.normalize_string(address1['MUNICIPALITY'])
        address2_municipality = self.normalize_string(address2['MUNICIPALITY'])
        address1_barangay = self.normalize_string(address1['BARANGAY'])
        address2_barangay = self.normalize_string(address2['BARANGAY'])

        if soundex(address1_municipality) == soundex(address2_municipality):
            address_score = 75
        elif soundex(address1_barangay) == soundex(address2_barangay):
            address_score = 100

        return address_score


    """
    Function: find_deduplicates
    Syntax: find_deduplicates(df, threshold=90)
    Description: Uses fuzzy matching to find and mark duplicate entries in a DataFrame based on similarity of names.
    Return: DataFrame with duplicate flags, summary table
    Example: df, summary_table = self.find_deduplicates(df, threshold=85)
    """

    def run(self,  *args, **kwargs):
        progress_recorder = ProgressRecorder(self)
        self.threshold = 90        
        self.trans_id = kwargs.get('trans_id')
        self.dataset_uid = get_dataset_id_by_trains_id(self.trans_id)
        self.checkpoint_file = os.path.join(settings.JOBS_ROOT, self.dataset_uid, f"dedupe_cp_{self.dataset_uid}_{self.trans_id}.pkl")
        self.job_path = os.path.join(settings.JOBS_ROOT,self.dataset_uid)


        # STEP 1: LOAD DATA FROM TEMPLATE
        df = pd.read_pickle(f"{self.job_path}/template.pkl" ).head(20000)
        total_record = df.shape[0]

        start_time = datetime.now()
        # fsta = lambda st,rc,cr:   (100-(cr/rc*100))*((time.time()-st)/(cr/rc*100))
        df['UID'] = df[['FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME']].apply(lambda row: ' '.join(row.values.astype(str)), axis=1)

        # df = pd.concat([df], axis=0, ignore_index=1)
        # word_list = df['UID'].tolist()        
        # df.at[0,'checked'] = 0
        # STEP 2: CREATE A LIST OF NAMES (FMLs) FOR SEARCH RANGE PARAMETER IN FUZZ 

        progress_recorder.set_progress(
            1, 
            total=100, 
            description=json.dumps({
                'msg':'Commencing',
                'sta':'00:00:00'
                })
        )

        # ---------------------------------------------------------------------------------------

        full_name_list = df['UID'].tolist()
        duplicate_id_map = {}
        duplicate_id_counter = 1
        self.total_rows = len(full_name_list)

        # Load checkpoint if available
        dfs, current_index, dedupe_summary = self.load_checkpoint()

        if dfs is not None:
            df = dfs.copy()

        if df is None:
            # If no checkpoint, start from scratch
            current_index = 0
            dedupe_summary = {}

        # set the status to running -------------------------------------------------------------
        try:
            u = transactions.objects.get(trans_id=self.trans_id)
            u.status_id = lib_trans_status.objects.get(pk=1) #set status_id to running (1)
            u.save()
        except transactions.DoesNotExist:
            raise ValueError(f"Transaction with trans_id# {self.trans_id} does not exist.")
    
        # commence running ----------------------------------------------------------------------
        print('Running fuzzy match for deduplication...')
        df['DUPLICATE_ID']=None
        for i in range(current_index, self.total_rows):
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
                if match_name != full_name and match_score >= self.threshold:
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

                    # birthday = dh.convert_date(self,df.iloc[i].BIRTHDAY)
                    # match_birthday = dh.convert_date(self,df.iloc[match_index].BIRTHDAY)
                    
                    dob_score = 0

                    try:

                        birthday = dh.convert_date(self,df.loc[i, 'BIRTHDAY'])
                        match_birthday = dh.convert_date(self,df.loc[match_index, 'BIRTHDAY'])
                        dob_score = self.calculate_dob_score(birthday, match_birthday)

                    except KeyError:
                        # If the column does not exist, catch the exception and ignore it
                        print("Column 'BIRTHDAY' does not exist in the DataFrame.")
                        print('-----------------------------------------------')
                        print(df.columns)
                        print('-----------------------------------------------')

                    except Exception as e:
                        # Catch any other unexpected errors
                        print('-----------------------------------------------')
                        print(f"An error occurred: {e}")
                        print('Error:[', df.loc[i, 'BIRTHDAY'],'][',df.loc[match_index, 'BIRTHDAY'],']')
                        print('-----------------------------------------------')
                        pass  # Ignore the error and continue execution

                    # address_score = self.calculate_address_score(df.iloc[i], df.iloc[match_index])
                    address_score = self.calculate_address_score(df.iloc[i], df.iloc[match_index])

                    # Update DataFrame with duplicate and score information
                    # print('-----------------------------------------------------')
                    df.loc[match_index, 'DUPLICATE_ID'] = current_duplicate_id
                    df.loc[i, 'DUPLICATE_ID'] = current_duplicate_id
                    
                    # print(df.loc[[match_index, i], ['DUPLICATE_ID']])

                    # print(f"match_index: {match_index}, i: {i}")
                    # print(f"Row at match_index: {df.loc[match_index]}")
                    # print(f"Row at i: {df.loc[i]}")
                    # print('-----------------------------------------------------')


                    df.loc[match_index, 'NAME_SIMILARITY'] = similarity_score
                    df.loc[i, 'NAME_SIMILARITY'] = similarity_score

                    df.loc[match_index, 'DOB_SCORE'] = dob_score
                    df.loc[i, 'DOB_SCORE'] = dob_score

                    df.loc[match_index, 'ADDRESS_SCORE'] = address_score
                    df.loc[i, 'ADDRESS_SCORE'] = address_score

                    final_score = (similarity_score * 0.5) + (dob_score * 0.3) + (address_score * 0.2)
                    df.loc[match_index, 'FINAL_SCORE'] = final_score
                    df.loc[i, 'FINAL_SCORE'] = final_score

                    

            progress = (i + 1) / self.total_rows * 100
            elapsed_time = time.time() - start_time.timestamp()
            estimated_total_time = elapsed_time / (i + 1) * self.total_rows
            remaining_time = estimated_total_time - elapsed_time
            

            # UPDATE PROGRESSBAR
            if (i + 1) % 43 == 0 or i == self.total_rows - 1:
                #** print(Fore.RESET + f"row {i + 1: 6}/{self.total_rows:<6} Progress: {progress: >5.2f}%   Time Remaining: {dh.convert_seconds_to_hms(self,remaining_time)}")
                self.update_progress(progress_recorder, i,start_time,total_record)

                # CHECK TRANSACTION IS REVOKED
                if self.is_cancelled():
                    print('Transaction terminated by user!')
                    break
            
            # PERIODICALLY SAVE CHECKPOINT (300s == 5m)
            if (datetime.now() - self.last_checkpont_saved).total_seconds() >= 10:
                self.save_checkpoint(df, i, dedupe_summary)
                



        # Generate summary
        # summary_table = df.pivot_table(
        #     index=['PROVINCE', 'MUNICIPALITY'],
        #     values='DUPLICATE_ID',
        #     aggfunc='count'
        # ).reset_index()

        # Once done, remove the checkpoint file

        if not self.is_cancelled_by_user:
            if os.path.exists(self.checkpoint_file):
                os.remove(self.checkpoint_file)
                print('Deduplication completed, checkpoint removed.')

            # ---------------------------------------------------------------------------------------
            # self.update_progress(progress_recorder, index,start_time,total_record)

            df.to_pickle(os.path.join(settings.JOBS_ROOT, f"./{self.dataset_uid}/dedupe_result_{self.dataset_uid}_{self.trans_id}.pkl"))
            df.to_excel(os.path.join(settings.JOBS_ROOT, f"./{self.dataset_uid}/dedupe_result_{self.dataset_uid}_{self.trans_id}.xlsx"))


            # FINALIZING TASK: UPDATE transactions table for final result
            progress_recorder.set_progress(
                100, 
                total=100, 
                description=json.dumps({
                    'sta':'',
                    'msg':'finished'
                    })
            )

            row_data = {
                "trans_id": self.trans_id,
                "checkpoint_entry": total_record,
                "checkpoint_time": datetime.now(),
                "progress": 100,
                "status": 2, #Finished
                "process_id":None
            }

            try:
                updated_user = self.update_row(row_data)
                print("Final deduplication result saved successfully:", updated_user)
            except ValueError as e:
                print("Error updating db:task =>", e)

            return {
                "detail": "Deduplication Finished!",
                "finished" :  True
            }
        else:
            return {
                "detail": "Deduplication cancelled by user!",
                "finished" :  False
            }           

# @celery_app.task(bind=True, base=CommenceDeduplicatorTask)
# def deduplicator_task(self, *args, **kwargs):
#     return super(type(self), self).run(*args, **kwargs)


@celery_app.task(bind=True, base=CommenceDeduplicatorTask)
def deduplicator_task(self, *args, **kwargs):
    # Pass task_id to the task's run method
    return super(type(self), self).run(*args, **kwargs)

