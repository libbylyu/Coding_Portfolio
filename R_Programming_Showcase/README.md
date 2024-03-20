# TBI Social Science Research

This repository is dedicated to the analysis and visualization of data on Traumatic Brain Injury (TBI) as part of a social science research project. The goal is to explore various aspects of TBI, including its prevalence, causes, and impact on different demographics, with a focus on service members and veterans.

## Scripts

-   `data_preparation.R`: This script is responsible for loading and cleaning the TBI datasets. To run this script, ensure you have `tidyverse` and `tidytuesdayR` packages installed.
-   `Analysis and Visualization Part.R`: Contains the code for all analyses and visualizations. It sources the cleaned data from the `data_preparation.R` script.
-   `TBI Research Report.Rmd`: The main R Markdown document that compiles the analysis into a coherent report.

## Visualization Outputs

The `graphs/` directory contains all the plots saved from the analysis. These images are referenced in the main report and can be viewed directly in the repository.

## How to Use

To replicate the analysis:

1.  Clone this repository to your local machine.
2.  Open and run the `data_preparation.R` script to load and clean the data, which automatically saves datasets into `tidied_data.RData`.
3.  Open the `Analysis and Visualization Part.R` script to generate the visualizations.
4.  Knit the `TBI Research Report.Rmd` to generate the final report.

## Reflections

In terms of resources, the `tidytuesdayR` community provided invaluable examples and support. The journey of analyzing Traumatic Brain Injury (TBI) data has been both enlightening and challenging. One of the more difficult aspects was ensuring that the data cleaning process was thorough enough to facilitate accurate analyses, especially given the complex and sensitive nature of medical data. It was imperative to handle missing values and outliers with care to maintain the integrity of the datasets. Creating visualizations that effectively communicated the research findings was particularly rewarding. The process of translating raw data into clear, understandable graphics allowed me to explore the creative side of data science. While crafting these visualizations, I became more proficient with `ggplot2`, learning to customize plots to a greater degree than I had previously.

Throughout this project, problem-solving was a constant companion. For instance, I encountered challenges when trying to compare TBI incidence across different military branches. The data was not immediately comparable due to discrepancies in reporting and categorization. To address this, I normalized the data based on the size of each branch, which allowed for a more accurate comparison. Reflecting on the coding aspects, I appreciated the importance of writing clean, readable code. I learned to better structure my scripts with clear annotations and logical flow, which not only made the process smoother but also will aid anyone who wishes to replicate the analysis.

For any issues or questions regarding the repository or the analysis, please email me [wanzlyu\@uchicago.edu](mailto:wanzlyu@uchicago.edu){.email}, and I will respond as soon as possible.
