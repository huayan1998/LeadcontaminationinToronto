#### Preamble ####
# Purpose: Analyze and visualize lead data over time.
# Author: Rohan Alexander
# Date: 24 January 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: R, dplyr, ggplot2
# Any other information needed? Please add any relevant information here.

#### Workspace setup ####
library(tidyverse)
library(lubridate)
library(conflicted)

# Set seed for reproducibility
set.seed(123)

# Define the number of samples to simulate
num_samples <- 12810 # The number of records in the actual dataset

# Simulate 'Sample Number' assuming they are unique identifiers
sample_numbers <- sample(1000000:9999999, num_samples, replace = FALSE)

# Simulate 'Sample Date' within the range of the actual dataset
start_date <- as.Date('2014-01-01') # Start date from dataset
end_date <- as.Date('2024-01-02') # End date from dataset
sample_dates <- seq.Date(start_date, end_date, length.out = num_samples)

# Simulate 'PartialPostalCode' based on the actual dataset
partial_postal_codes <- sample(c('M4E', 'M4K', 'M1L', 'M3B', 'M6H', 'M4J', 'M4M', 'M4G', 'M4C',
                                  'M6E', 'M6P', 'M6N', 'M4L', 'M4R', 'M2M', 'M9B', 'M6J', 'M8Z',
                                  'M5N', 'M5R', 'M6C', 'M1G', 'M6M', 'M6R', 'M4P', 'M5M', 'M1R',
                                  'M2J', 'M6S', 'M9A', 'M1N', 'M3H', 'M2N', 'M1E', 'M6A', 'M5T',
                                  'M4S', 'M6G', 'M4N', 'M1M', 'M3M', 'M4B', 'M6K', 'M5P', 'M3J',
                                  'M1P', 'M8V', 'M8W', 'M1H', 'M9C', 'M9R', 'M4V', 'M4T', 'M6B',
                                  'M4W', 'M5S', 'M9P', 'M5A', 'M2P', 'M1S', 'M8Y', 'M3A', 'M2H',
                                  'M8X', 'M1B', 'M2R', 'M9W', 'M3K', 'M1V', 'M4Y', 'M1T', 'M5V',
                                  'M2L', 'M2K', 'M1K', 'M9M', 'M9N', 'M4X', 'M1J', 'M1C', 'M9V',
                                  'M3C', 'M5H', 'M5B', 'M5G', 'M6L', 'M3L', 'M4A', 'M1X',
                                  'M3N', 'M5J', 'M5K', 'M1W', 'M5C', 'M9L', 'M5E'), num_samples, replace = TRUE)

# Simulate 'Lead Amount (ppm)' based on the actual dataset
# We'll create a mixture of detectable values and "<0.00005" to reflect the distribution
detectable_lead_levels <- rnorm(num_samples * 0.7, mean = 0.005, sd = 0.005)
non_detectable_lead_levels <- rep('<0.00005', num_samples * 0.3)
# Ensure no negative values
detectable_lead_levels[detectable_lead_levels < 0] <- 0
# Combine and shuffle them
lead_amounts <- sample(c(as.character(detectable_lead_levels), non_detectable_lead_levels))

# Combine all simulated columns into a dataframe
simulated_data <- tibble(
  id = row_number(),
  SampleNumber = sample_numbers,
  SampleDate = sample_dates,
  PartialPostalCode = partial_postal_codes,
  LeadAmount_ppm = lead_amounts
)

# Write the simulated data to a CSV file
write_csv(simulated_lead_data, "inputs/data/simulated_lead_data.csv")

# Print out a message to the user
print("Simulated data has been generated and written to inputs/data/simulated_lead_data.csv")

