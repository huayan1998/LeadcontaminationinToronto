# Load necessary libraries
library(readr)
library(dplyr)
library(ggplot2)

# Set the path to the data file
data_file_path <- "inputs/data/simulated_lead_data.csv"

# Read the data
data <- read_csv(data_file_path)

# Convert 'SampleDate' to datetime type and 'LeadAmount_ppm' to numeric
data$SampleDate <- as.Date(data$SampleDate)
data$LeadAmount_ppm <- as.numeric(data$LeadAmount_ppm)

# Time Series Analysis: Lead Levels Over Time
ggplot(data, aes(x = SampleDate, y = LeadAmount_ppm)) +
  geom_line() +
  labs(
    title = "Time Series of Lead Levels",
    x = "Date",
    y = "Lead Amount (ppm)"
  ) +
  theme_minimal() +
  ggsave("lead_levels_time_series.png", width = 10, height = 6)

# Geographical Analysis: Average Lead Levels by Postal Code
avg_lead_by_postal <- data %>%
  group_by(PartialPostalCode) %>%
  summarise(AvgLeadAmount_ppm = mean(LeadAmount_ppm, na.rm = TRUE))

ggplot(avg_lead_by_postal, aes(x = PartialPostalCode, y = AvgLeadAmount_ppm)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(
    title = "Average Lead Levels by Partial Postal Code",
    x = "Partial Postal Code",
    y = "Average Lead Amount (ppm)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave("lead_levels_by_postal_code.png", width = 12, height = 6)

# Distribution of Lead Levels
ggplot(data, aes(x = LeadAmount_ppm)) +
  geom_histogram(binwidth = 0.1, fill = "green", color = "black") +
  labs(
    title = "Distribution of Lead Levels",
    x = "Lead Amount (ppm)",
    y = "Frequency"
  ) +
  theme_minimal() +
  ggsave("lead_levels_distribution.png", width = 10, height = 6)

