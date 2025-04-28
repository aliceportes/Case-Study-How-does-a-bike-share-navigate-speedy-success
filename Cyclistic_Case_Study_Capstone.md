# Cyclistic Case Study Capstone
---

# Google Data Analytics - Case Study: How does a Bike-Share Navigate Speedy Success?

---

## 1. Introduction

Cyclistic is a bike-sharing company based in Chicago, offering flexible bike rental options through a vast network of docking stations. Riders can choose between casual pay-as-you-go plans and annual memberships.

As the company continues to grow, Cyclistic is exploring new strategies to increase customer retention and boost long-term revenue. One key area of interest is understanding how to encourage more casual riders to convert into annual members.

---

## 2. Scenario

The Cyclistic marketing team is conducting a detailed analysis of rider behavior. The goal is to uncover patterns and insights that can guide targeted marketing campaigns and inform business decisions aimed at expanding the member base.

By gaining insights from the data, this analysis aims to provide actionable recommendations to help convert more casual riders into loyal annual members.

---

## 3. Ask Phase

The business task:  
The Cyclistic marketing team wants to design strategies that encourage casual riders to become annual members.

To support this goal, the data analysis team has been asked to analyze historical bike trip data to identify key differences in usage patterns between casual riders and annual members. These insights will help inform marketing recommendations that are data-driven and tailored to user behavior.

---

## 4. Prepare Phase

**Where is the data located?**  
The data used in this analysis is publicly available and was downloaded from [Data Source](https://divvy-tripdata.s3.amazonaws.com/index.html).

**How is the data organized?**  
The data is organized into monthly CSV files.

**How are you addressing licensing?**  
The data license can be found on [License Information](https://www.divvybikes.com/data-license-agreement).

---

## 5. Process Phase

**Tools chosen and why:**  
I chose **R** for data cleaning and transformation due to the dataset's large size, which would have been challenging to handle in Excel. For data visualization, I used **Tableau**, a tool I recently started learning and enjoyed working with during this project.

**Loading and setting up the environment:**

```r
# Installing packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("lubridate")

# Loading packages
library(tidyverse)
library(dplyr)
library(lubridate)

# Setting working directory
setwd("C:/Users/alice/OneDrive/Documentos/Analise de dados Coursera + Google/MODULE 8/Case study 1/202404202503_Cyclistic")

# Aggregating data
aggregate_files <- list.files(pattern = "*.csv")
aggregate_data <- map_df(aggregate_files, read_csv())
