##Project to merge training and test data sets

##Getting Training data

X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

##Getting Test data

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

##Getting additional files( features and activity labels)

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

##setting column names

colnames(X_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectId"
colnames(X_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectId"
colnames(activity_labels) <- c('activityId', 'activityType')



##Merging train data

train_Merge <- cbind(X_train, y_train, subject_train)

##Merging test data

test_Merge <- cbind(X_test, y_test, subject_test)

##Merging all data

All_Data <- rbind(train_Merge, test_Merge)

##Extract only mean and Standard Deviation measurments

Col_Names <- colnames(All_Data)

M_SDev <- (grepl("activityID" , Col_Names) | grepl("subjectID" , Col_Names) | grepl("mean.." , Col_Names) | grepl("std.." , Col_Names))

Sub_All_data <- All_Data[ , M_SDev == TRUE]

##Labeling the data set with descriptive variable names

Activity_Names_Set <- merge(Sub_All_data, activity_labels, all.x=TRUE)

##Creating tidy data set

Tidy_Data <- aggregate(. ~subjectId + activityId, Activity_Names_Set, by = 'activityID', mean)
Tidy_Data <- Tidy_Data[order(Tidy_Data$subjectID, Tidy_Data$activityId),]

write.table(Tidy_Data, "Tidy_Data.txt", row.names = FALSE)















