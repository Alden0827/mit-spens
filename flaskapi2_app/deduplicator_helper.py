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


#%% dqa class

class deduplicator_helper(object):

    def normalize_ascii(self,text):
        return ''.join(
            c for c in unicodedata.normalize('NFKD', text) if ord(c) < 128
        )


    """
    Function: __init__
    Syntax: __init__([threshold=90[, checkpoint_segment=300]])
    Description: Initializes the DQA class with threshold and subset values.
    Args:
        threshold (int): Threshold value for deduplication.
        checkpoint_segment (int): number of rows to passed before creating new checkpoints
    """
    def __init__(self, threshold=90, checkpoint_segment=300):
        self.threshold = threshold
        self.checkpoint_file = 'dedupe_checkpoint.pkl'
        self.checkpoint_segment = checkpoint_segment

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
        """Save the current state of deduplication process to a checkpoint file."""
        with open(self.checkpoint_file, 'wb') as f:
            pickle.dump((df, current_index, dedupe_summary), f)
        print(Fore.YELLOW + f'Checkpoint saved at index: {current_index}')

    """
    Function: load_checkpoint
    Syntax: load_checkpoint()
    Description: Loads the deduplication process from a checkpoint file if it exists.
    Return: Tuple containing the dataframe, current index, and deduplication summary, or (None, 0, None) if no checkpoint exists.
    Example: df, index, summary = load_checkpoint()
    """
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

    """
    Function: calculate_dob_score
    Syntax: calculate_dob_score(birthday, best_match_birthday)
    Description: Calculates a similarity score between two dates of birth (DOB). The score is based on 
                 how close the two dates are in terms of year, month, and day, and assigns a score based 
                 on the likelihood of small data entry mistakes.
    Return: int (score between 30 and 100)
    Example: dob_score = calculate_dob_score(date(2024, 9, 30), date(2024, 9, 28))
    """        
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

    """
    Function: calculate_address_score
    Syntax: calculate_address_score(address1, address2)
    Description: Compares two address records (as DataFrame rows) using the Soundex algorithm and returns a score 
                 based on how similar the two addresses are. Prioritizes matching the municipality or barangay.
    Return: int (address similarity score)
    Example: address_score = self.calculate_address_score(df.iloc[i], df.iloc[best_full_name_index])
    """
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


    """
    Function: find_deduplicates
    Syntax: find_deduplicates(df, threshold=90)
    Description: Uses fuzzy matching to find and mark duplicate entries in a DataFrame based on similarity of names.
    Return: DataFrame with duplicate flags, summary table
    Example: df, summary_table = self.find_deduplicates(df, threshold=85)
    """

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


# %% main procedure
if __name__ == "__main__":

    filename = "DQA Training sample roster data_revised.csv"
    threshold = 90 #fuzzy match threshold
    subset = 1000 #adjust 

    # Load the dataset
    # select only necessary column to optimize system resources
    cols = ['REGION', 'PROVINCE', 'MUNICIPALITY', 'BARANGAY', 'HH_ID', 'ENTRY_ID', 'FIRST_NAME', 'MIDDLE_NAME',
           'LAST_NAME', 'EXT_NAME', 'BIRTHDAY', 'AGE', 'SEX', 'CLIENT_STATUS', 'MEMBER_STATUS',
           'RELATION_TO_HH_HEAD', 'CIVIL_STATUS',
           'GRANTEE', 'REGISTRATION_STATUS', 'HH_SET',
           'PREGNANCY_STATUS', 'CCT_TYPE']

    print('Loading data, please wait...')
    
    #remove subset argument to load entire dataset
    dsl = ds(subset=subset)
    
    df = dsl.load_from_file(path='./datasets/DQA Training sample roster data_revised.csv', usedcols=cols)
    df.columns = df.columns.str.upper()
    df['fullname'] = (df['FIRST_NAME'].fillna('') + ' ' + df['MIDDLE_NAME'].fillna('') + ' ' + df['LAST_NAME'].fillna('')).str.replace(r'\s+', ' ', regex=True).str.strip()

    # find duplicates and data encon
    dq = deduplicator_helper(threshold=threshold,checkpoint_segment=1000)
    df, dedupe_summary = dq.find_deduplicates(df)


    print('Done! Meow! meow! meow!')
