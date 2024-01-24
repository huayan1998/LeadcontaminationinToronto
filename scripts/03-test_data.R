#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Test data ####

# Set the path to the cleaned data file
cleaned_data_path <- "C:/Users/JMURI/Downloads/starter_folder-main/starter_folder-main/outputs/data/cleaned_data.csv"

# Read the cleaned data
cleaned_data <- read.csv(cleaned_data_path)

# Test 1: Check if the cleaned data has at least one row
test_that("Data has at least one row", {
  expect_true(nrow(cleaned_data) >= 1)
})

# Test 2: Check if 'SampleDate' is a Date class
test_that("SampleDate is of Date class", {
  expect_true(is.Date(cleaned_data$SampleDate))
})

# Test 3: Check if 'LeadAmount' is numeric
test_that("LeadAmount is numeric", {
  expect_true(is.numeric(cleaned_data$LeadAmount))
})

# Test 4: Check if there are no missing values in 'SampleDate'
test_that("No missing values in SampleDate", {
  expect_false(any(is.na(cleaned_data$SampleDate)))
})

# Test 5: Check if there are no missing values in 'LeadAmount'
test_that("No missing values in LeadAmount", {
  expect_false(any(is.na(cleaned_data$LeadAmount)))
})


# Print a message indicating test completion
cat("Data tests completed successfully.\n")
