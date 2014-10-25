## Startup - unzip the zip file into your working directory, it will unzip a folder named
## "UCI HAR Dataset"
path <- getwd()

#pathOfData contains the path to the folder unzip earlier
pathOfData <- file.path(path, "UCI HAR Dataset")

#list of packages required
#1) data.table #setname uses this

library(data.table)

# Read X_test.txt data into x_test, file.path will direct read.table to the test folder
x_test <- read.table(file.path(pathOfData, "test", "X_test.txt"))

# Read y_test.txt data into y_test, file.path will direct read.table to the test folder
y_test <- read.table(file.path(pathOfData, "test", "y_test.txt"))

# Read subject_test.txt data into subject_train, file path will direct read.table to the test folder
subject_test <- read.table(file.path(pathOfData, "test", "subject_test.txt"))

# Read x_train.txt data into x_train, file.path will direct read.table to the train folder
x_train <- read.table(file.path(pathOfData, "train", "X_train.txt"))

# Read y_train.txt data into y_train, file.path will direct read.table to the train folder
y_train <- read.table(file.path(pathOfData, "train", "y_train.txt"))

# Read subject_train.txt data into subject_train, file.path will direct read.table to the train folder
subject_train <- read.table(file.path(pathOfData, "train", "subject_train.txt"))

##1) Merges the training and the test sets to create one data set.
# Combine both x_test and x_train
x_all <- rbind(x_test, x_train)

# Combine both y_test and y_train
y_all <- rbind(y_test, y_train)

# Combibe both subject_test and subject _train
subject_all <- rbind(subject_test, subject_train)

#get all the features, features are actually the column names of the test & train data sets
#note features.txt actually has 2 columns, 1st column is ascending number, 2nd column is
#the feature name of the data.
dtFeatures <- read.table(file.path(pathOfData, "features.txt"))

#Rename column names of x_all to each corresponded features variable
colnames(x_all) <- dtFeatures[,2]

#Rename column name of y_all as "Activity"
colnames(y_all) <- c("Activity")

#Rename column name of subject_all as "Subject"
colnames(subject_all) <- c("Subject")

##subset only those measurements on mean & std for each measurement
#grepl returns the indices of those column names which contain mean or std
x_Required <- x_all[,grepl("mean\\(\\)|std\\(\\)", names(x_all))]

#Append Activity Column and Subject Column to Features Columns to form the required DataFrame
finalDataFrame <- cbind(y_all, subject_all, x_Required)

##3) Uses descriptive activity names to name the activities in the data set
#activity_labels shows the activity which each number (1 to 6) represents
activity_labels <- read.table(file.path(pathOfData, "activity_labels.txt"))


#change each observation in finalDataFrame to descriptive activity based on the table 
#in activity_labels
for (i in 1:nrow(finalDataFrame)){
    
    for (j in 1:nrow(activity_labels)){
        if(finalDataFrame[i,1] == activity_labels[j,1]){
            finalDataFrame[i,1] <- as.character(activity_labels[j,2])
        }
    }
}

##4) Appropriately labels the data set with descriptive variable names
# The following will remove the brackets from all the features variables, change Acc t
# Acceleration, change Mag to Magnitude and change std to StandardDeviation.
names(finalDataFrame) <- gsub(pattern = "mean()", replacement = "Mean", x = names(finalDataFrame), fixed = TRUE)
names(finalDataFrame) <- gsub(pattern = "std()", replacement = "StandardDeviation", x = names(finalDataFrame), fixed = TRUE)
names(finalDataFrame) <- gsub(pattern = "Acc", replacement = "Acceleration", x = names(finalDataFrame), fixed = TRUE)
names(finalDataFrame) <- gsub(pattern = "Mag", replacement = "Magnitude", x = names(finalDataFrame), fixed = TRUE)


##From the data set in step 4, creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject. 
#Aggregate will apply the function (i.e. Mean) to all Columns (excluding Activity & Subject), 
#as only the features columns are included in the calculation
tidyData <- aggregate(finalDataFrame[,3:ncol(finalDataFrame)], by=list(Activity = finalDataFrame$Activity, Subject = finalDataFrame$Subject), FUN=mean)

#Since the variables now represent mean of either mean or Standard Deviation, it would be
#appropriate to replace the variables name accordingly, i.e. Mean now becomes MeanOfMean,
#StandardDeviation becomes MeanOfStandardDeviation
names(tidyData) <- gsub(pattern = "Mean", replacement = "MeanOfMean", x = names(tidyData), fixed = TRUE)
names(tidyData) <- gsub(pattern = "StandardDeviation", replacement = "MeanOfStandardDeviation", x = names(tidyData), fixed = TRUE)
