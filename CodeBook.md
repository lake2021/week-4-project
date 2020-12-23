Code book

1. Source data
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

2. R script - "run_analysis.R "

(1) Download and unzip
The data for the project is from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

(2) Read data and assign variable names
- Read features
- Read activity labels
- Read training tables
- Read test tables

(3) Merges the training and the test sets to create one data set called "mergedata"

(4) Extracts only the measurements on the mean and standard deviation for each measurement using "select" function.

(5) Uses descriptive activity names to name the activities in the data set.

(6) Appropriately labels the data set with descriptive variable names. 

(7) Ceates a second, independent tidy data set with the average of each variable for each activity and each subject.

3. Variables
- From the zipfile: features, activitylabels, sujecttrain, ytrain, xtrain, subjecttest, ytest, and xtest
- Merged: xmerged, ymerged, subjectmerged, and mergeddata
- Extracted: dataset
- Independent data set: tidydata (180 rows and 88 columns)

4. Final data is saved in "tidydata.txt".
