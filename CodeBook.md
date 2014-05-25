Source:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Original:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The attached R script (run_analysis.R) performs the following to clean up the data:
•1. Merges the training and test sets to create one data set, namely

train/X_train.txt with test/X_test.txt -- the result is a 10299 x 561 data frame

train/subject_train.txt with test/subject_test.txt -- the result is a 10299 x 1 data frame with subject IDs,

train/y_train.txt with test/y_test.txt -- the result is 10299 x 1 data frame with activity IDs.
•2. Reads file features.txt and extracts only the measurements on the mean and standard deviation for each measurement.

The result is a 10299 x 79 data frame, because only 79 out of 561 attributes are measurements on the mean and standard deviation.
•3. Replace Activity numbers with names 
1->WAKING

2->WALKING.UPSTAIRS

3->WALKING.DOWNSTAIRS

4->SITTING

5->STANDING

LAYNG •4. The script also appropriately labels the data set with descriptive names: all feature names (attributes) and 
activity names are converted to lower case,underscores and brackets () are removed.

The result is saved as mergedData, a 10299x81 data frame such that the first column contains subject IDs, the second column
activity names, and the last 79 columns are measurements. Subject IDs are integers between 1 and 30 inclusive. Names of the 
attributes are similar to the following:

tBodyAcc-XYZ 
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag 
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ 
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag 
fBodyGyroJerkMag


•5. The script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject.
The result is saved as tydySet.txt, a 180x81 data frame. 
