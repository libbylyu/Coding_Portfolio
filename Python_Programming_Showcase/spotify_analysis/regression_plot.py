import seaborn as sns
import matplotlib.pyplot as plt

def scat_plot(data, x, y, title):
    '''
    Create a scatter plot with a best fit line using seaborn.

    Parameters:
    - data: input data frame
    - x: predictor variable
    - y: dependent variable
    - title: title for the plot

    Returns:
    - fig: The matplotlib figure associated with the plot
    '''
    # Create a scatter plot with a best fit line
    sns.lmplot(x=x, y=y, data=data, line_kws={'color': 'red'}, scatter_kws={'alpha': 0.5})
    
    # Set the title of the plot if provided
    if title:
        plt.title(title)
    
    # Get the current figure to return
    fig = plt.gcf()
    
    return fig



