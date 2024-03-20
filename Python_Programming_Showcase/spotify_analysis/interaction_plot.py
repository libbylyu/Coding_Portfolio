import pandas as pd
import plotly.express as px

def categorize_release_date(release_date):
    if '201' in release_date:
        return '10s'
    elif '200' in release_date:
        return '00s'
    elif '199' in release_date:
        return '90s'
    else:
        return 'other'

def plot_popularity_by_release_time(df):
    if 'track_album_release_date' not in df.columns:
        raise ValueError("DataFrame must contain 'track_album_release_date' column.")

    # Apply the categorization function and create a new column 'Release Time'
    df['Release Time'] = df['track_album_release_date'].apply(categorize_release_date)

    # Generate summary statistics and frequency count for 'Release Time'
    print("Summary statistics for 'Release Time':\n", df['Release Time'].describe())
    release_time_frequency = df['Release Time'].value_counts()
    print("Frequency count for 'Release Time':\n", release_time_frequency)

    # Create an interactive scatter plot
    fig = px.scatter(df, x='Release Time', y='track_popularity', color='track_artist',
                     title='Popularity of Tracks by Artist Name and Release Year Category',
                     labels={'track_popularity': 'Popularity', 'Release Time': 'Release Year Category'},
                     hover_data=['track_artist'])

    # Show the figure
    fig.show()
    fig.write_html("artists_popularity_year.html")




