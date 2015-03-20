##Getting and Cleaning Data Course Project Script
##T.Cecere Mar.19.15 v1

## Overview:  un-lableled data sets, one for training and one for test,
## are downloaded into a directory in separate subdirectories. After loading appropriate
## libraries, we'll want to
##1. set up directory names (Windows 7, 64 bit)
##2. read files
##3. merge activity files
##4. add column of subjects, then add coded activities. 
##5. finally, do join to label activities and add column labels from activity file.

## Analysis consists of selecting columns that are means or standard deviations, and then 
## manipulating them to arrive at a smaller tidy set as defined in problem description. Finally,
## we write out the table in the main working directory.

require(dplyr)

setwd(paste(getwd(),"/Getting and Cleaning/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset",sep=""))
train_dir<- paste(getwd(),"/train/", sep="")
test_dir<- paste(getwd(),"/test/", sep="")

## read files and create data frames
column_headings<- read.delim("features.txt",header=F,comment.char="",sep="",col.names=c("feat_num", "description"))

raw_train_data<- read.delim(paste(train_dir,"x_train.txt",sep=""),header=F,
          comment.char="",colClasses="numeric",sep="",col.names=column_headings$description)
raw_test_data<- read.delim(paste(test_dir,"x_test.txt",sep=""),header=F,
          comment.char="",colClasses="numeric",sep="",col.names=column_headings$description)
train_subjects<- read.delim(paste(train_dir,"subject_train.txt",sep=""),header=F,
                            comment.char="",colClasses="numeric",sep="",col.names="Subject")
test_subjects<- read.delim(paste(test_dir,"subject_test.txt",sep=""),header=F,
                           comment.char="",colClasses="numeric",sep="", col.names="Subject")
train_activities<- read.delim(paste(train_dir,"y_train.txt",sep=""),header=F,
                            comment.char="",colClasses="numeric",sep="", col.names="Act_ID")
test_activities<- read.delim(paste(test_dir,"y_test.txt",sep=""),header=F,
                           comment.char="",colClasses="numeric",sep="", col.names="Act_ID")
##
activity_labels<- read.delim("activity_labels.txt",header=F,
                            comment.char="",sep="", col.names=c("Act_ID","Activity_Name"))
##
## Do Step 2 of assignment first: select only columns with mean and standard deviations
mean_train<-select(raw_train_data, contains("mean",ignore.case=T))
std_train<-select(raw_train_data, contains("std",ignore.case=T))
selected_train<-cbind(mean_train,std_train)

mean_test<-select(raw_test_data, contains("mean",ignore.case=T))
std_test<-select(raw_test_data, contains("std",ignore.case=T))
selected_test<-cbind(mean_test,std_test)

## Step 3 of assignment: Add column to Activity frames that includes descriptive names
train_activities<-merge(train_activities,activity_labels, sort=FALSE)
test_activities<-merge(test_activities,activity_labels, sort=FALSE)
##
final_train<-cbind(train_subjects,train_activities,selected_train)
final_test<-cbind(test_subjects,test_activities,selected_test)

## Step 1 of assignment:  merge test and training data:
selected_data_set<-rbind(final_train,final_test)

r## Step 4 of assignment:  clean up weird column names, add row info:
selected_data_set <- select(selected_data_set, -Act_ID)
names(selected_data_set)<-gsub("BodyBody","Body",names(selected_data_set))
selected_data_set<-select(selected_data_set, -contains("meanFreq"))  ## It's not the mean of the value, it's a different variable
selected_data_set$Subject<-paste("Subject ", selected_data_set$Subject, sep="")

## Step 5 of assignment:  get means by Subject, Activity. Creates 30 row database.
##selected_data_set_grouped<-group_by(selected_data_set, Subject, Activity_Name)
selected_data_means<-summarise_each(selected_data_set_grouped,funs(mean))
write.table(selected_data_means, "G&C Project Output.txt", row.names=FALSE)






