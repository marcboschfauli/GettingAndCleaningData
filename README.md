Getting and Cleaning Data - Course Project
========================================
This README file describes how the use the run_analysis.R script.
* First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into the same directory as "run_analysis.R" and rename the folder to "dataset".
* Second, source("run_analysis.R") to run the script and get the variables into your workspace. 
* Additionally to the workspace variables, the script outputs two text files:
  - tidy_data.txt: contains the data frame "tidyData" with 10299 rows and 68 columns.
  - tidy_data_means.txt (220 Kb): it contains the data frame  "tidyDataMeans" which contains the means for each subject and each activity, resulting into a data set with 180 observations (30 subjects * 6 activities) for each of the 66 features.
* Finally, read the means of the tidy data into a variable using  tidyDataMeans<- read.table("tidy_data_means.txt",header=TRUE) in RStudio.
