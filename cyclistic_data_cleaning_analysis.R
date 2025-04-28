
#installing packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("lubridate")


#loading data
setwd("C:/Users/alice/OneDrive/Documentos/An??lise de dados Coursera + Google/MODULE 8/Case study 1/202404???202503_Cyclistic")

#loading packages
library(tidyverse)
library(dplyr)
library(lubridate)


# Retrieve all files with the .csv extension from the working directory, and store them in a variable
aggregate_files <- list.files(pattern = "*.csv")

#read the .csv files in the aggregate_files
#and map it into a single data frame
aggregate_data <- map_df(aggregate_files, read_csv)

str(aggregate_data)

#clean data (remove NA values, filter out bad ride durations...)
cyclistic_clean_data <- aggregate_data %>% 
  select("ride_id", "rideable_type", "started_at", "ended_at",
         "start_station_name", "end_station_name", "member_casual") %>% 
  na.omit() %>% 
  mutate(trip_length = as.numeric(difftime(ended_at, started_at, units = "mins")),
         weekday = format(as.Date(started_at), "%A")) %>% 
  select("ride_id", "rideable_type","started_at", "ended_at", "start_station_name", "end_station_name",
         "weekday", "trip_length", "member_casual") %>% 
  filter(trip_length >=1, trip_length <= 1440) 



#checking duplicates
any(duplicated(cyclistic_clean_data$ride_id))
#how many duplicates
sum(duplicated(cyclistic_clean_data$ride_id))


#remove duplicates
cyclistic_clean_data <- cyclistic_clean_data %>%
  distinct(ride_id, .keep_all = TRUE)

#checking again 
any(duplicated(cyclistic_clean_data$ride_id))

# checking current unique values
unique(cyclistic_clean_data$member_casual)



#answering how do annual members and casual riders use cyclistic bikes differently

#shortest trip duration 
min(cyclistic_clean_data$trip_length)

#longest trip duration 
max(cyclistic_clean_data$trip_length)


#comparing the number of rides per month
month_count = cyclistic_clean_data %>% 
  group_by(months = month.name[month(started_at)], member_casual) %>% 
  summarize(row_count = n()) %>% 
  arrange(match(months,month.name))
#save the data frame to import into tableau
write.csv(month_count, "month count.csv", row.names=FALSE)

head(month_count)


#comparing the number of rides per days of the week
weekday_count = cyclistic_clean_data %>% 
  group_by(weekday = weekday, member_casual = member_casual) %>% 
  summarize(row_count = n())
write.csv(weekday_count, "weekday count.csv", row.names=FALSE )

View(weekday_count)



#top 5 starting locations
top_start_station <- cyclistic_clean_data %>% 
  filter(!is.na(start_station_name)) %>%
  group_by(member_casual, start_station_name) %>%
  summarize(row_count = n(), .groups = "drop") %>%
  group_by(member_casual) %>%
  slice_max(order_by = row_count, n = 5)

write.csv(top_start_station, "top_5_start_station_per_user_type.csv", row.names = FALSE)

#top 5 ending locations
top_end_station <- cyclistic_clean_data %>% 
  filter(!is.na(end_station_name)) %>%
  group_by(member_casual, end_station_name) %>%
  summarize(row_count = n(), .groups = "drop") %>%
  group_by(member_casual) %>%
  slice_max(order_by = row_count, n = 5)

write.csv(top_end_station, "top_5_end_station_per_user_type.csv", row.names = FALSE)


#comparing trip length
ride_length <- cyclistic_clean_data %>% 
  group_by(member_casual) %>% 
  summarize(mean(trip_length))
write.csv(ride_length, "ride_length.csv", row.names = FALSE)

View(ride_length)
