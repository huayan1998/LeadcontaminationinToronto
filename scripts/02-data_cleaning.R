#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(lubridate)

# Set the path to the raw data file
raw_data_path <- "C:/Users/JMURI/Downloads/starter_folder-main/starter_folder-main/inputs/data/non_regulated_lead_sample.csv"

# Set the path to the cleaned data file
cleaned_data_path <- "C:/Users/JMURI/Downloads/starter_folder-main/starter_folder-main/outputs/data/cleaned_data.csv"

# Check if the file exists
if (file.exists(raw_data_path)) {
  # Read the raw data
  lead_data <- read_csv(raw_data_path)
  
  # Check the first few rows of the dataframe
  
  The error message indicates that the mutate() function is unable to find the LeadAmount_ppm column in your lead_data dataframe, similar to the previous issue with SampleDate. This suggests that the name of the column in your dataframe might be different from LeadAmount_ppm. To resolve this, you need to verify the exact name of the lead amount column in your dataframe and use that in your script.
  
  Let's follow a similar approach as before to inspect the column names:

Inspect the Dataframe: Use head() or colnames() to view the column names in lead_data.

Adjust the Script: Update your script with the correct column name based on the inspection.

Here's how you can do this:
    
    r
  Copy code
  # Read the raw data
  lead_data <- read_csv(raw_data_path)
  
  # Check the first few rows of the dataframe
  print(head(lead_data))
  
  # Check column names
  print(colnames(lead_data))
  
  # Adjust the script according to the actual column names
  # Replace 'Sample Date' and 'LeadAmount_ppm' with the correct column names
  
  lead_data <- lead_data %>%
    mutate(SampleDate = as.Date(`Actual Sample Date Column Name`, format = "%m-%d-%y")) %>%
    mutate(LeadAmount = as.numeric(`Actual Lead Amount Column Name`)) %>%

  ## Remove potential duplicates
  lead_data <- lead_data %>%
    distinct()
  
  ## Correct partial postal codes (if necessary)
  lead_data <- lead_data %>%
    mutate(PartialPostalCode = toupper(PartialPostalCode)) %>%
    mutate(PartialPostalCode = ifelse(PartialPostalCode == 'M2L ', 'M2L', PartialPostalCode))
  
  # Write the cleaned data to a new CSV file
  write_csv(lead_data, cleaned_data_path)
  
  # Print a message to the console to indicate completion
  print(paste("Data cleaning complete. Cleaned data saved to", cleaned_data_path))
} else {
  print(paste("Error: File not found at path", raw_data_path))
}
