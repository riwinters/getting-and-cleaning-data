library(dplyr)
#download the dataset
if(!file.exists("dataset.zip")){
     download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","dataset.zip")
}
path="UCI HAR Dataset"
#unzipping dataset
if(!file.exists(path)){
    unzip("dataset.zip")
}
# 1 Merging the training dataset and the test dataset

# 1.1 Reading files

# 1.1.1 Reading training tables:

training_subject = read.table(file.path(path, "train", "subject_train.txt"))
training_value= read.table(file.path(path, "train", "X_train.txt"))
training_activity=read.table(file.path(path, "train", "y_train.txt"))

# 1.1.2 Reading testing tables:

test_subject=read.table(file.path(path, "test", "subject_test.txt"))
test_value=read.table(file.path(path, "test", "X_test.txt"))
test_activity= read.table(file.path(path, "test", "y_test.txt"))

# 1.1.3 Reading feature vector:

feature=read.table(file.path(path, "features.txt"),as.is=TRUE)

# 1.1.4 Reading activity labels:

activity=read.table(file.path(path,"activity_labels.txt"))
colnames(activity)=c("activityId", "activityLabel")

# 1.2 Merging training and test dataset

human_activity=rbind(
        +     cbind(training_subject,training_value,training_activity),
        +     cbind(test_subject,test_value,test_activity)
        + )

# 1.3 removing individual data tables to save memory

rm(training_subject,training_value,training_activity, 
   test_subject,test_value,test_activity)

# 1.4 assigning column names

colnames(human_activity)=c("subject",feature[,2],"activity")

# 2.1 determining columns of data set, to keep based on the column name

columns_to_keep =grepl("subject|activity|mean|std",colnames(human_activity))

# 2.2 and keeping the data in these columns only

human_activity=human_activity[, columns_to_keep]

# 3 replacing activity values with named factor levels

human_activity$activity =factor(human_activity$activity, 
                                 levels = activity[,1], labels=activity[,2])

# 4.1 getting column names

human_activity_col= colnames(human_activity)

# 4.2 removing special characters

human_activity_col=gsub("[\\(\\)-]","",human_activity_col)

# 4.3 expanding abbreviations and cleaning up names

human_activity_col=gsub("^f", "frequencyDomain", human_activity_col)
human_activity_col=gsub("^t", "timeDomain", human_activity_col)
human_activity_col=gsub("Acc", "Accelerometer", human_activity_col)
human_activity_col=gsub("Gyro", "Gyroscope", human_activity_col)
human_activity_col=gsub("Mag", "Magnitude", human_activity_col)
human_activity_col=gsub("Freq", "Frequency", human_activity_col)
human_activity_col=gsub("mean", "Mean", human_activity_col)
human_activity_col=gsub("std", "StandardDeviation", human_activity_col)

# 4.4 correcting typo

human_activity_col=gsub("BodyBody", "Body", human_activity_col)

# 4.5 using new labels as column names

colnames(human_activity)=human_activity_col

# Creating a second, independent tidy set with the average of each variable for each activity and each subject

# 5 grouping by subject and activity and summarising using mean

human_activity_mean =human_activity %>% group_by(subject,activity) %>%summarise_each(funs(mean))

# 6 putting the output in the file "tidy_data.txt"

write.table(human_activity_mean,"tidy_data.txt",row.names =FALSE,quote=FALSE)
