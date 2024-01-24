#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

# Toronto Open Data is stored in a CKAN instance. It's APIs are documented here:
# https://docs.ckan.org/en/latest/api/

#### Workspace setup ####
# Load the required libraries
library(opendatatoronto)
library(httr)
library(readr)

# Set the base URL for the CKAN API
base_url <- "https://ckan0.cf.opendata.inter.prod-toronto.ca"

# Define the path where the CSV will be saved
save_path <- "C:/Users/JMURI/Downloads/starter_folder-main/starter_folder-main/inputs/data"

# Get the package metadata using the CKAN API
url <- paste0(base_url, "/api/3/action/package_show")
params <- list(id = "non-regulated-lead-sample")
response <- GET(url, query = params)
package <- content(response, "parsed")

# Check if the package information was retrieved successfully
if (!is.null(package$result)) {
  # Loop through each resource in the package
  for (resource in package$result$resources) {
    # Check if the resource is active in the datastore
    if (resource$datastore_active) {
      # Construct the URL to download the resource in CSV format
      csv_url <- paste0(base_url, "/datastore/dump/", resource$id)
      
      # Make the request to download the CSV data
      csv_response <- GET(csv_url)
      
      # Check if the request was successful
      if (status_code(csv_response) == 200) {
        # Define the full path for the CSV file
        csv_file_path <- file.path(save_path, paste0(resource$name, ".csv"))
        
        # Write the content to a CSV file
        writeBin(content(csv_response, "raw"), csv_file_path)
        print(paste("Resource data saved to", csv_file_path))
      } else {
        print(paste("Failed to download the resource data for resource", resource$id))
      }
    }
  }
} else {
  print("Failed to retrieve package information.")
}

