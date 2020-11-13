# Peer-graded Assignment: Getting and Cleaning Data Course Project
In this CodeBook, the datasets used for each process are described.

## Datasets used from the unzipped file
1. X_test.txt and X_train.txt as values for the for the activities done
2. subject_test.txt and subject_train.txt to denote which subject for each row
3. y_test.txt and y_train.txt to show what activity is done for each row
4. features.txt to label each column head for the values
5. activity_labels.txt to correspond activity number with descriptive names

---
## Datasets present in each part of the code
### Combining the test and train datasets
1, train= data acquired from X_train.txt which serves as train row values
2. test= data acquired from X_test.txt which serves as test row values
3. testpeople= dataframe containing subjects for the test dataset
4. trainpeople= dataframe containing subjects for the train dataset
5. testActivity= dataframe containing activity ID for the test dataset
6. trainActivity= dataframe containing activity ID for the train dataset
7. newtest= combined datasets of test,testpeople, and testActivity
8. newtrain= combined datasets of train, trainpeople, and trainActivity
9. mergedData= merged datasets of newtest and newtrain

### Selecting mean and std columns
1. diminishedData = subset of mergedData containing mean and standard deviation columns

### Changing activity ID with descriptive names
1. activityData = dataset containing the corresponding activity with ID
2. arrangedData = diminishedData with the ID column replaced with activity names

### Changing column names with more descriptive names
1. arrangedData = arrangedData from previous process but more descriptive columns

### Creating another tidy dataset for the mean of each variable
1. tidyDataset = dataset containing the means of variables of arrangedData grouped by subjects and activity
2. tidyDataset.txt/.csv = txt or csv file containing tidyDataset
