# This is part of coding for data analysis and visualization.
# It sources the cleaned data from the `Data_Preparation.R` script, 
# and saves graphs in `graphs` folder.

library(tidyverse)
load("tidied_data.RData")

# Prevalence of TBI Types
# What is the distribution of TBI types (mild, moderate, severe) among service members and veterans?
  
# Aggregate data to count each type of TBI
tbi_types_count <- tbi_military %>%
  filter(severity %in% c("Mild", "Moderate", "Severe")) %>%
  group_by(severity) %>%
  summarise(count = sum(diagnosed))

# Create a bar chart to show the distribution
ggplot(tbi_types_count, aes(x = severity, y = count, fill = severity)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = count), vjust = -0.5, color = "black") +
  labs(title = "Distribution of TBI Types among Service Members and Veterans", 
       caption = "Source: CDC",
       x = "TBI Type", 
       y = "Number of Cases") +
  theme_minimal()

ggsave ("graphs/prevalence.png", width = 8, height = 6, units = "in")


# Causes of TBI:
# What percentage of TBIs are caused by falls, struck by/against, motor vehicle, and assault?

# Calculate the total counts for each injury mechanism
tbi_causes <- tbi_age %>%
  group_by(injury_mechanism) %>%
  summarise(total_estimate = sum(num_estimate, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(total_estimate))

# Define the new labels
new_labels <- c(
  "Unintentional Falls" = "Falls",
  "Unintentionally struck by or against an object" = "Struck by/Against",
  "Motor Vehicle Crashes" = "Motor Vehicle"
)

# Separate the top 4 causes and apply new labels
top_causes <- tbi_causes %>%
  slice(1:4) %>%
  mutate(injury_mechanism = recode(injury_mechanism, !!!new_labels))

# Sum the rest into "Unknown/Other"
other_causes <- tbi_causes %>%
  slice(5:n()) %>%
  summarise(injury_mechanism = "Unknown/Other", total_estimate = sum(total_estimate))

# Combine top causes with "Unknown/Other" and arrange by percentage
final_causes <- bind_rows(top_causes, other_causes) %>%
  mutate(percentage = (total_estimate / sum(total_estimate)) * 100) %>%
  arrange(desc(percentage)) %>%
  mutate(injury_mechanism = fct_inorder(injury_mechanism))

# Plot the pie chart with the slices ordered by percentage
ggplot(final_causes, aes(x = "", y = percentage, fill = injury_mechanism)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  theme_void() +
  theme(legend.title = element_blank()) +
  scale_fill_manual(values = c("Falls" = "#EEB8C3", "Motor Vehicle" = "#2B333E",
                               "Struck by/Against" = "#C08EAF", "Assault" = "#5D655F", 
                               "Unknown/Other" = "#74759B")) +
  labs(title = "Proportional Distribution of TBI Causes: Falls, Struck by/Against, Motor Vehicle, and Assault",
       caption = "Source: CDC") +
  geom_text(aes(label = paste0(injury_mechanism, ": ", round(percentage, 1), "%")), 
            position = position_stack(vjust = 0.7), color = "white", size = 3)

ggsave ("graphs/cause.png", width = 10, height = 6, units = "in")


# TBI Incidence Among Different Components of Service Members and Veterans:
# How does the incidence of TBI compare across different components (Active, Guard, Reserve) within various branches of service members and veterans?
  
plots_list <- list()
branches <- unique(tbi_military$service)

# For loop to create a plot for each branch
for (i in 1:length(branches)) {
  # Filter the data for the current branch
  branch_data <- tbi_military %>%
    filter(service == branches[i]) %>%
    group_by(component) %>%
    summarise(tbi_cases = sum(diagnosed)) # Summarize to get the total count per component
  
  plot_name <- paste("graphs/", gsub(" ", "_", branches[i]), ".png", sep = "")
  
  # Create a bar plot for the current branch
  plots_list[[i]] <- ggplot(branch_data, aes(x = component, y = tbi_cases, fill = component)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = tbi_cases), vjust = -0.3, color = "black") + # Add text labels on the bars
    theme_minimal() +
    labs(title = paste("TBI Incidence in", branches[i], "by Component"),
         caption = "Source: CDC",
         x = "Component",
         y = "Number of TBI Cases") +
    scale_fill_brewer(palette = "Set1")
  
    ggsave(plot_name, width = 8, height = 6, units = "in")
}

plots_list

# Age and TBI Deaths Result:
# What is the distribution of the death/non-death result of TBI among the age of the individual (including children)?
  
calculate_and_plot <- function(data, age) {
  
  # Create a new data frame for the specified age group
  specific_age_data <- data %>%
    filter(age_group == age) %>%
    mutate(outcome = if_else(type == "Deaths", "Death", "Non-Death")) %>%
    group_by(outcome) %>%
    summarise(total_num_estimate = sum(num_estimate, na.rm = TRUE), .groups = 'drop') %>%
    mutate(percentage = total_num_estimate / sum(total_num_estimate) * 100)
  
  
  plot_name <- paste("graphs/", gsub(" ", "_", age), ".png", sep = "")
  # Create the plot
  plot <- ggplot(specific_age_data, aes(x = outcome, y = total_num_estimate, fill = outcome)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = sprintf("%1.1f%% (%d)", percentage, total_num_estimate)), vjust = -0.3, color = "black") +
    labs(title = paste("TBI Outcomes in Age Group", age),
         caption = "Source: CDC",
         x = "Outcome",
         y = "Total Number Estimate") +
    theme_minimal() +
    scale_fill_brewer(palette = "Set1")
  

  return(ggsave(plot_name, width = 8, height = 6, units = "in"))
}

# Use the function to create plots for specific age groups
calculate_and_plot(tbi_age, "5-14")
calculate_and_plot(tbi_age, "75+")




