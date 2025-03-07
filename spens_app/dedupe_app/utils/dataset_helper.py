import pandas as pd  
import os            
from colorama import Fore
import warnings
from urllib.parse import quote_plus
import sys
from sqlalchemy import create_engine

warnings.filterwarnings("ignore")

#%% data loader 

class dataset_helper(object):
    """
    Initialize the dataset_loader object with a threshold and subset size.

    Parameters:
    subset (int): The number of rows to query from the database (default 50000000).
    """
    def __init__(self, subset=50000000):
        self.subset = subset

    def is_numeric(self,x):
        try:
            # Try to convert the value to float (handles both integers and floats)
            float(x)
            return True
        except ValueError:
            return False

    def load_from_file(self, path = './datasets', usedcols = []):
        # todo: usedcols still not working
        # Initialize an empty DataFrame
        df = pd.DataFrame()
    
        # Supported file extensions
        supported_extensions = ('.csv', '.xls', '.xlsx', '.xlsb', '.pkl')
    
        # Loop until a valid file is selected
        
        if os.path.isfile(path):
            try:
                # Load file based on its extension
                if path.endswith('.csv'):
                    df = pd.read_csv(path, encoding='utf-8')
                elif path.endswith(('.xls', '.xlsx', '.xlsb')):
                    df = pd.read_excel(path)
                elif path.endswith('.pkl'):
                    df = pd.read_pickle(path)
                
                return df.head(self.subset)  # Return the loaded DataFrame
            except Exception as e:
                print(Fore.RED + f"Error loading the file: {e}")
        
        if os.path.isdir(path): 
            while df.empty:
                print(Fore.RESET + '\nSelect file from Datasets:\n')
                all_files = []
                counter = 1
                for filename in os.listdir(path):
                    if filename.endswith(supported_extensions):
                        file_path = os.path.join(path, filename)
                        print(f"({counter}) {filename}")
                        all_files.append(file_path)
                        counter += 1
                
                print(f"({len(all_files)+1}) Back to main menu")
                        
                        
                # Check if there are any files to choose from
                if not all_files:
                    print("No valid files found in the directory.")
                    return None
        
                selected_file_index = input('\nChoice: ')
                
                # Validate numeric input
                if not self.is_numeric(selected_file_index):
                    print(Fore.RED + 'Invalid choice! Please enter a number.')
                    continue
                
                selected_file_index = int(selected_file_index)
                
                # Validate the selected index
                if 1 >= selected_file_index <= len(all_files):
                    file_path = all_files[selected_file_index - 1]
                    
                    try:
                        # Load file based on its extension
                        if file_path.endswith('.csv'):
                            df = pd.read_csv(file_path, encoding='utf-8')
                        elif file_path.endswith(('.xls', '.xlsx', '.xlsb')):
                            df = pd.read_excel(file_path)
                        elif file_path.endswith('.pkl'):
                            df = pd.read_pickle(file_path)
                        
                        return df.head(self.subset)  # Return the loaded DataFrame
                    except Exception as e:
                        print(Fore.RED + f"Error loading the file: {e}")
                elif selected_file_index == len(all_files)+1: #back to main page
                    return pd.DataFrame() #return empty dataframe
                else:
                    print(Fore.RED + 'Invalid choice! Please choose a number from the list. \n')
                

    """
    Function: load_from_directory
    Description: Loads and consolidates all Excel (.xlsx, .xlsb), CSV (.csv), and older Excel (.xls) files
                 in the specified directory into a single pandas DataFrame.
    Parameters:
    directory (str): The path to the directory containing the data files.
    Return: pandas DataFrame containing the consolidated data from all files.
    """
    def load_from_directory(self, directory = './datasets'):
        all_data_frames = []

        # Supported file extensions
        supported_extensions = ('.xlsx', '.xlsb', '.xls', '.csv')

        for filename in os.listdir(directory):
            if filename.endswith(supported_extensions):
                file_path = os.path.join(directory, filename)

                try:
                    print('> ',file_path, end = '')
                    if filename.endswith('.csv'):
                        # Load CSV file
                        df = pd.read_csv(file_path)
                    elif filename.endswith(('.xlsx', '.xls', '.xlsb')):
                        # Load Excel file
                        df = pd.read_excel(file_path)
                    
                    # Add the DataFrame to the list
                    print(' -- loaded!')
                    all_data_frames.append(df)
                except Exception as e:
                    print(Fore.RED + f"Error reading {filename}: {e}")

        # Concatenate all DataFrames into a single DataFrame
        if all_data_frames:
            consolidated_df = pd.concat(all_data_frames, ignore_index=True)
            return consolidated_df.head(self.subset)
        else:
            print("No valid data files found in the directory.")
            return pd.DataFrame()  # Return an empty DataFrame if no data was found

    """
    Function: query_postgresql_to_df
    Description: Queries data from a PostgreSQL database and returns it as a pandas DataFrame.
    
    Parameters:
    cols (list): List of columns to be selected in the SQL query.
    *args: 
        dbname (str): Name of the PostgreSQL database (positional).
        user (str): Database user (positional).
        password (str): Database password (positional).
    **kwargs:
        host (str): Database host (default 'localhost').
        port (str): Database port (default '5432').
        table_name (str): Table name to query from the database (default 'tbl_roster').
    
    Return: pandas DataFrame

    df = obj.query_postgresql_to_df(cols, 'dbname', 'user', 'password', host='localhost', port='5432', table_name='tbl_roster')

    """
    def query_postgresql_to_df(self, cols, *args, **kwargs):
        # Unpack the positional arguments
        dbname, user, password = args

        # Unpack the keyword arguments with defaults
        host = kwargs.get('host', 'localhost')
        port = kwargs.get('port', '5432')
        table_name = kwargs.get('table_name', 'tbl_roster')

        # Join the list of columns into a comma-separated string for the SQL query
        columns = ', '.join(cols)

        # Create the connection engine using SQLAlchemy for PostgreSQL
        engine = create_engine(f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}')

        # Define the SQL query to get the required columns and apply the subset limit
        query = f"""
        SELECT 
            {columns}
        FROM {table_name}
        LIMIT {self.subset}
        """

        # Execute the query and load the data into a DataFrame
        try:
            df = pd.read_sql(query, engine)
            return df.head(self.subset)
        except Exception as e:
            print(Fore.RED + f"Error fetching data from PostgreSQL!")
            return pd.DataFrame()

    """
    Function: query_mysql_to_df
    Description: Queries data from a MySQL database and returns it as a pandas DataFrame.
    
    Parameters:
    cols (list): List of columns to be selected in the SQL query.
    *args: 
        dbname (str): Name of the MySQL database (positional).
        user (str): Database user (positional).
        password (str): Database password (positional).
    **kwargs:
        host (str): Database host (default 'localhost').
        port (str): Database port (default '3306').
        table_name (str): Table name to query from the database (default 'tbl_roster').

    Return: pandas DataFrame

    Example: df = obj.query_mysql_to_df(['FIRSTNAME','MIDDLE_NAME','LAST_NAME'], 'dbname', 'user', 'password', host='localhost', port='3306', table_name='tbl_roster')
    """
    def query_mysql_to_df(self, cols, *args, **kwargs):
        # Unpack the positional arguments
        dbname, user, password = args
        password = quote_plus(password)
        # Unpack the keyword arguments with defaults
        host = kwargs.get('host', 'localhost')
        port = kwargs.get('port', '3306')
        table_name = kwargs.get('table_name', 'tbl_roster')

        # Join the list of columns into a comma-separated string for the SQL query
        columns = ', '.join(cols)

        # Create the connection engine using SQLAlchemy for MySQL
        engine = create_engine(f'mysql+pymysql://{user}:{password}@{host}:{port}/{dbname}')

        # Define the SQL query to get the required columns and apply the subset limit
        query = f"""
        SELECT 
            {columns}
        FROM {table_name}
        LIMIT {self.subset}
        """

        # Execute the query and load the data into a DataFrame
        try:
            df = pd.read_sql(query, engine)
            return df.head(self.subset)
        except Exception as e:
            print(Fore.RED + f"Error fetching data from MySQL! {e}")
            return pd.DataFrame()

# %% main procedure (for testing only! will not run when imported!)
if __name__ == "__main__":

    filename = "DQA Training sample roster data_revised.csv"
    threshold = 90 #fuzzy match threshold
    subset = 60000 #increase 

    # Load the dataset
    # select only necessary column to optimize system resources
    cols = ['REGION', 'PROVINCE', 'MUNICIPALITY', 'BARANGAY', 'HH_ID', 'ENTRY_ID', 'FIRST_NAME', 'MIDDLE_NAME',
           'LAST_NAME', 'EXT_NAME', 'BIRTHDAY', 'AGE', 'SEX', 'CLIENT_STATUS', 'MEMBER_STATUS',
           'RELATION_TO_HH_HEAD', 'CIVIL_STATUS',
           'GRANTEE', 'REGISTRATION_STATUS', 'HH_SET',
           'PREGNANCY_STATUS', 'CCT_TYPE']

    print('Loading data, please wait...')
    
    #remove subset argument to load entire dataset
    dsl = dataset_loader(subset=subset)
    
    df = pd.DataFrame()
    while df.empty:
        print(Fore.RESET)
        print('\nData Source:')
        print('(1) load from mysql')
        print('(2) load from postgresql')
        print('(3) consolidate files from datasets directory')
        print('(4) load single file from datasets directory')
        print('(5) Abort\n')
    
        choice = input('Select Choice: ')
    
        if choice == '1':
            df = dsl.query_mysql_to_df(cols, 'db_dms', 'root', 'P@ssw0rd0214', host='localhost', port='3307', table_name='tbl_pppp')
        elif choice == '2':
            df = dsl.query_postgresql_to_df(cols, 'db_dms', 'postgres', 'root', host='localhost', port='5432', table_name='tbl_roster')
        elif choice == '3':
            df = dsl.load_from_directory()
        elif choice == '4':
            df = dsl.load_from_file()
        elif choice == '5':
            print('\nGoodbye! Meow!')
            sys.exit()
            
        else:
            print(Fore.RED + 'Invalid Selection, please try again...\n')

    
    df.columns = df.columns.str.upper()
    df
