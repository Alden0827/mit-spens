
#django 
from celery_progress.backend import ProgressRecorder
from package import celery_app
from django.conf import settings
# from django.contrib.auth.models import User
from django.http import Http404, HttpResponse
from django.utils import timezone
from openpyxl import Workbook, load_workbook

from ..dutils import DataframeUtil
from .base import BaseTask
from django.core.exceptions import ObjectDoesNotExist
from ..models import datasets, transactions
from ..models import roster

#python lib
from pathlib import Path
#import jellyfish
import os
import time

import json

import collections 
import openpyxl
import sys
import colorama
import getpass
import configparser
import math
# import iniparser as ini
import uuid
import warnings
from rapidfuzz.fuzz import ratio
from rapidfuzz import process, fuzz
from xlsxwriter import Workbook
from colorama import init, Fore, Back, Style
from sqlalchemy import create_engine
from datetime import datetime
import pandas as pd
from django_pandas.io import read_frame
import re
from ..utils.data_incon_helper import load_observations, get_dataset_id_by_trains_id, get_transaction_info


# warnings.simplefilter(action='ignore', category=FutureWarning)

class CommenceNameMatchingTask(BaseTask):
    name = "c"
    #Global variables
    SCORE_THRESHOLD = 90
    CP_ROW_COUNT = 100
    CP_STATUS_UNFINISHED = 0
    CP_STATUS_FINISHED = 0
    SECURITY_CODE = ''

    # CHECKPOINT_PATH = f"./jobs/4f42b583-74e3-4d90-a0da-71bb21ec8e72"
    # RESULT_PATH = f"./jobs/4f42b583-74e3-4d90-a0da-71bb21ec8e72"

    def update_row(self,row: dict) -> datasets:
        try:
            u = transactions.objects.get(trans_id=row.get("trans_id"))
        except datasets.DoesNotExist:
            raise ValueError(f"User with trans_id {row.get('trans_id')} does not exist.")
        
        u.checkpoint_entry = row.get("checkpoint_entry")
        u.checkpoint_time = row.get("checkpoint_time")
        u.progress = row.get("progress")
        u.status = row.get("status")
        u.save()
        
        return u


    def numeric_date_to_iso_8601_format_list(self, birthdate_numeric):
        # ISO 8601 date format yyyy-mm-dd
        try:
            # Convert numeric date to datetime
            birthdate = datetime(1900, 1, 1) + pd.to_timedelta(birthdate_numeric, unit='D')

            # Format date as 'yyyy-mm-dd'
            formatted_date = birthdate.strftime('%Y-%m-%d')

            # Split the string using '-' as the delimiter and convert components to integers
            date_list = [int(component) for component in formatted_date.split("-")]
            return date_list
        except Exception as e:
            # Handle any errors and return default date
            print(f"Error occurred: {e}")
            return [1900, 1, 1]

    def update_progress(self,progress_recorder, index,start_time,total_record):
        # Calculate estimated time remaining
        current_time = datetime.now()
        elapsed_time = current_time - start_time
        time_per_record = elapsed_time / (index + 1)
        estimated_remaining_time_seconds = (total_record - index - 1) * time_per_record.total_seconds()

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
                'sta':formatted_remaining_time,
                'msg':'success'
                })
        )

    def checkpoint_check(self, filepath, trans_id):
        try:
            trans = transactions.objects.get(trans_id=trans_id)
            if trans.status == 1:
                return True
            else:
                return False
        except transactions.DoesNotExist as e:
            # Log the exception details with traceback
            # logger.error(f"Exception occurred: {str(e)}")
            # logger.error(f"Traceback: {traceback.format_exc()}")
            return False

    #return tupple df, offset, status
    def checkpoint_load(self,filepath,trans_id):
        trans = transactions.objects.get(trans_id=trans_id)
        cp_offset = trans.checkpoint_entry
        df = pd.read_pickle(f"{filepath}/checkpoint.pkl")
        return df, cp_offset

    def checkpoint_save(self,filepath,cpdf, trans_id, offset, total_record): #save checkpint 
        try:
            

            trans = transactions.objects.get(trans_id=trans_id)
            trans.checkpoint_entry = offset
            trans.status = 1
            trans.checkpoint_time =  datetime.now()
            trans.progress = (offset+1)/total_record*100
            trans.save()

            cpdf.to_pickle(f"{filepath}/checkpoint.pkl")

            print(Fore.GREEN + 'Checkpoint saved @ ' + str(offset) + ' offset')
            return True
        except Exception as e:
            print(Fore.RED + f'Checkpoint failed! |trans_id: {trans_id} Error: {str(e)}')
            return False


    # @nb.jit(nopython=False, parallel=True)
    def namematcher_extract_best_result(self,uid,word_list):
        # return process.extractOne(uid, word_list, scorer=fuzz.WRatio, score_cutoff = SCORE_THRESHOLD)
        ret =  process.extractOne(uid, word_list,scorer=ratio, processor=lambda s: s.upper(), score_cutoff = self.SCORE_THRESHOLD)
        return ret

    # Convert sta to h:m:s format
    def time_format(self,seconds):
        hours = int(seconds // 3600)
        minutes = int((seconds % 3600) // 60)
        seconds = int(seconds % 60)
        
        if hours > 0:
            return f"{hours}h:{minutes}m:{seconds}s"
        elif minutes > 0:
            return f"{minutes}m:{seconds}s"
        else:
            return f"{seconds}s"

    def run(self, *args, **kwargs):
        progress_recorder = ProgressRecorder(self)

        df = pd.DataFrame()
        df['FIRST_NAME'] = ['']
        df['MIDDLE_NAME'] = ['']
        df['LAST_NAME'] = ['']
        df['x'] = ['']

        # request_id = kwargs.get('dataset_uid')
        trans_id = kwargs.get('trans_id')
        dataset_uid = get_dataset_id_by_trains_id(trans_id)
        filepath  = os.path.join(settings.JOBS_ROOT,dataset_uid)

        #LOAD BASELINE
       
        #LOAD DATA FROM DB
        dfc = read_frame(roster.objects.all())


        #LOADING TEMPLATE
        df =  pd.read_pickle(f"{filepath}/template.pkl")
        # CREATE A COLUMN TO BE MATCHED
        cols = ['FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME']
        df['UID'] = df[cols].apply(lambda row: ' '.join(row.values.astype(str)), axis=1)
        cols2 = ['FIRST_NAME', 'MIDDLE_NAME', 'LAST_NAME']
        dfc['UID'] = dfc[cols2].apply(lambda row2: ' '.join(row2.values.astype(str)), axis=1)

        # CONVERT COLUMN UID TO LIST
        word_list = dfc['UID'].tolist()

        # RUNNING NAME-MATCHER!  
        start_time = time.time() 
        row_count = df[df.columns[0]].count()
           
        #CHECK OF NAME-MATCHING IS UNFINISHED
        #REPLACE DF WITH CHECKPOINT DF
        offset = 0
        resume = False
        if self.checkpoint_check(filepath,trans_id):
            df, offset = self.checkpoint_load(filepath,trans_id)
            resume = True
            # print(Fore.RED + 'Resumming job @ offset ' + str(int(offset)+2))

        counter = 0
        for index, row in df.iterrows():
            final_match_status = ""
            if resume:
                counter=counter+1
                if (counter-1)<=int(offset):
                    continue
                else:
                    resume = False

            result_uid = ''
            result_index = 0
            result_dob = ''
            result_hh    = ''
            result_entry = ''
            # result_reg   = ''
            result_cs    = ''
            result_ms    = ''
            BYearDiff     = 0
            BMonthDiff    = 0
            BDayDiff      = 0
            dis_month_sw    = 0
            dis_day_sw      = 0
            perc = 0

            # # EXTRACT THE BEST MATCH FROM WORD_LIST
            res = self.namematcher_extract_best_result(row['UID'],word_list)
            # print(res)
            if not res == None:
                res_id = res[2]
                perc = res[1]        
                res_row = dfc.iloc[[res_id]]

                heightest_perc= perc
                soundex = 0

                result_uid    = res_row["UID"].to_numpy()[0]
                result_index  = res_id
                result_dob    = res_row["BIRTHDAY"].to_numpy()[0]
                result_hh     = res_row["HH_ID"].to_numpy()[0]
                result_entry  = res_row["ENTRY_ID"].to_numpy()[0]
                result_cs     = res_row["CLIENT_STATUS"].to_numpy()[0]
                result_ms     = res_row["MEMBER_STATUS"].to_numpy()[0] 
                result_muni   = res_row["MUNICIPALITY"].to_numpy()[0] 
                result_brgy   = res_row["BARANGAY"].to_numpy()[0] 

                result_rel   = res_row["RELATION_TO_HH_HEAD"].to_numpy()[0] 

                result_grantee   = res_row["GRANTEE"].to_numpy()[0] 
                result_age   = res_row["AGE"].to_numpy()[0] 
                result_sex   = res_row["SEX"].to_numpy()[0] 
                result_group   = res_row["HH_SET"].to_numpy()[0] 

                tm_dob_year   = row['B_YEAR']
                tm_dob_month  = row['B_MONTH']
                tm_dob_day    = row['B_DAY']

                #GET THE DOB DISTANCE
                pp_dob          = res_row["BIRTHDAY"].to_numpy()[0] 
                pp_dob_year,pp_dob_month,pp_dob_day = self.numeric_date_to_iso_8601_format_list(pp_dob)
                                
                dis_month_sw = abs(pp_dob_month - tm_dob_day) 
                dis_day_sw   = abs(pp_dob_day - tm_dob_month)

                # APPEND MATCHING RESULT TO DF
                df.at[index,'r_id']=result_index
                df.at[index,'r_uid']=result_uid
                df.at[index,'r_mun']=result_muni
                df.at[index,'r_brgy']=result_brgy
                df.at[index,'r_dob']=result_dob
                df.at[index,'r_hhid']=str(result_hh)
                df.at[index,'r_eid']=result_entry 
                # df.at[index,'r_reg']=result_reg 

                df.at[index,'r_rel']=result_rel 
                df.at[index,'r_grantee']=result_grantee 
                df.at[index,'r_age']=result_age 
                df.at[index,'r_sex']=result_sex 
                # df.at[index,'r_set']=result_set 
                df.at[index,'r_grp']=result_group 

                df.at[index,'r_cs']=result_cs    
                df.at[index,'r_ms']=result_ms    
                # df.at[index,'sdex']=soundex
                df.at[index,'r_pec']="{:.2%}".format(perc/100)
                
                '''
                The absolute value of the difference between Sourcefile BirthDay and Resulting
                file BirthDay.
                '''

                df.at[index,'BYearDiff']=BYearDiff
                df.at[index,'BMonthDiff']=BMonthDiff
                df.at[index,'BDayDiff']=BDayDiff


            #SAVE CHECKPOINT FOR EVERY 100 ENTRY
            if counter % self.CP_ROW_COUNT == self.CP_ROW_COUNT - 1:
                self.checkpoint_save(filepath=filepath,cpdf=df, trans_id=trans_id,offset=counter,total_record=len(df))
                

            counter=counter+1
            try:
                # Define the function to estimate time
                fsta = lambda st, rc, cr: (100 - (cr / rc * 100)) * ((time.time() - st) / (cr / rc * 100))
                
                # Get estimated time
                sta = fsta(start_time, len(df), counter)
                
                # Convert sta to formatted time (using your self.time_format function)
                try:
                    sta = self.time_format(sta)
                except Exception as e:
                    sta = "N/A"  # Fallback if `self.time_format` fails

                # Set progress
                progress_recorder.set_progress(
                    counter,
                    total=len(df),
                    description=json.dumps({
                        'sta': sta  # Include the formatted time or fallback value
                    })
                )
            except ZeroDivisionError:
                # Handle division by zero errors
                sta = "N/A (ZeroDivisionError)"
                progress_recorder.set_progress(
                    counter,
                    total=1,  # To avoid errors in set_progress
                    description=json.dumps({
                        'sta': sta
                    })
                )
            except Exception as e:
                # Handle all other exceptions
                sta = f"Error: {str(e)}"
                progress_recorder.set_progress(
                    counter,
                    total=len(df) if len(df) > 0 else 1,  # Ensure total is not zero
                    description=json.dumps({
                        'sta': sta
                    })
                )

            # print(Fore.YELLOW + "fuzzy-match:", counter ,'of',len(df), "{:.2%}".format(counter / len(df)) ,"lapse:",laps," sta:",sta, " rps:",rps)  

        #save checkpoint finished
        df.to_excel(os.path.join(settings.JOBS_ROOT, f"./{dataset_uid}/result.xlsx"))
        progress_recorder.set_progress(
            100, 
            total=100, 
            description=json.dumps({
                'sta':'',
                'msg':'finished'
                })
        )
        row_data = {
            "trans_id": trans_id,
            "checkpoint_entry": len(df),
            "checkpoint_time": datetime.now(),
            "progress": 100,
            "status": 2, #Finished
            "process_id":None
        }

        try:
            updated_user = self.update_row(row_data)
            print("User updated successfully:", updated_user)
        except ValueError as e:
            print("Error:", e)

        return {
            "detail": "name-matching Finished!"
        }

@celery_app.task(bind=True, base=CommenceNameMatchingTask)
def pantawid_namematcher_task(self, *args, **kwargs):
    # Pass task_id to the task's run method
    return super(type(self), self).run(*args, **kwargs)