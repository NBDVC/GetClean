files<-list.files(recursive = T, pattern = ".txt", full.names=T)[
      !grepl('README',list.files(recursive = T, pattern = ".txt"), ignore.case = TRUE)
       &!grepl('_info',list.files(recursive = T, pattern = ".txt"), ignore.case = TRUE)
      ]
names<-substr(files, start=regexpr("\\/[^\\/]*$", files)+1, stop=regexpr("\\.[^\\.]*$", files)-1)

Data <- lapply(files, read.table)
names(Data)<-names

#Build the Train Data Frame

Train<-cbind(subject=Data$subject_train,activity_num=Data$y_train,Data$X_train)
colnames(Train)[1]<-"subject"
colnames(Train)[2]<-"activity_num"
colnames(Train)[3:563]<-as.character(Data$features[,2])
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive activity names.
Train<-cbind(activity=as.character(Data$activity_labels$V2[match(Data$y_train$V1,Data$activity_labels$V1)]),Train)

#Build the Test Data Frame

colnames(Data$X_test)<-as.character(Data$features[,2])
Test<-cbind(subject=Data$subject_test,activity_num=Data$y_test,Data$X_test)
colnames(Test)[1]<-"subject"

colnames(Test)[2]<-"activity_num"
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive activity names.
Test<-cbind(activity=as.character(Data$activity_labels$V2[match(Data$y_test$V1,Data$activity_labels$V1)]),Test)

Test<-cbind(group="test", Test)
Train<-cbind(group="train", Train)

#Merges the training and the test sets to create one data set.
Total<-rbind(Test,Train)


#Extracts only the measurements on the mean and standard deviation for each measurement. 
Mean_STD<-Total[,grepl("-mean",colnames(Total), ignore.case = TRUE)  & 
                  !grepl("-meanF",colnames(Total), ignore.case = TRUE)|
                  grepl("-std",colnames(Total), ignore.case = TRUE)]

# Creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
aggTotal<-aggregate(Total[,3:565], by=list(Total$activity,Total$subject), FUN=mean, na.rm=TRUE)
write.csv(aggTotal, "Tidy.csv")