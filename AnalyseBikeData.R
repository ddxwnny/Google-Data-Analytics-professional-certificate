# INSTALLED PACKAGES #
# tidyverse
# lubridate
# ggplot
# readr
# dplyr
# skimr

# tidyverse
install.packages("tidyverse")

# lubridate
install.packages("lubridate")

# ggplot
install.packages("ggplot2")

# readr
install.packages("readr")

# dplyr
install.packages("dplyr")

#skimr
install.packages("skimr")

library(tidyverse)
library(lubridate)
library(ggplot2)
library(readr)
library(dplyr)
library(skimr)

# # # # # # # # # # # # # # # # # # # # # # # # # # # 
#------------------------
# UPDATING WORKING DIRECTORY
#------------------------

# checking my current working directory 
getwd() 

# updating my working directory
myWD <- "/Users/dawn/OneDrive - Nanyang Technological University/Coursera certifications/Google Data Analytics/capstone project/2023 monthly trip data"
setwd(myWD)

#! ensure that when i key myWD, start from the first location, eg. /Users etc. 

# double check my updated working directory
getwd()

#------------------------
# STEP 1: importing data
#------------------------

# uploading .csv datas
jan2023 <- read_csv("202301-divvy-tripdata.csv")
feb2023 <- read_csv("202302-divvy-tripdata.csv")
mar2023 <- read_csv("202303-divvy-tripdata.csv")
apr2023 <- read_csv("202304-divvy-tripdata.csv")
may2023 <- read_csv("202305-divvy-tripdata.csv")
jun2023 <- read_csv("202306-divvy-tripdata.csv")
jul2023 <- read_csv("202307-divvy-tripdata.csv")
aug2023 <- read_csv("202308-divvy-tripdata.csv")
sep2023 <- read_csv("202309-divvy-tripdata.csv")
oct2023 <- read_csv("202310-divvy-tripdata.csv")
nov2023 <- read_csv("202311-divvy-tripdata.csv")
dec2023 <- read_csv("202312-divvy-tripdata.csv")

#------------------------
# STEP 2: KEEPING COLUMN CONSISTENT & COMBINING ALL DATA INTO SINGLE DATA FRAME
#------------------------

# checking columns
colnames(jan2023)
colnames(feb2023)
colnames(mar2023)
colnames(apr2023)
colnames(may2023)
colnames(jun2023)
colnames(jul2023)
colnames(aug2023)
colnames(sep2023)
colnames(oct2023)
colnames(nov2023)
colnames(dec2023)

# all column names checked & there are no discrepancies

#remove unnecessary columns for jan - dec
jan2023 <- jan2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
feb2023 <- feb2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
mar2023 <- mar2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
apr2023 <- apr2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
may2023 <- may2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
jun2023 <- jun2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
jul2023 <- jul2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
aug2023 <- aug2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
sep2023 <- sep2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
oct2023 <- oct2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
nov2023 <- nov2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)
dec2023 <- dec2023 %>% select(-start_lng, -start_lat, -end_lng, -end_lat)

# rename member_casual to user_type to avoid confusion
jan2023 <- jan2023 %>% rename(user_type = member_casual)
feb2023 <- feb2023 %>% rename(user_type = member_casual)
mar2023 <- mar2023 %>% rename(user_type = member_casual)
apr2023 <- apr2023 %>% rename(user_type = member_casual)
may2023 <- may2023 %>% rename(user_type = member_casual)
jun2023 <- jun2023 %>% rename(user_type = member_casual)
jul2023 <- jul2023 %>% rename(user_type = member_casual)
aug2023 <- aug2023 %>% rename(user_type = member_casual)
sep2023 <- sep2023 %>% rename(user_type = member_casual)
oct2023 <- oct2023 %>% rename(user_type = member_casual)
nov2023 <- nov2023 %>% rename(user_type = member_casual)
dec2023 <- dec2023 %>% rename(user_type = member_casual)

# merge monthly dataframe into a single data frame
monthly2023 <- bind_rows(jan2023, feb2023, mar2023, apr2023, may2023, jun2023, jul2023, aug2023, sep2023, oct2023, nov2023, dec2023)
str(monthly2023)

# remove individual monthly dataframe to save space 
remove(jan2023, feb2023, mar2023, apr2023, may2023, jun2023, jul2023, aug2023, sep2023, oct2023, nov2023, dec2023)

#------------------------
# STEP 3: CLEANING DATA & ADD DATA TO PREPARE FOR ANALYSIS
#------------------------

##--## ADDING DATA ##--##

# information of merged data frame
colnames(monthly2023) # there are 9 columns 
str(monthly2023) # there are 5719877 rows
summary(monthly2023)  
dim(monthly2023)

# separate date & time for started_at & ended_at
monthly2023 <- monthly2023 %>% mutate(start_date = as.Date(started_at))
monthly2023 <- monthly2023 %>% mutate(start_time = as.POSIXct(started_at, format = "%H:%M:%S"))
monthly2023 <- monthly2023 %>% mutate(end_date = as.Date(ended_at))
monthly2023 <- monthly2023 %>% mutate(end_time = as.POSIXct(ended_at, format = "%H:%M:%S"))

# calculate the ride duration
monthly2023 <- monthly2023 %>% mutate(trip_duration = difftime(ended_at, started_at, units = "mins"))

# change data type from difftime to numeric
monthly2023$trip_duration <- as.numeric(monthly2023$trip_duration) 

# checking the summary 
str(monthly2023)
summary(monthly2023)
# MIN, MAX, MEAN, MEDIAN
# MIN:-16656.52 minutes (this does not make sense and should be removed)
# MAX: 98489.07 minutes (this may be too long, we have to check to verify)
# MEAN: 18.17 minutes (18.17 minutes was the average ride duration)
# MEDIAN: 9.53 minutes (9.53 minutes was the most common ride duration)

##--## CLEANING DATA ##--##

# removing NULL values
monthly2023 <- monthly2023 %>% drop_na()

# remove duplicate rows
monthly2023 <- distinct(monthly2023)

# removing ride duration with negative values
monthly2023 <- monthly2023[monthly2023$trip_duration > 0,]
summary(monthly2023) # checked & ensure that all negative values are removed

# currently, max is 121136.300 minutes, which is very long and does not seem feasible. 
# identify outliers
summary(monthly2023$trip_duration)
Q1 <- 5.617
Q3 <- 17.483
IQR <- Q3 - Q1
print(IQR)
L_outlier <- Q1-1.5*(IQR)
H_outlier <- Q3+1.5*(IQR)
print(L_outlier)
print(H_outlier) # trip_duration > 35.282 is an outlier

# count no. of outliers 
outlier_count <- monthly2023 %>% 
  filter(trip_duration > 35.282)
nrow(outlier_count) # there are 328300 rows with trip_duration > 35.282

# removing outliers
monthly2023_withoutoutliers <- monthly2023 %>% filter(trip_duration <= 35.282)

# comparing stats including & excluding outliers
summary(monthly2023_withoutoutliers) # outliers excluded
# MIN: 0.01667 minutes 
# MAX: 35.26667 minutes 
# MEAN: 11.09902 minutes
# MEDIAN: 9.06667 minutes

summary(monthly2023) # outliers included
# MIN: 0.017 minutes 
# MAX: 12136.3 minutes 
# MEAN: 15.955 minutes
# MEDIAN: 9.800 minutes

#------------------------
# STEP 4: VISUALISATION & ANALYSIS
#------------------------

# number of casual & member users
with_outlier_users <- table(monthly2023$user_type) # casual: 1531646, member: 2799608
without_outlier_users <- table(monthly2023_withoutoutliers$user_type) # casual: 1304410, member: 2698544
# from here, there are about 2 times more casual users that are considered outliers
# we are interested in the riding habits of casual users, so I have decided to include the outliers in the analysis

# mean trip_duration of casual & member users (in minutes)
mean_user_duration <- monthly2023 %>% aggregate(trip_duration ~ user_type, FUN = mean) # casual: 22.9417, member: 12.1326

# median of trip_duration of casual & member users (in minutes)
median_user_duration <- monthly2023 %>% aggregate(trip_duration ~ user_type, FUN = median) # casual: 12.750000, member: 8.616667

# min of trip_duration of casual & member users (in minutes)
min_user_duration <- monthly2023 %>% aggregate(trip_duration ~ user_type, FUN = min) # casual: 0.01666667, member: 0.01666667

# max of trip_duration of casual & member users (in minutes)
max_user_duration <- monthly2023 %>% aggregate(trip_duration ~ user_type, FUN = max) # casual: 12136.300, member: 1497.867
# this is in line with the observation that the casual users are spending long hours riding the bikes, and may be seen as the outliers

# mean trip_duration by day & user_type
monthly2023 <- monthly2023 %>% # arrange according to the day of the week
  mutate(start_day = factor(weekdays(start_date), levels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')))

## creating visualisations ##---
with_outlier_users <- data.frame(
  user_type = c("casual", "member"),
  count = c(1531646, 2799608)  # Replace with your actual counts
)

ggplot(data = with_outlier_users, aes(x = user_type, y = count)) +
  geom_bar(stat = "identity", fill = "blue", alpha = 0.5) + # ensures that count is used as bar height
  labs(title = "Number of casual & member users (including outliers)") +
  geom_text(aes(label= count), position=position_dodge(width=0.9), vjust = -0.6, size = 4) +
  theme_minimal()

#####################################

without_outlier_users <- data.frame(
  user_type1 = c("casual", "member"),
  count1 = c(1304410, 2698544)  # Replace with your actual counts
)

ggplot(data = without_outlier_users, aes(x = user_type1, y = count1)) +
  geom_bar(stat = "identity", fill = "pink", alpha = 0.7) + # ensures that count is used as bar height
  labs(title = "Number of casual & member users (excluding outliers)") +
  geom_text(aes(label= count1), position=position_dodge(width=0.9), vjust = -0.6, size = 4) +
  theme_minimal()

#####################################

mean_user_duration_byday <- monthly2023 %>%
  group_by(user_type, start_day) %>%
  summarise(mean_trip_duration = mean(trip_duration, na.rm = TRUE))

ggplot(data = mean_user_duration_byday, aes(x = start_day, y = mean_trip_duration, fill = user_type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "mean ride duration per day (by user type)", x = "Day of week", y = "mean trip duration (minutes)", fill = "user_type") +
  theme_minimal()




