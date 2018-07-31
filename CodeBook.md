Code Book

This code book summarizes the resulting data fields in tidy_data.txt.

About R script


File with R code "run_analysis.R" perform following six steps :

Merging the training and the test sets to create one data set.

1.1 Reading files
1.1.1 Reading trainings tables
1.1.2 Reading testing tables
1.1.3 Reading feature vector
1.1.4 Reading activity labels
1.2 Merging training and test dataset
1.3 removing individual data tables to save memory
1.4 assigning column names
2.1 determining columns of data set, to keep based on the column name
2.2 and keeping the data in these columns only
3 replacing activity values with named factor levels
4.1 getting column names
4.2 removing special characters
4.3 expanding abbreviations and cleaning up names
4.4 correcting typo
4.5 using new labels as column names
Creating a second, independent tidy set with the average of each variable for each activity and each subject
5 grouping by subject and activity and summarising using mean
6 putting the output in the file "tidy_data.txt"

Variables

Each row contains, for a given subject and activity, 79 averaged signal measurements.


Identifiers

subject
Subject identifier, integer, ranges from 1 to 30.

activity
Activity identifier, string with 6 possible values:

WALKING: subject was walking
WALKING_UPSTAIRS: subject was walking upstairs
WALKING_DOWNSTAIRS: subject was walking downstairs
SITTING: subject was sitting
STANDING: subject was standing
LAYING: subject was laying


Transformations


The zip file containing the source data is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The following transformations were applied to the source data:

The training and test sets were merged to create one data set.
The measurements on the mean and standard deviation (i.e. signals containing the strings mean and std) were extracted for each measurement, and the others were discarded.
The activity identifiers (originally coded as integers between 1 and 6) were replaced with descriptive activity names (see Identifiers section).
The variable names were replaced with descriptive variable names (e.g. tBodyAcc-mean()-X was expanded to timeDomainBodyAccelerometerMeanX), using the following set of rules:
Special characters (i.e. (, ), and -) were removed
The initial f and t were expanded to frequencyDomain and timeDomain respectively.
Acc, Gyro, Mag, Freq, mean, and std were replaced with Accelerometer, Gyroscope, Magnitude, Frequency, Mean, and StandardDeviation respectively.
Replaced (supposedly incorrect as per source's features_info.txt file) BodyBody with Body.
From the data set in step 4, the final data set was created with the average of each variable for each activity and each subject.
The collection of the source data and the transformations listed above were implemented by the run_analysis.R R script 
