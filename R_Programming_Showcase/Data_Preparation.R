library(tidytuesdayR)
library(tidyverse)

tuesdata <- tidytuesdayR::tt_load('2020-03-24')
tbi_age <- tuesdata$tbi_age
tbi_year <- tuesdata$tbi_year
tbi_military <- tuesdata$tbi_military


# Tidy the tbi_age dataset
tbi_age <- tbi_age %>%
  rename(
    num_estimate = number_est,
    rate_estimate = rate_est
  ) %>% 
  drop_na()

# Tidy the tbi_year dataset
tbi_year <- tbi_year %>%
  mutate(
    year = as.integer(year), 
    number_est = as.numeric(number_est),
    num_estimate = number_est, 
    rate_estimate = rate_est
  ) %>% 
  drop_na()

# Tidy the tbi_military dataset
tbi_military <- tbi_military %>%
  drop_na()

save(tbi_age, tbi_year, tbi_military, file = "tidied_data.RData")
