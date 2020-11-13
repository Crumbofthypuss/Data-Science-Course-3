library(dplyr);library(data.table);library(tidyr)

#Downloading the file and unzipping
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Dataset.zip")
unzip("Dataset.zip")

#1,COMBINE THE TEST AND TRAIN DATASETS

#reading each file for merging 
train<- read.table("./UCI HAR DATASET/train/X_train.txt")
test<- read.table("./UCI HAR DATASET/test/X_test.txt")
testpeople<- read.table("./UCI HAR DATASET/test/subject_test.txt")
trainpeople<- read.table("./UCI HAR DATASET/train/subject_train.txt")
testActivity<- read.table("./UCI HAR DATASET/test/y_test.txt")
trainActivity<- read.table("./UCI HAR DATASET/train/y_train.txt")

#to create the column names for the data set using features.txt
columnnames <- read.delim("./UCI HAR DATASET/features.txt", fill=TRUE, stringsAsFactors=FALSE)
sepcolumnnames <- as.list(strsplit(columnnames[[1]],"\\s+"))
sepcolumnnames<- sapply(sepcolumnnames,"[[", 2)
sepcolumnnames<- c('tBodyAcc-mean()-X', sepcolumnnames)# read.delim removes first row value so this part puts it back
names(test) = sepcolumnnames #assign the column names to the data set 
names(train)= sepcolumnnames
names(testpeople) = "subject"
names(trainpeople) = "subject"
names(testActivity) = "ID"
names(trainActivity) = "ID"

#adding the columns for the subject number and type(whether testing data or training data)
newtest<- cbind(testActivity,testpeople,"datatype"=0,test)
newtrain<- cbind(trainActivity,trainpeople,"datatype"=1,train)

#Merging the data
mergedData<- rbind(newtest,newtrain)
#head(mergedData)

#--------------------------------------------------------------

#2,SELECTING THE COLUMNS FOR THE MEAN AND STANDARD DEVIATION
diminishedData<- mergedData[,grepl(paste(c("ID","subject","datatype","[Mm]ean\\(\\)","std\\(\\)"),collapse="|"),names(mergedData))]
#code above gets only the columns containing the strings ID, subject,type, mean()/Mean(), and std()
#head(diminishedData)

#--------------------------------------------------------------
#3, CHANGING ACTIVITY ID WITH VARIABLE NAME
#reading the data and applying header names
activityData<- read.table("./UCI HAR DATASET/activity_labels.txt")
names(activityData)<- c("ID","activity") 

#merging it with the dataset and removing ID so that only activity column remains
arrangedData<- merge(activityData, diminishedData,by.x="ID",by.y="ID")
arrangedData<- select(arrangedData,-(ID))
#head(arrangedData)

#--------------------------------------------------------------
#4,MAKE DATASET LABELS MORE DESCRIPTIVE
#t=time, f=frequency,Acc=accelerometer, gyro=gyroscope, mag=magnitude, Bodybody=Body
names(arrangedData)<- gsub("^t","time",names(arrangedData))
names(arrangedData)<- gsub("^f","frequency",names(arrangedData))
names(arrangedData)<- gsub("Acc","Accelerometer",names(arrangedData))
names(arrangedData)<- gsub("Gyro","Gyroscope",names(arrangedData))
names(arrangedData)<- gsub("Mag","Magnitude",names(arrangedData))
names(arrangedData)<- gsub("BodyBody","Body",names(arrangedData))
#names(arrangedData)

#-----------------------------------------------------------
#5,CREATE ANOTHER TIDY DATASET FOR THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND SUBJECT
#group the arrangedData by activity and subject
tidyDataset<-arrangedData %>%
    group_by(subject,activity) %>%
    summarize(across(everything(),mean))
#tidyDataset

#Saving the file to tidyDatset.csv or tidyDataset.txt
write.csv(tidyDataset,file="tidyDataset.csv")
write.table(tidyDataset,file="tidyDataset.txt")