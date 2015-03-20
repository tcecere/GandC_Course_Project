##Getting and Cleaning Data Course Project Script
##T.Cecere Mar.19.15 v1

## Overview:  un-lableled data sets, one for training and one for test,
## are downloaded into a directory in separate subdirectories. After 
loading appropriate
## libraries, we'll want to
##1. set up directory names (Windows 7, 64 bit)
##2. read files
##3. merge activity files
##4. add column of subjects, then add coded activities. 
##5. finally, do join to label activities and add column labels from 
activity file.

## Analysis consists of selecting columns that are means or standard 
deviations, and then 
## manipulating them to arrive at a smaller tidy set as defined in problem 
description. Finally,
## we write out the table in the main working directory.

## Assumes that main working directory is 
##C:\Users\USENAME\Documents\Getting and 
##Cleaning\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset

##Requires the "dplyr" library to do selects, merges and summarize_each 
##functions.
