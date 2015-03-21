## Script for Getting and Cleaning Data Project - due 22Mar2015  -  Written by Renee Christensen

run_analysis <- function() {
        
        ## Refer to run_analysis codebook.txt for detailed information
        ## read in data files from: "C:/Users/Renee/Documents/Coursera/Getting and Cleaning data/data"
        
        orig_dir <- getwd()
        setwd("C:/Users/Renee/Documents/Coursera/Getting and Cleaning data/data")

        x_test <- read.table("X_test.txt")
        y_test <- read.table("y_test.txt")
        subject_test <- read.table("subject_test.txt")

        x_train <- read.table("X_train.txt")
        y_train <- read.table("y_train.txt")
        subject_train <- read.table("subject_train.txt")
        
        features <- read.table("features.txt")

        ## Need to fix first entry in y_test, subject_test, y_train, and subject_train files because
        ## the first character is corrupted.  The first entry will be replaced with the second entry.
        ## In the y file, the first several entries represent one activity, and in the subject files,
        ## the first several entries represent one subject.

        n <- y_test[2,1]
        y_test[1,1] <- n

        n <- subject_test[2,1]
        subject_test[1,1] <- n

        n <- y_train[2,1]
        y_train[1,1] <- n

        n <- subject_train[2,1]
        subject_train[1,1] <- n

        ## Extract columns of interest from x_test and x_train before joining
        
        mean_rows <- grep("mean()", features[,2], fixed = TRUE)
        std_rows <- grep("std()", features[,2], fixed = TRUE)
        col2xtract <- c(mean_rows, std_rows)
        col2xtract <- sort(col2xtract)

        x_test2 <- x_test[,c(col2xtract)]
        x_train2 <- x_train[,c(col2xtract)]


        ## Column bind subject_test, y_test, x_test2 together - do the same for train data
        testdata <- cbind(subject_test, y_test, x_test2)
        traindata <- cbind(subject_train, y_train, x_train2)

        ## Combine test data and train data into a single file with rbind
        motion_data <- rbind(traindata, testdata)
        
        ##  Add descriptive column names - make a vector of column names from features.txt  
        features[,2] <- as.character(features[,2])
        data_names <- features[col2xtract,2]
        col_names <- c("Subject_ID", "Activity", data_names)
        colnames(motion_data) <- col_names
                
        ## Replace activity number with descriptive name in motion_data column 2 (motion_data$Activity)  
        motion_data$Subject_ID <- as.numeric(motion_data$Subject_ID)
        motion_data$Activity <- as.character(motion_data$Activity)       
        r <- nrow(motion_data)
       
        for(i in 1:r) {             
                if(motion_data[i,2] == "1") {
                        motion_data[i,2] <- "walking"
                } else if(motion_data[i,2] == "2")  {
                        motion_data[i,2] <- "walking_upstairs"
                } else if(motion_data[i,2] == "3")  {
                        motion_data[i,2] <- "walking_downstairs"
                } else if(motion_data[i,2] == "4")  {
                        motion_data[i,2] <- "sitting"
                } else if(motion_data[i,2] == "5")  {
                        motion_data[i,2] <- "standing"
                } else if(motion_data[i,2] == "6")  {
                        motion_data[i,2] <- "laying"
                }
        }
         
        ## Load data into table and sort by subject and activity in dplyr
        library(dplyr)        
        md <- tbl_df(motion_data)
        motion_info <- arrange(md, Subject_ID, Activity)
                
        ## save the tidy data set from Part 4 of the project
        write.table(motion_info, file = "motion_part4.txt", row.names = FALSE)       
        
        ## Final part of project:  create a second tidy data set with the average of each variable for
        ## each subject and each activity.  1. Use dplyr to group_by subject and activity. 2. Summarise 
        ## grouped data for means of all the other columns.  3. Write data set to a file.
        
        motion_grouped <- group_by(motion_info, Subject_ID, Activity)
        motion_summary <- summarise_each(motion_grouped, funs(mean))
        write.table(motion_summary, file = "motion_part5.txt", row.names = FALSE)
        
        setwd(orig_dir)
}