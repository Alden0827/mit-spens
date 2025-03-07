##! pip install rich
##! pip install psycopg2-binary
##| pip install pymysql


import warnings 
import os
import pandas as pd
from tqdm import tqdm
# from rich.console import console
from rich.console import Console
from rich.spinner import Spinner
from rich.table import Table
from rich.progress import Progress
from rapidfuzz import process, fuzz

import pymysql

import sqlalchemy
from sqlalchemy import create_engine

warnings.filterwarnings('ignore') 
warnings.warn('Warning ignored!') 


class dataset_helper:
    def __init__(self):
        # Define the directory and output pickle folder
        self.input_directory = './data/roster'
        self.output_directory = './data/pickles'
        self.chunk_size = 200000

        # Ensure the output directory exists
        os.makedirs(self.output_directory, exist_ok=True)
        self.console = Console()


    def get_roster_dir_size(self):
        total_size = 0
        for dirpath, dirnames, filenames in os.walk(self.input_directory):
            for filename in filenames:
                filepath = os.path.join(dirpath, filename)
                total_size += os.path.getsize(filepath)
        return total_size

    def df_columns_mapper(self, list_1, list_2):
        arranged_list = []
        matched_items = set()  # To track already matched items

        # Normalize both lists to lowercase for better matching
        normalized_list_1 = [item.upper() for item in list_1]
        normalized_list_2 = [item.upper() for item in list_2]


        for item in normalized_list_1:
            # Find the best match in list_2 for the current item in list_1
            best_match = process.extractOne(item, normalized_list_2, scorer=fuzz.token_sort_ratio)

            # Debugging output to see the best match and its score
            if best_match and best_match[1] > 30:  # Adjust threshold here if needed
                match = best_match[0]
                if match not in matched_items:  # Check if already matched
                    arranged_list.append(match)  # Append the matched item
                    matched_items.add(match)  # Mark as matched

        return arranged_list


    def load_from_database(self, table_name='tbl_roster', host='localhost', port='5432', engine='postgresql+psycopg2', db='db_dms', password='root', username='postgres', subset='0'):
        '''
            parameters: 
                engine = 'postgresql+psycopg2|mysql+pymysql'
                port: '5432|3306'
        '''
        # Create a database engine
        engine = create_engine(f'{engine}://{username}:{password}@{host}:{port}/{db}')

        if subset == '0':
            subset = '100000000' # display all

        with self.console.status(f"[bold green]Loading data from '{db}.{table_name}'...", spinner="dots9"):
            try:
                # Use engine.connect() to get a valid SQLAlchemy connection
                with engine.connect() as conn:
                    # Read the table directly using pd.read_sql_table
                    # df = pd.read_sql_table(table_name, con=conn)
                    query = f"SELECT * FROM {table_name} limit {subset};" 
                    result = conn.execute(query)
                    df = pd.DataFrame(result.fetchall(), columns=result.keys())
                    df.columns = df.columns.str.upper()

                self.console.print(f"[bold green]Successfully loaded {len(df)} rows from '{table_name}'.")
                return df
            except Exception as e:
                self.console.print(f"[bold red]Error loading data from '{table_name}': {e}")
                return pd.DataFrame()

        try:
            # Use a SQLAlchemy connection to execute a query
            with engine.connect() as connection:
                query = f"SELECT * FROM {table_name};"  # SQL query to select all data from the table
                result = connection.execute(query)  # Execute the query
                
                # Convert the result to a DataFrame
                df_fetched = pd.DataFrame(result.fetchall(), columns=result.keys())
                df_fetched.columns = df_fetched.columns.str.upper()


                return df_fetched
        except SQLAlchemyError as e:
            print(f'Error fetching data from {table_name}: {e}')
            return None

    def load_file(self, file_path):
        """Loads data from various file formats into a DataFrame."""
        if file_path.lower().endswith('.csv'):
            return pd.read_csv(file_path)
        elif file_path.lower().endswith('.xlsx'):
            return pd.read_excel(file_path)
        elif file_path.lower().endswith('.xls'):
            return pd.read_excel(file_path)
        elif file_path.lower().endswith('.xlsb'):
            return pd.read_excel(file_path, engine='pyxlsb')
        elif file_path.lower().endswith('.pkl'):
            return pd.read_pickle(file_path)
        else:
            raise ValueError(f"Unsupported file format: {file_path}")

    def pickles_are_updated(self):
        roster_dir_size = self.get_roster_dir_size()
        pickle_file = os.path.join(self.output_directory, 'roster_chunk_1.pkl')
        if os.path.exists(pickle_file):
            chunk_df = pd.read_pickle(pickle_file)
            return chunk_df['roster_dir_size'] == roster_dir_size
        return False


    def files_to_pickles(self):

        # Create a rich Console object for display
        console = Console()

        if processor.pickles_are_updated():
            console.print(f"[bold green]Chill out! Pickles seems to be updated!")
            return None


        roster_dir_size = self.get_roster_dir_size()

        """Converts files in the input directory to pickle files in chunks."""
        # Initialize an empty list to store dataframes
        dataframes = []
        

        # Loop through the files in the directory
        file_list = os.listdir(self.input_directory)
        for index, filename in enumerate(file_list):
            file_path = os.path.join(self.input_directory, filename)

            # Use a spinner while reading each file
            with console.status(f"[bold green]({index+1}/{len(file_list)}) Processing '{filename}'...", spinner="dots9"):
                try:
                    # Load the data file into a DataFrame
                    df = self.load_file(file_path)
                    dataframes.append(df)
                except Exception as e:
                    console.print(f"[bold red]Error reading {filename}: {e}")

        # Concatenate all the DataFrames into one
        if dataframes:
            consolidated_df = pd.concat(dataframes, ignore_index=True)
            
            # Calculate the number of chunks
            num_chunks = (len(consolidated_df) // self.chunk_size) + 1

            # Use rich progress bar to save chunks
            with Progress() as progress:
                task = progress.add_task("[green]Saving chunks...", total=num_chunks)
                
                for i in range(num_chunks):

                    chunk = consolidated_df[i * self.chunk_size:(i + 1) * self.chunk_size]
                    chunk_file = os.path.join(self.output_directory, f'roster_chunk_{i + 1}.pkl')

                    # Save each chunk as a pickle file

                    combined_data = {
                        'roster_dir_size': roster_dir_size,
                        'data': chunk
                    }

                    pd.to_pickle(combined_data,chunk_file)
                    # chunk.to_pickle(chunk_file)

                    # Update the progress bar
                    progress.advance(task)

            console.print("[bold green]All chunks saved successfully.")
        else:
            console.print("[bold red]No files found or processed.")

    def merge_pickles(self, output_filename='merged_roster.pkl'):
        """Merge all the pickles in the output directory into a single pickle file."""
        dataframes = []
        console = Console()

        # List all the pickle files
        pickle_files = [f for f in os.listdir(self.output_directory) if f.lower().endswith('.pkl')]

        # Check if there are any pickle files
        if not pickle_files:
            console.print("[bold red]No pickle files found or processed.")
            return

        # Use rich progress bar to track merging
        with Progress() as progress:
            task = progress.add_task("[green]Loading pickles...", total=len(pickle_files))

            for filename in pickle_files:
                file_path = os.path.join(self.output_directory, filename)
                try:
                    # Load each pickle into a DataFrame
                    chunk = pd.read_pickle(file_path)
                    df = chunk['data']

                    dataframes.append(df)
                except Exception as e:
                    console.print(f"[bold red]Error reading {filename}: {e}")
                
                # Advance progress after processing each file
                progress.advance(task)

        if dataframes:
            # Concatenate all the DataFrames into one
            consolidated_df = pd.concat(dataframes, ignore_index=True)
            # console.print("[bold green]Pickles are loaded!.")
            return consolidated_df

    def display_dataframe(self, df, subset=10):
        """Displays the DataFrame using rich's Table."""
        console = Console()

        if df.empty:
            console.print("[bold red]The DataFrame is empty.")
            return

        if subset > 100:
            console.print("[bold red]The display_dataframe function is designed exclusively for previewing DataFrame data, with a maximum limit of 100 rows for display.")
            return

        # Create a rich Table
        table = Table(show_header=True, header_style="bold magenta")

        # Add columns to the table from DataFrame columns
        for col in df.columns:
            table.add_column(col)

        # Add rows to the table (limit to 10 rows for brevity)
        for _, row in df.head(subset).iterrows():
            table.add_row(*[str(item) for item in row])

        # Display the table using console
        console.print(table)

if __name__ == "__main__":

    columns = ['PROVNCES', 'MUNICIPALITIES', 'BARANGA',
           'GEOCODE', 'HH_ID', 'ENTRY_ID', 'FIRSTNAME', 'MIDDLE_NAME',
           'LAST_NAME'  , 'BIRTHDAY']

    processor = dataset_helper()

    


    # #OFFLINE FILES LOADING AND CACHING (PICKLE) TEST  
    processor.files_to_pickles()
    df = processor.merge_pickles(processor.input_directory)
    mapped_columns = processor.df_columns_mapper(columns, df.columns.tolist())
    processor.display_dataframe(df[mapped_columns], subset=20)

    # #POSTGRESQL CONNECTIVITY TEST
    # df = processor.load_from_database(subset='100000')
    # mapped_columns = processor.df_columns_mapper(columns, df.columns.tolist())
    # processor.display_dataframe(df[mapped_columns], subset=100)

    # #MYSQL CONNECTIVITY TEST
    # df = processor.load_from_database(subset='10000', engine='mysql+pymysql', username='root', password='', port='3333',table_name='tbl_users')
    # processor.display_dataframe(df, subset=20)

