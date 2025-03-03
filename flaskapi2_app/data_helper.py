import pandas as pd  
# from thefuzz import fuzz, process  
import warnings
from datetime import datetime
from dateutil import parser

warnings.filterwarnings("ignore")

#%% dqa class
class data_helper(object):
    """
    Function: __init__
    Syntax: __init__([)
    Description: Initializes the data_helper.
    """
    def __init__(self):
        pass

    """
    Function: convert_seconds_to_hms
    Syntax: convert_seconds_to_hms(seconds)
    Description: Converts time from seconds to hours, minutes, and seconds (for estimation of time to finish)
    Return: string
    Example: time_str = convert_seconds_to_hms(3661)
    """
    def convert_seconds_to_hms(self, seconds):
        hours = seconds // 3600
        minutes = (seconds % 3600) // 60
        seconds = seconds % 60
        
        if hours > 0:    
            return f"{int(hours)}h {int(minutes)}m {int(seconds)}s"
        elif minutes > 0:
            return f"{int(minutes)}m {int(seconds)}s"
        elif seconds > 0:
            return f"{int(seconds)}s"
            

    """
    Converts a given date string into a standardized format, attempting to parse it using 
    several common date formats. If a return format is provided, the function returns the date 
    as a string formatted in 'YYYY-MM-DD'. Otherwise, it returns a `datetime` object.

    Args:
        date_str (str): The input date as a string.
        return_format (str, optional): If provided, specifies the desired output format. 
            Defaults to an empty string, which returns the date object.

    Returns:
        datetime or str: A `datetime` object if no format is specified, otherwise a formatted 
        string. Returns `None` if the input is not a valid date format.
    """
    class DateConverter:
        def convert_date(self, date_str, return_format=''):
            # Check if the date_str is already in ISO format (YYYY-MM-DD)
            try:
                iso_date = datetime.strptime(date_str, "%Y-%m-%d")
                # Return the ISO date string directly
                return date_str if return_format == '' else iso_date.strftime(return_format)
            except ValueError:
                pass  # Proceed with other formats if not ISO

            # List of common date formats, including the new birthday format
            formats = [
                "%Y-%m-%d",        # 2024-09-30
                "%d-%m-%Y",        # 30-09-2024
                "%m/%d/%Y",        # 09/30/2024
                "%d/%m/%Y",        # 30/09/2024
                "%B %d, %Y",       # September 30, 2024
                "%d %B %Y",        # 30 September 2024
                "%Y.%m.%d",        # 2024.09.30
                "%Y/%m/%d",        # 2024/09/30
                "%d %b %Y",        # 30 Sep 2024
                "%Y %m %d",        # 2024 09 30
                "%m-%d-%Y",        # 09-30-2024
                "%B %d %y",        # September 30, 24
                "%Y-%m-%d %H:%M:%S",  # 2024-09-30 14:30:00
                "%m/%d/%y",        # 09/30/24
                "%d-%b-%y"         # 28-Apr-04
            ]
        
            for fmt in formats:
                try:
                    # Attempt to parse the date with the current format
                    date_obj = datetime.strptime(date_str, fmt)
                    
                    if return_format == '':
                        return date_obj
                    else:
                        return date_obj.strftime('%Y-%m-%d')  # Return in YYYY-MM-DD format
                except ValueError:
                    continue  # Try the next format
        
            # If no formats match, use dateutil parser as a fallback
            try:
                date_obj = parser.parse(date_str)
                return date_obj.strftime('%Y-%m-%d')
            except ValueError:
                return None  # Return None if no valid date format is found



    """
    Function: convert_to_date
    Syntax: convert_to_date(date)
    Description: Convert vast date format to standard date format of python 
    Return: datetime.date
    Example: df['BIRTHDAY'] = df['BIRTHDAY'].apply(self.convert_to_date)
    """
    def convert_to_date(self, birthday_str):
        try:
            # Attempt to parse the date using pandas' automatic inference
            return pd.to_datetime(birthday_str, errors='coerce')
        except Exception as e:
            # If parsing fails, return NaT
            print(Fore.RED + f"Error parsing {birthday_str}: {e}")
            return pd.NaT



    