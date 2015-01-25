Getting and Cleaning Data - Course Project Codebook
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  
* The site from which the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The dataset used in the course project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to obtained the tidy data sets:   
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "./dataset/train" folder and store them in the workspace variables *trainingData*, *trainingLabel* and *trainingSubject*.       
 2. Read the files X_test.txt, y_test.txt and subject_test.txt from the "./dataset/test" folder and store them in the workspace variables *testData*, *testLabel* and *testsubject*.
 3. Join the *testData* and *trainingData* data frames to generate the data frame merging the training and test features *joinData* (10299x561); join *testLabel* and *trainingLabel* to generate the data frame *joinLabel* (10299x1) and finally join *testSubject* and *trainingSubject* to create the data frame *joinSubject* (10299x1).  
 4. Read the features.txt file from the "./dataset" folder and store the data in a variable called *features*, extracting only the values containing the mean or std values. This results into a reduced list of 66 elements. We get a subset of *joinData* with the 66 corresponding columns.  
 5. Clean the column names of the subset removing the "(), -" symbols and a capital letter for each new word.   
 6. Read the activity_labels.txt file from the "./dataset"" folder and store the data in a variable called *activity*.  
 7. Clean the activity names in the second column of *activity*. The underscores are removed and all characters are transformed into lower-case. For activity names containing multiple words, every new word starts with an upper-case character.  
 8. Transform the values of *joinLabel* according to the *activity* data frame.  
 9. Bind the *joinSubject*, *joinLabel* and *joinData* by column to get a new tidy 10299x68 data frame, *tidyData*. Name the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 different activity names; the resting 66 columns contain the measurements containing values between -1 and 1. Output the  *tidyData* variable to a file names "tidy_data.txt" to the current directory.  
 10. Finally, generate a second tidy data set with the average of each measurement for each activity and each subject. With 30 different subjects and 6 different activities this results into a data set of 180 (30*6) observations. For each possible activity-subject combination, the mean over all the features (columns) is obtained. This is accomplished by obtaining the subsets for each activity-subject combination looping over the 30 different subjects and the 6 different activities.
 11. Output the data frame *tidyDataMeans* as a text file "tidy_data_means.txt" into the working directory. 
 