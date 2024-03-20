import pandas as pd


def load_data(path):
    """
    Load data from a CSV file.
    
    Parameters:
    path (str): Path to the CSV file.
    
    Returns:
    pandas.DataFrame: Data from the CSV file.
    """
    
    data = pd.read_csv(path)
    
    return data
