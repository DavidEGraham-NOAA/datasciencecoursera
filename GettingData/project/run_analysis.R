#setwd("C:/rprojects/coursera_verified/cleaning/project//UCI HAR Dataset/working/")
xtest<-read.table("X_test.txt")
ytest<-read.table("Y_test.txt")
xtrain<-read.table("X_train.txt")
ytrain<-read.table("Y_train.txt")
#The original features list
ofeatures<-read.table("features.txt")
#Turn the features into unique names
ufeatures<-as.character(ofeatures[,2])
ufeatures<-make.names(ufeatures,unique=TRUE)
#get the subjects
subject_test<-read.table("subject_test.txt")
subject_train<-read.table("subject_train.txt")

#merge the subjects and the observations
xtest<-cbind(subject_test,xtest)
xtrain<-cbind(subject_train,xtrain)
ytest<-cbind(subject_test,ytest)
ytrain<-cbind(subject_train,ytrain)

#merge the test and training data
x_all<-rbind(xtest,xtrain)
y_all<-rbind(ytest,ytrain)

#merge the activity ids (y_all) with the observations(x_all)
all_data<-cbind(y_all,x_all)

#add the activity_id column to the variable names vector
all_names<-c("subject_id","activity_id","subjectid",ufeatures)


#assign the column names to the data
colnames(all_data)<-all_names

library(dplyr)
analysis_set<-select(all_data,matches("subject_id|activity_id|mean|std"))

activity_labels<-read.table("activity_labels.txt")

analysis_set<-merge(analysis_set,activity_labels,by.x="activity_id",by.y="V1")
#rename the new column
names(analysis_set)[names(analysis_set) == 'V2'] <- 'activity'

#remove the now-unneeded subject column
analysis_set <- subset(analysis_set, select = -c(activity_id) )

new_set<-analysis_set %>% group_by(activity,subject_id) %>% summarise_each(funs(mean))

#write our results to a csv file
write.table(new_set,file="final_set.txt",rownames=FALSE)