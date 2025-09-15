#First add libraries
library("tidyverse")
library("ggplot2")
library("lubridate")
library("gridExtra")
library("geosphere")
library("scales")

#Loading csv files. (directory=file directory on computer)
bikedata_2024_01 <- read.csv("directory/202401-divvy-tripdata.csv")
bikedata_2024_02 <- read.csv("directory/202402-divvy-tripdata.csv")
bikedata_2024_03 <- read.csv("directory/202403-divvy-tripdata.csv")
bikedata_2024_04 <- read.csv("directory/202404-divvy-tripdata.csv")
bikedata_2024_05 <- read.csv("directory/202405-divvy-tripdata.csv")
bikedata_2024_06 <- read.csv("directory/202406-divvy-tripdata.csv")
bikedata_2024_07 <- read.csv("directory/202407-divvy-tripdata.csv")
bikedata_2024_08 <- read.csv("directory/202408-divvy-tripdata.csv")
bikedata_2024_09 <- read.csv("directory/202409-divvy-tripdata.csv")
bikedata_2024_10 <- read.csv("directory/202410-divvy-tripdata.csv")
bikedata_2024_11 <- read.csv("directory/202411-divvy-tripdata.csv")
bikedata_2024_12 <- read.csv("directory/202412-divvy-tripdata.csv")

#Inspecting datasets for inconsistancies before merging
glimpse(bikedata_2024_01)
glimpse(bikedata_2024_02)
glimpse(bikedata_2024_03)
glimpse(bikedata_2024_04)
glimpse(bikedata_2024_05)
glimpse(bikedata_2024_06)
glimpse(bikedata_2024_07)
glimpse(bikedata_2024_08)
glimpse(bikedata_2024_09)
glimpse(bikedata_2024_10)
glimpse(bikedata_2024_11)
glimpse(bikedata_2024_12)

#The data shares the same column names and data types and is consistent throughout

#Merge the csv files together and create a dataframe of the year of 2024
bikedata_2024 <- bind_rows(bikedata_2024_01, bikedata_2024_02, bikedata_2024_03, bikedata_2024_04,
                           bikedata_2024_05, bikedata_2024_06, bikedata_2024_07, bikedata_2024_08,
                           bikedata_2024_09, bikedata_2024_10, bikedata_2024_11, bikedata_2024_12)

#Checking the created dataframe
head(bikedata_2024)
summary(bikedata_2024)
