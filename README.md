Assumptions

plyr package already installed; only needs to be loaded
Assume working in the UCI HAR Dataset directory and the 6 required files are in working directory, i.e. have been copied from test & train sub-directories to working directory

Procedure

1) Read features.txt into a data table features
2) Read the activities from activity_labels.txt & give them meaningful column names – Activity.label and Activity.name
3) Read all 6 files into respective data frames using read.table
a. subject_train.txt
b. subject_test.txt
c. y_train.txt
d. y_test.txt
e. X_train.txt – set colClasses to “numeric” for faster reading
f. X_test.txt – set colClasses to “numeric” for faster reading
4) Assign column names for the X Training & Test data frames from features
5) Extract from X training & test data frames only those column features that have "mean" or "std" in labels & subset (used the grepl function) – this results in 79 columns instead of 561 in the X data frames
6) Also add a SNo to the X data frames to preserve row numbers for future merge
7) First combine the (subject_train and y_train), and (subject_test and y_test) data frames respectively into data frames called subject_y_train and subject_y_test
8) Add SNo columns to these two combined data frames to be able to use for merging with training/test data later
9) And provide meaningful column names – "SNo", "Subject", "Subject.type", "Activity.label"
10) Merge (I used join that preserves row orders) subject_y test and train data frames with activity_labels :- Activity.label will associate the activity labels with the activity name
11) Then join the subject_train_y_activity and X_train, and the subject_test_y_activity and X_test respectively. 
12) Concatenate the combined data set using rbind, but first remove the SNo columns as they are no longer needed
13) Aggregate over Subject (30) and Activity (6)to get the mean for each of the 79 features. This results in a data frame with 180 rows and 79 column features (+ 4 columns for Subject, Subject type, Activity and Activity label
14) I had some warnings with aggregate, and some additional Group.x columns (x from 1 to 4). I had to reassign Group.2 to Subject.type and Group.4 to Activity.label and then remove the Group.x columns
15) Last step was to write.table

       

