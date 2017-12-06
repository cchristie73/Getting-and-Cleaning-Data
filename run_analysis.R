
##Loading library

library(reshape2)

##Getting Training data

X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

##Getting Test data

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")


##Merging train data

train_Merge <- cbind(X_train, y_train, subject_train)

##Merging test data

test_Merge <- cbind(X_test, y_test, subject_test)

##Merging all data

All_Data <- rbind(train_Merge, test_Merge)

##Getting additional files( features and activity labels)

features <- read.table("features.txt")
features[,2] <- as.character(features[,2])
activity_labels <- read.table("activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])

##Extracting mean and standard deviaton for each measurment

NewFeatures <- grep(".*mean.*|.*std.*", features[,2])
NewFeatures.names <- features[NewFeatures,2]
NewFeatures.names = gsub('-mean', 'Mean', NewFeatures.names)
NewFeatures.names = gsub('-std', 'Std', NewFeatures.names)
NewFeatures.names <- gsub('[-()]', '', NewFeatures.names)

##Labeling the data with descriptive names

colnames(All_Data) <- c("subject", "activity", NewFeatures.names)

All_Data$activity <- factor(All_Data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
All_Data$subject <- as.factor(All_Data$subject)


##creating tidy data set using reshape2 library

All_Data.reshape <- melt(All_Data, id = c("subject", "activity"))
All_Data.tidy <- dcast(All_Data.reshape, subject + activity ~ variable, mean)

write.table(All_Data.tidy, file = "Tidy_Data.txt", row.names = FALSE, quote = FALSE)



