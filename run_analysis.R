## Assume plyr package already installed
library(plyr)
##
## Assume working in the UCI HAR Dataset directory
## and the 8 required files are in working directory
## i.e. have been copied from test & train sub-directories to working directory
##
## read the features into a data table features
features=read.table("features.txt")
##
## read the activities from activity_labels & give them meaningful column names
activity_labels=read.table("activity_labels.txt", sep=" ")
colnames(activity_labels)=c("Activity.label", "Activity.name")
##
## read all 6 files into respective data frames
##
## read the subject numbers from subject_train.txt & subject_test.txt file
subject_train=read.table("subject_train.txt")
subject_test=read.table("subject_test.txt")
##
## now read the activity labels for each row from y_train.txt file
y_train=read.table("y_train.txt")
y_test=read.table("y_test.txt")
##
## now read the training & test files. 
## Since data is numeric, set colClasses="numeric"
##
X_train=read.table("X_train.txt", colClasses="numeric")
X_test=read.table("X_test.txt", colClasses="numeric")
## Assign column labels for the Training & Test data from features
colnames(X_train)=features$V2
colnames(X_test)=features$V2
##
## Now extract only those column features that have "mean" or "std" in labels
extract_features=grepl('-mean()', features$V2) | grepl('-std()', features$V2)
## 
## and subset those columns from X_train and X_test back into these data frames
X_train=X_train[, extract_features]
X_test=X_test[, extract_features]
## add a SNo to these files to preserve row numbers for future merge
X_train$SNo=(1:nrow(X_train))
X_test$SNo=(1:nrow(X_test))
##
##start combining files 
## First combine the subject_train and y_train, and subject_test and y_test
## Combined file called subject_y_train and subject_y_test respectively
## Add SNo column to be able to use for merging with training/test data later
## And provide meaningful column names
subject_y_train=cbind.data.frame(c(1:nrow(subject_train)), subject_train, rep("Train",nrow(subject_train)),y_train)
colnames(subject_y_train)=c("SNo", "Subject", "Subject.type", "Activity.label")
subject_y_test=cbind.data.frame(c(1:nrow(subject_test)), subject_test, rep("Test",nrow(subject_test)), y_test)
colnames(subject_y_test)=c("SNo", "Subject", "Subject.type", "Activity.label")
##
## join (merge) subject_y with activity_labels :- Activity.label will associate the activity labels with the activity name
subject_y_train_activity=join(subject_y_train, activity_labels)
subject_y_test_activity=join(subject_y_test, activity_labels)
##
##
## now join (merge) the subject_train_y_activity and X_train, and the subject_test_y_activity and X_test respectively
joined_training_data=join(subject_y_train_activity, X_train)
joined_test_data=join(subject_y_test_activity, X_test)
##
## now concatenate the combined data set by rbind-ing them
## We first remove the SNo from both joined data sets since we will be concatenating
joined_training_data$SNo=NULL
joined_test_data$SNo=NULL
## and concatenate
combined_data=rbind.data.frame(joined_training_data, joined_test_data)
##
## prepare for aggregation
attach(combined_data)
options(warn=-1)
agg_combined_data=as.data.frame(aggregate(combined_data, by=list(Subject, Subject.type, Activity.label, Activity.name),FUN=mean, na.rm=TRUE))
options(warn=0)
## reinstate the Subject type and the Activity name and delete the Group columns created by append
agg_combined_data$Subject.type=agg_combined_data$Group.2
agg_combined_data$Activity.name=agg_combined_data$Group.4
agg_combined_data$Group.1 <- agg_combined_data$Group.2 <-agg_combined_data$Group.3<-agg_combined_data$Group.4<-NULL
##
## write the aggregated table to tidy_data text file
write.table(agg_combined_data,"tidy_data.txt", row.names=FALSE, quote=FALSE)