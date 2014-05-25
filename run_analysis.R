#The following code process data  data collected from 
#the accelerometers from the Samsung Galaxy S smartphone.
#The code merges train and test, extracts only the 
#measurements on the mean and standard deviation for each measurement, and 
#creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject

#import required libraries
library(data.table)


#read data from files
subjTest <- read.table("./test/subject_test.txt",col.names=c("SubjectID"))
subjTrain<- read.table("./train/subject_train.txt",col.names=c("SubjectID"))
features <- read.table("features.txt",col.names=c("MeasureID", "MeasureName"))
xTest<- read.table("./test/X_test.txt")
xTrain<- read.table("./train/X_train.txt")
yTest<- read.table("./test/y_test.txt")
yTrain<- read.table("./train/y_train.txt")



#Replase numbers with the names the activities from activity_labels.txt:
yTest$V1[which(yTest$V1==1)]<-"WALKING"
yTest$V1[which(yTest$V1==2)]<- "WALKING_UPSTAIRS"
yTest$V1[which(yTest$V1==3)]<- "WALKING_DOWNSTAIRS"
yTest$V1[which(yTest$V1==4)]<- "SITTING"
yTest$V1[which(yTest$V1==5)]<- "STANDING"
yTest$V1[which(yTest$V1==6)]<- "LAYING"
yTrain$V1[which(yTrain$V1==1)]<- "WALKING"
yTrain$V1[which(yTrain$V1==2)]<- "WALKING_UPSTAIRS"
yTrain$V1[which(yTrain$V1==3)]<- "WALKING_DOWNSTAIRS"
yTrain$V1[which(yTrain$V1==4)]<- "SITTING"
yTrain$V1[which(yTrain$V1==5)]<- "STANDING"
yTrain$V1[which(yTrain$V1==6)]<- "LAYNIG"


#Creating full data set
xData<- rbind(xTrain, xTest)
names(xData)<- features$MeasureName
Activity<- rbind(yTrain, yTest)
Subject<- rbind(subjTrain, subjTest)
mergedData<- cbind( xData,Activity, Subject)
names(mergedData)[562]<- paste("Activity")
names(mergedData)[563]<- paste("Subject")

#clean the names of the column headers
colnames(mergedData) <- gsub('\\-',"",names(mergedData), perl = TRUE)
colnames(mergedData) <- gsub('\\(|\\)',"",names(mergedData), perl = TRUE)
colnames(mergedData) <- gsub('\\,',"",names(mergedData), perl = TRUE)



#Subsetting the full mergedData to obtain  the mean and standard deviation for each measurement:
meanColNum<- grep(".*mean", mergedData$MeasureName)
stdColNum<- grep(".*std", mergedData$MeasureName)
subData<- mergedData[, c(meanColNum, stdColNum, 562, 563)]

#Finding the average of each variable for each subject and each activity:
tidySet<- data.table(subData)
tidySet<- tidySet[, lapply(.SD, mean), by=c("Subject", "Activity")]
tidySet<- tidySet[order(tidySet$Subject),]

#Creating text file with tidy data:
write.table(tidySet, "tidySet.txt", sep="\t")
tidySet
