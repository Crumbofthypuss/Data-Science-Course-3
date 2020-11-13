# Peer-graded Assignment: Getting and Cleaning Data Course Project

The purpose of this activity is to create a tidy dataset using the skills we have learned in the 3rd course of the Data Science Specialization. The contents of the submission are:
1. A readme.md file describing the process of the code
2. The code for the making the tidy data called run_analysis.R
3. A code book describing the list of variables present in the code
4. The tidy dataset itself in both csv and txt format

For the details of the assignment, here is a copy-paste from the assignment page itself:

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

---
# Process of creating the tidy data set through the R script
### Accessing the files
1. Declare needed library packages
2. Download the zipped file and unzip it 
3. Read the test and train data and assign to variables (check CodeBook.md for details)


### Merging the test and train datasets
1. Assign the names for each column using the features.txt file
2. Add a subject column corresponding to the subject who did the experiment using the subject_test/train.txt
3. Add an ID column defining the activity done using y_test/train.txt
4. Merging the test data with corresponding subject and ID columns. Same is done for the train data.
5. Merge the test and train data

### Selecting the mean and standard deviation columns
1. Use conditional formatting to get all the columns containing the strings "ID","subject","datatype","mean()" and "std()". Use grepl and paste to do properly

### Changing the activity ID with activity name
1. Create a dataframe of the activity with corresponding activity labels in activity_labels.txt. Name the columns "ID" and "activity".
2. Merge the dataframe with the dataset in previous process with the same ID. Drop the ID column.

### Making the column names more descriptive
1. Rename the column names using gsub based on this pattern: t=time, f=frequency,Acc=accelerometer, gyro=gyroscope, mag=magnitude, Bodybody=Body

### Creating a new tidy datset with means of each variable
1. Group rows by the subject and activity
2, Get the mean of each column using the summarize function
3. Save the dataset as txt or csv file
