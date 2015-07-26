############################################################################
# Step 0)
# Clear history, set work directory, create data folder if not exist
############################################################################

rm(list = ls())

# Set the work directory
setwd("C:/Users/Rod/Documents/coursera/data-science/03_gettingAndCleaningData/05/project/UCI HAR Dataset/")

# Checking and creating directory
if (!file.exists("data")) {
  dir.create("data")
}


############################################################################
# Step 1)
# Merges the training and the test sets to create one data set.
############################################################################

# file names from test folder
file_subject_test = "./test/subject_test.txt"
file_x_test = "./test/X_test.txt"
file_y_test = "./test/y_test.txt"

# file names from train folder
file_subject_train = "./train/subject_train.txt"
file_x_train = "./train/X_train.txt"
file_y_train = "./train/y_train.txt"

# Load and merge the subject files:
subject_test  <- read.csv(file_subject_test, head=FALSE)
subject_train <- read.csv(file_subject_train, head=FALSE)
subject_data  <- rbind(subject_test, subject_train)

# Load and merge the y files:
y_test <- read.csv(file_y_test, head=FALSE)
y_train <- read.csv(file_y_train, head=FALSE)
y_data  <- rbind(y_test, y_train)

# Load and merge the x files:
x_test <- read.csv(file_x_test, head=FALSE, sep="")
x_train <- read.csv(file_x_train, head=FALSE, sep="")
x_data  <- rbind(x_test, x_train)

############################################################################
# Step 2)
# Extracts only the measurements on the mean and standard deviation for each
# measurement.
############################################################################

file_features = "./features.txt"
features <- read.csv(file_features, head=FALSE, sep="")
head(features,5)
source("functions.R")
features_mean_and_std <- extract_mean_and_std(features)
head(features_mean_and_std, 15)
columns_with_mean_and_sts <- features_mean_and_std[[1]]
head(columns_with_mean_and_sts, 15)
x_data_mean_and_std <- x_data[, columns_with_mean_and_sts]
head(x_data_mean_and_std, 15)


############################################################################
# Step 3)
# Uses descriptive activity names to name the activities in the data set.
############################################################################

# Load activities labels
file_activity_labels = "./activity_labels.txt"
activity_labels <- read.csv(file_activity_labels, head=FALSE, sep="")
head(activity_labels)

# activities labels: rename the colunm-name from "V2" to "activity_name"
col_heading_activity <- c('activity_code', 'activity_name')
names(activity_labels) <- col_heading_activity
head(activity_labels, 1)

# Subject data: rename the colunm-name from "V1" to "subject"
col_heading_subject <- c('subject')
names(subject_data) <- col_heading_subject
head(subject_data, 1)

# Activity data: rename the colunm-name from "V1" to "activity"
col_heading_activity <- c('activity')
names(y_data) <- col_heading_activity
head(y_data, 1)

# Merge subject_data, y_data, and x_data
data <- cbind(subject_data, y_data, x_data_mean_and_std)
head(data, 1)

# Replace the content of colunm activity with values from activity_labels$activity_name
data$activity <- activity_labels$activity_name[match(data$activity, activity_labels$activity_code)]
head(data, 1)



############################################################################
# Step 4)
# Appropriately labels the data set with descriptive variable names.
############################################################################


col_headings <- c("subject", "activity", as.vector(features_mean_and_std$V2[]))
names(data) <- col_headings
head(data, 1)

############################################################################
# Step 5)
# From the data set in Step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
############################################################################
head(data, 1)

install.packages("reshape")
library(reshape)
library(reshape2)
# organize the data in a way that we have in each line only four values: subject, activity, variable and value:
dataMelt <- melt(data, id=c("subject", "activity"))
head(dataMelt, 200)

# Combine variables: create a third variable that is a composition of subject, activity, and variable:
dataMelt$subject_activity_variable <- paste0(dataMelt$subject, "|", dataMelt$activity, "|", dataMelt$variable)
head(dataMelt, 200)

library(dplyr)
# we are only interested in the value for each (subject, activity, variable), so we select them:
dataSubjectActivityVariable <- select(dataMelt, subject_activity_variable, value)
# we sort by subject_activity_variable
dataSubjectActivityVariable < arrange(dataSubjectActivityVariable, subject_activity_variable)
# sav (Subject, Activity, and Variable) will have the values grouped by subject, activity, and variable
sav <- group_by(dataSubjectActivityVariable, subject_activity_variable)
# summary will have the average of values for each (subject, activity, variable)
summary <- summarize(sav, average = mean(value))
summary


############################################################################
# Step 6)
# Upload the tidy data set created in step 5 of the instructions.
# Please upload your data set as a txt file created with write.table()
# using row.name=FALSE (do not cut and paste a dataset directly
# into the text box, as this may cause errors saving your submission).
############################################################################

write.table(summary, file = "tidy-data-set-created-in-step-5.txt", append = FALSE, quote = FALSE, sep = "|", row.names = FALSE)

############################################################################
# Step 7)
# Submit a link to a Github repo with the code for performing your analysis.
# The code should have a file run_analysis.R in the main directory that can
# be run as long as the Samsung data is in your working directory. The output
# should be the tidy data set you submitted for part 1. You should include
# a README.md in the repo describing how the script works and the code book
# describing the variables.
############################################################################

