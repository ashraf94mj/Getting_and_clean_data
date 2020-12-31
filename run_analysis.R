#1. Merges the training and the test sets to create one data set.

trainX<-read.table("UCI HAR Dataset/train/x_train.txt")
testX<-read.table("UCI HAR Dataset/test/x_test.txt")
X<-rbind(trainX, testX)

trainY<-read.table("UCI HAR Dataset/train/y_train.txt")
testY<-read.table("UCI HAR Dataset/test/y_test.txt")
Y<-rbind(trainY, testY)

trainSubject<-read.table("UCI HAR Dataset/train/subject_train.txt")
testSubject<-read.table("UCI HAR Dataset/test/subject_test.txt")
Subject<-rbind(trainSubject, testSubject)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features<- read.table("UCI HAR Dataset/features.txt")
features_mean_std<- grep("-mean\\(\\)|-std\\(\\)", features[,2])
X<-X[,features_mean_std]
names(X)<-features[features_mean_std,2]
names(X)<-tolower(names(X))
names(X)<-gsub("[()]","", names(X))

#3.Uses descriptive activity names to name the activities in the data set

activity<- read.table("UCI HAR Dataset/activity_labels.txt")
activity[,2]<-tolower(activity[,2])
activity[,2]<-gsub("_","", activity[,2])
Y[,1]<-activity[Y[,1],2]
names(Y)<- "activity"

#4. Appropriately labels the data set with descriptive variable names.

names(Subject)<-"subject"
mergeTable<-cbind(Subject,Y, X)
write.table(mergeTable, "merged_tidy_dataset.txt")

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Subjects<-unique(Subject)[, 1]
numSubjects<-length(unique(Subject)[,1]) #should be 30
numActivities<-length(activity[,1]) #should be 6
numAttributes<-dim(mergeTable)[2] #should be 68
finalTable<- as.data.frame(matrix(nrow=180,ncol=68))
names(finalTable)<-names(mergeTable)

row<- 1
for (i in 1:numSubjects){
  for (a in 1:numActivities) {
    finalTable[row,1] <- i
    finalTable[row,2] <-activity[a,2]
    data<-mergeTable[mergeTable$subject==i & mergeTable$activity==activity[a,2],]
    finalTable[row,3:numAttributes]<- colMeans(data[,3:numAttributes])
    row<- row+1
  }
}
write.table(finalTable, "average_dataset.txt")



