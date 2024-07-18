# Google-Data-Analytics-professional-certificate
This repository contains all the Rstudio codes, case study reference materials, data sets, images and presentation. This is a project within the Google Data Analytics specialisation on Coursera. 

## Introduction to the project 
Cyclistic is a fictional bike-share company. Apart from the convenience of having more than 5800 bicycles and 600 docking stations, they also offer flexible pricing options for riders of different needs. Single-ride and full-day passes are considered casual users while annual passes are considered Cyclistic annual members. Inclusivity are also taken into consideration. Cyclistic offers reclining bikes, hand tricycles and cargo bikes altho only 8% of the riders choose this option. 

Currently, most riders ride for leisure and only about 30% of the riders use the bikes to commute to work each day

The director believes the company's future success depends on increasing the number of annual memberships. The marketing strategy should shift from targeting all-new customers to attracting conversions.

To do so, a new marketing strategy is be designed to convert casual riders to annual members. We need to understand how casual riders and annual members differ and have in common, to identify what is stopping casual riders from being an annual member. 

## Business task
### Key Stakeholders 
- Lili Moreno: director of marketing, responsible for the development of campaigns and initiative to promote bike-share program
- cyclistic marketing analytics team: responsible for collecting, analysing and reporting data that helps guide Cyclistic marketing strategy
- Cyclistic executive team: makes the decision on whether to approve the recommended marketing program

### Business question
How do annual members and casual riders use Cyclistic bikes differently?

## Data Sources
All data are provided by Coursera Google Data Analytics professional certificate. 

All data are downloaded from https://divvy-tripdata.s3.amazonaws.com/index.html 
- 2023 monthly data are used (January - December)

Since Cyclistic is a fictional company, for the purpose of this case study, the data sets are provided by Motivate International Inc. under this license:
https://divvybikes.com/data-license-agreement 

## Data Cleaning
1. Remove unwanted columns
  - To keep: ```ride_id```, ```rideable_type```, ```started_at```, ```ended_at```, ```start_station_name```, ```start_station_id```, ```end_station_name```, ```end_station_id```, ```member_casual```
  - To remove: ```start_lat```, ```start_lng```, ```end_lat```, ```end_lng```

2. Renaming columns to ensure clarity
  - change ```member_casual``` -> ```user_type```
  - variables are still *member* and *casual*

3. Combining seperate monthly data into 1 data frame
  - ```monthly2023``` is the combined data frame
  - it contains data from:
    - ```jan2023```
    - ```feb2023```
    - ```mar2023```
    - ```apr2023```
    - ```may2023```
    - ```jun2023```
    - ```jul2023```
    - ```aug2023```
    - ```sep2023```
    - ```oct2023```
    - ```nov2023```
    - ```dec2023```

4. Separating date & time into 2 different columns
  - separate ```started_at``` into ```start_date``` and ```start_time```, in *H : M : S* format
  - separate ```ended_at``` into ```ended_date``` and ```ended_time``` in *H : M : S* format

5. Calculating trip duration
  - take the difference between ```started_at``` and ```ended_at``` using ```difftime()```
  - units: minutes
  - convert data into <numeric>
  

6. Remove NULL values
  - ```drop_na()``` to remove all rows with NULL values

7. Remove duplicate rows
  - ```distinct()``` to remove all duplicate rows

8. Keep only rows with trip duration > 0
  - filter to keep only rows with trip_duration > 0
  - trip duration cannot be 0 or negative

9. Identify outliers
  - using the formula:
      - Q1 - 1.5 * (IQR)
      - Q2 + 1.5 * (IQR)
   
## Visualisation & analysis
### Deciding whether to remove the outliers
- compare number of casual and member users, with and without outliers
<img width="435" alt="Screenshot 2024-07-18 at 12 51 24 PM" src="https://github.com/user-attachments/assets/2d03e3f4-9aaa-4828-9221-8ca00877d90f">

- there are almost 2 times more outliers in the casual column
- since casual users includes riders on single-use and daily passes, the outliers may reflect a trend and it might be a key difference between member and casual users

- here is a visualisation for comparison:
![Rplot](https://github.com/user-attachments/assets/32ab4ca6-19ca-42e8-8e7c-20d4ff449a66)

![Rplot01](https://github.com/user-attachments/assets/917b6c6a-3caa-4ffd-bc62-8c69f1051339)

- so, the conclusion is that the outliers should not be removed

### Visualising mean ride duration per day by user types
![Rplot02](https://github.com/user-attachments/assets/cf5ab434-ea0c-4af3-b47f-ce7e6dae6db0)

- from the visualisation above, we can see that the mean ride duration per day is higher for casual users
- for both casual riders and members mean ride duration is longer during the weekends. However, the difference is more apparent within the casual riders
  - this observation may be due to weekends being a "no-work day" more people are using Cyclistic bikes for leisure purposes
 
## Recommendations
### Recommendation 1: Include more flexible annual pass options
- there could be *weekends only* annual pass that caters to riders that mostly ride for leisure purposes during the weekends
- there could also be *weekdays only* annual pass that caters to riders that use the bikes to commute to work during the weekdays
- such flexibility could attract more conversion to annual members as they are able to find a pass that they could commit to, based on their lifestyles and habits

### Recommendation 2: Increase reminders for conversion to annual passes
- in general, mean trip duration is longer for casual users.
- sometimes, users may just be lazy or they forgot about the option of converting to an annual member
- providing reminders for casual users when they hit a streak of > 15 minutes ride-time for > 3 days 

- other than that, a history tab could be included in the app to allow users to track their ride-time and consider an annual membership after realising that they ride on a regular basis.

### Recommendation 3: Research on the reasons for outliers
- there are 2x more outliers within the casual users as compared to members
- this may indicate a habit within casual users
  - they may have forgot to end their trip
  - they may be using it without returning it
 - this may also be due to administrative error
 - identifying the reason for the outlier might allow the marketing team to come up with corresponding measures, or for the management team to improve their processes in the future
