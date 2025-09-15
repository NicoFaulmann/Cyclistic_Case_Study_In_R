# Cyclistic Bike Share Case Study In R

## Introduction 📃
This case study is a capstone project for the **Google Data Analytics Professional Certificate**. In this project I will use the data analysis process outlined by Google in this course: **ask, prepare, process, analyse, share and act** along with **R** to analyse the data.

### Scenario 🎬
You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

### Characters 👥

* **Cyclistic:** A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike.
* **Lily Moreno:** The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.
* **Cyclistic marketing analytics team:** A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
* **Cyclistic executive team:** The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.

## Approach ⚙️
### 1. Ask
Morena (manager) has assigned you to analyse:
How do annual members and casual riders use Cyclistic bikes differently?
Then produce a report with the following deliverables:

* A clear statement of the business task
* A description of all data sources used
* Documentation of any cleaning or manipulation of data
* A summary of your analysis
* Supporting visualizations and key findings
* Your top three recommendations based on your analysis

### 2. Prepare 🗃
For this task I will be using Cyclistic's trip data between January 2024 and December 2024 to understand the trends and use cases of the two different rider types that use Cyclistic's services.

(Note: Cyclistic is a fictional company. For this case study, I will use public datasets provided by Motivate International Inc. under this [<ins>license</ins>](https://www.divvybikes.com/data-license-agreement).)

Approach:
1. Download and import data January_2024 - December_2024
2. Combine into one database for 2024

Find the script below:
[Data Preparation](https://github.com/NicoFaulmann/Cyclistic_Case_Study_In_R/blob/main/01_Prepare.r)

### 3. Process 📲
Now we can manipulate the data for our analysis. We will do two things with the now combined dataset:

Clean the dataset of null values and inconsistencies.
Create new values based on available data for insightful analysis.

Find the script below:
[Data Process](https://github.com/NicoFaulmann/Cyclistic_Case_Study_In_R/blob/main/02_Process.r)

### 4. Analyse 🔍
The dataset is now ready for analysing how annual members and casual riders use Cyclistic bikes differently, but to draw insightful conclusions we can plan what to do with this data.

* Create a universal theme for visualisations so that when we present our findings it is neat and consistent.
* Calculate what percentage of users are annual members and what percentage are casual riders.
* Chart how popular each bike type is amongst our two kinds of users.
* Caculate the amount of users per day of the week.
* Analyse what are the most popular stations where users start and end their trips.
* Determine how long and how far each user type rides their bike for.
* Analyse the bike usage trends of users over the course of a year.
* Calculate peak times of bike usage over 24h.

Find the script below:
[Data Analysis](https://github.com/NicoFaulmann/Cyclistic_Case_Study_In_R/blob/main/03_Analyse.r)

### 5. Share
We've completed our analysis and we are now ready to share our findings.

#We can export our csv file for later use with the following:
write.csv(bikedata_2024_clean, 'Bikedata_2024_Clean.csv')

We can use the csv file to create a dashboard in tableau to show our findings to the stakeholders; however, we used R not only to manipulate this large dataset but to also create visualisations for presentation purposes. Having our visualisations neatly labeled with a consistent theme, we can easily compile and present this as a powerpoint.

Our intial task was to analyse: How do annual members and casual riders use Cyclistic bikes differently?

During our analysis, we've made a couple observations:

1. Annual members make up two-thirds of Cyclistic customer base.


