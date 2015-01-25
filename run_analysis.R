# 1 - Merge the training and test sets into one data set
trainingData<-read.table("./dataset/train/X_train.txt")
str(trainingData) # 7352 rows - 561 cols
trainingLabel<- read.table("./dataset/train/y_train.txt")
trainingSubject<- read.table("./dataset/train/subject_train.txt")

testData<-read.table("./dataset/test/X_test.txt")
dim(testData) # 2947 rows - 561 cols
testLabel<-read.table("./dataset/test/y_test.txt")
testSubject<- read.table("./dataset/test/subject_test.txt")

## row bind all test-training sets 
joinData<-rbind(trainingData,testData)
dim(joinData) # 10299 rows - 561 cols
joinLabel<-rbind(trainingLabel,testLabel)
joinSubject<-rbind(trainingSubject,testSubject)

# 2 - Extracts only the measurements on the mean and standard deviation
# for each measurement. 

## the signal/measurements names are given in the features.txt file and 
## described in the features_info.txt file 

features<-read.table("./dataset/features.txt")
dim(features) # 561 rows - 2 cols
str(features) # first column is an index, second colum contains the names 

## extract only the measurements which contain the strings "mean()" or std()"
meanStdIdx<-grep("mean\\(\\)|std\\(\\)", features[, 2])
joinDataTidy<-joinData[,meanStdIdx]
names(joinDataTidy) <- gsub("\\(\\)", "", features[meanStdIdx, 2]) 
names(joinDataTidy) <- gsub("-", "", names(joinDataTidy)) # remove "-" in column names 
names(joinDataTidy) <- gsub("mean", "Mean", names(joinDataTidy)) # All words begin with upper case
names(joinDataTidy) <- gsub("std", "Std", names(joinDataTidy)) 
head(joinDataTidy,4)

# 3 - Uses descriptive activity names to name the activities in 
# the data set
activity <- read.table("./dataset/activity_labels.txt") # get activity 

activity[, 2] <- tolower(gsub("_", "", activity[, 2])) # lower case, remove "-"
substr(activity[2:3, 2], 8, 8) <- toupper(substr(activity[2:3,2], 8, 8)) # Upper case -> new Word
activityLabel <- activity[joinLabel[, 1], 2] # assign text to class defined by label
joinLabel[, 1] <- activityLabel # replace activity numbers by activity text in the labels 

# 4 - Appropriately labels the data set with descriptive variable names
# using step 3
names(joinLabel) <- "activity"  # name the vector containing the activities
names(joinSubject)<-"subject"   # name the vector containing the subject
tidyData <- cbind(joinSubject, joinLabel, joinDataTidy)
write.table(tidyData, "tidy_data.txt",row.name=FALSE) # write out the tidy data set

# 5 - From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.
subjectNr <- length(table(joinSubject))
activityNr <- dim(activity)[1]
nrows <- subjectNr*activityNr # resulting nr of obs
ncols <- dim(tidyData)[2]
tidyDataMeans<-as.data.frame(matrix(NA,nrow=nrows,ncol=ncols))
names(tidyDataMeans)<-names(tidyData)

#tidyDataSorted <-tidyData[order(tidyData$subject,tidyData$activity),] # not needed
subjects  <-sort(unique(joinSubject)[,1])
activities<-sort(unique(joinLabel)[,1])
row<-1
for (i in 1:length(subjects)) {
  for  (j in 1:length(activities)) {
    tidySubset<-subset(tidyData,subject==subjects[i]& activity==activities[j])
    tidyDataMeans[row,1]=subjects[i]
    tidyDataMeans[row,2]=activities[j]
    tidyDataMeans[row,3:ncols]<-colMeans(tidySubset[,3:ncols])
    row<-row+1
  }
}
head(tidyDataMeans)
write.table(tidyDataMeans, "tidy_data_means.txt",row.name=FALSE) # write tidy means data set
