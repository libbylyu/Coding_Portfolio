import pandas as pd

def clean_data(data, necessary_columns = None):
    """
    Clean the loaded data by keeping only necessary columns and filtering out rows with NA values.
    
    Parameters:
    - data (DataFrame): The loaded data as a pandas DataFrame.
    - necessary_columns (list of str): List of column names to keep. If None, keep all columns.
    
    Returns:
    - DataFrame: The cleaned data.
    """

    if necessary_columns is not None:
        data = data[necessary_columns]
    
    cleaned_data = data.dropna(subset=necessary_columns)
    
    return cleaned_data

