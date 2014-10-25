getdata-008-Course Project
===========
##Contents of Repo
This repository contains the following files

- Readme file
- run_analysis.R
- Codebook

###Readme file
You are now reading the readme file.

###run_analysis.R
run_analysis.R contains the script which will perform getting and cleaning the data from the zip file.

####How to use the run_analysis.R file
1. Please unzip the zip file into your working directory
2. Do not rename the folder which was unzipped in step 1. The folder name should be "UCI HAR Dataset"
3. Please make sure that you have _data.table_ package installed
4. Run the run_analysis.R script

####What does run_analysis.R scrip do
1. Merges the training and the test sets to create one data set, i.e. a data frame
2. It will only extracts the measurements on the mean and standard deviation for each measurement, i.e. columns name with mean or standard deviation will be subsetted out, except meanFrequency. There will be a total of 66 such variables hence there will be a total of 68 columns including 1 column for subject and 1 column for activity.
3. Uses descriptive activity names to name the activities, i.e. replace 1 with Walking, 2 with walking_upStairs etc.
4. Appropriately labels the data set with descriptive variables, i.e. removing brackets (), replace std as StandardDeviation, Acc as Acceleration.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject, i.e. There will only be 180 rows of measurements, 180 = 30 subjects x 6 activities.

####Output of the run_analysis.R file
A data frame which is required in step 5 of the Course Project instruction will be created. run_analysis.R has stored this in a data frame called _tidyData_ . This _tidyData_ will be uploaded as a txt file as required by the Course Project instructions.

###Codebook
The Codebook found in this Repository will explain the variables names (aka Column names) of the _tidyData_
