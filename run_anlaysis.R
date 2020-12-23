# "Week 4 Peer-graded Assignment: Getting and Cleaning Data Course Project

getwd()

library(dplyr)
library(data.table)

# download zip file

if(!file.exists("./wk4project")){
    dir.create("./wk4project")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile = "./wk4project/finalproject.zip")

unzip(zipfile = "./wk4project/finalproject.zip", exdir = "./wk4project")

list.files("./wk4project")

setwd("~/wk4project/UCI HAR Dataset")

list.files()

# read data

features <- read.table("features.txt", col.names = c("n", "feature"))
activitylabels <- read.table("activity_labels.txt", col.names = c("code", "activity"))

subjecttrain <- read.table("./train/subject_train.txt", col.names = "subject")
ytrain <- read.table("./train/y_train.txt", col.names = "code") 
xtrain <- read.table("./train/X_train.txt", col.names = features$feature) 

subjecttest <- read.table("./test/subject_test.txt", col.names = "subject")
ytest <- read.table("./test/y_test.txt", col.names = "code")
xtest <- read.table("./test/X_test.txt", col.names = features$feature)

# task 1. Merges the training and the test sets to create one data set.

xmerged <- rbind(xtrain, xtest)
ymerged <- rbind(ytrain, ytest)
subjectmerged <- rbind(subjecttrain, subjecttest)
mergeddata <- cbind(subjectmerged, ymerged, xmerged)


# task 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

dataset <- mergeddata %>%
    select(subject, code, contains("mean"), contains("std"))

# task 3. Uses descriptive activity names to name the activities in the data set

dataset$code <- activitylabels[dataset$code, 2]

# task 4. Appropriately labels the data set with descriptive variable names. 

names(dataset)[2] = "activity"
names(dataset) <- gsub("Acc", "Accelerometer", names(dataset))
names(dataset) <- gsub("Gyro", "Gyroscope", names(dataset))
names(dataset) <- gsub("BodyBody", "Body", names(dataset))
names(dataset) <- gsub("Mag", "Magnitude", names(dataset))
names(dataset) <- gsub("^t", "Time", names(dataset))
names(dataset) <- gsub("^f", "Frequency", names(dataset))
names(dataset) <- gsub("tBody", "TimeBody", names(dataset))
names(dataset) <- gsub("-mean()", "Mean", names(dataset), ignore.case = TRUE)
names(dataset) <- gsub("-std()", "STD", names(dataset), ignore.case = TRUE)
names(dataset) <- gsub("-freq()", "Frequency", names(dataset), ignore.case = TRUE)
names(dataset) <- gsub("angle", "Angle", names(dataset))
names(dataset) <- gsub("gravity", "Gravity", names(dataset))

# task 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata <- dataset %>%
    group_by(subject, activity) %>%
    summarize_all(funs(mean))

write.table(tidydata, "tidydata.txt", row.name = FALSE)


