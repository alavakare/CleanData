Code Book

8 files read into corresponding data frames
1) features.txt (data frame features): List of all 561 features for which measurements are taken - 561 row features x 2 columns – Sno & Feature)
2) activity_labels.txt (data frame activity_labels): Links the activity class labels (1-6) with their activity name (WALKING,..,LAYING) – 6 rows x 2 columns
3) subject_train.txt (data frame subject_train): Each row identifies the training set subject who performed the activity for each window sample. Its range is from 1 to 30 - 7352 rows with subject no. x 1 column
4) X_train.txt (data frame X_train): Training set readings - 7352 rows (each row corresponding to a set of readings) x 561 column features
5) y_train.txt (data frame y_train): Training activity labels - 7352 rows of activity class labels (each row corresponding to a set of readings) x 1 column
6) subject_test.txt (data frame subject_test): Each row identifies the test set subject who performed the activity for each window sample. Its range is from 1 to 30 - 2947 rows with subject no. x 1 column
7) X_test.txt (data frame X_test): Test set readings - 2947 rows (each row corresponding to a set of readings) x 561 column features
8) y_test.txt (data frame y_test): Test activity labels - 2947 rows of activity class labels (each row corresponding to a set of readings) x 1 column

Other data frames created

1) Extract_features – logical vector of those features that have “mean” or “std” in them – 79 TRUE, 482 FALSE. Used to subset X_train and X_test data frames

2) X_train – 7352 rows x 80 columns (79 extracted features + SNo)
3) X_test – 2947 rows x 80 columns

4) joined_training_data – 7352 rows x 83 columns – join of subject_train, y_train and X_train. Columns include Subject, Subject.type, Activity.label, Activity.name and 79 features

5) joined_test_data – 2947 rows x 83 columns – join of subject_train, y_train and X_train. Columns include Subject, Subject.type, Activity.label, Activity.name and 79 features

6) combined_data – 10,299 rows x 83 columns – concatenate joined_training data and joined_test_data

7) agg_combined_data – 180 rows x 83 columns – mean values of each of the features in combined_data, aggregated by Subject (30) and Activity (6)
   
