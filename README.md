
##run_analysis.R README.md

The enclosed run_analysis.R script was written to read in data files from the Human Activity Recognition Using Smartphones Dataset Version 1.0, tidy them up, and write out two clean sets of data.  The specific files, variable information, and description of the analysis are included in the run_analysis codebook.txt.  

To run this software:


Step 1.  Download the data files from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Step 2.  Unzip the files and place the following files in your working directory:

x_test.txt
y_test.txt
subject_test.txt
x_train.txt
y_train.txt
subject_train.txt 
features.txt

Step 3.  Edit Line 9 of the run_analysis.R to your working directory which contain the files.  The comment in Line 6 should also be changed to reflect your personal working directory.

Step 4.  Run the program.

Step 5.  After sucessful completion, there should be two new files in your working directory, motion_part4.txt and motion_part5.txt.  The first is a 10299 x 68 table of data that includes the subject ID and activity and 66 columns of the original data set.  The second data set is a 180 x 68 table of data which shows the mean value of the 66 columns of motion data for each subject and each activity.  There are 30 subjects and 6 activities (laying, sitting, standing, walking, walking downstairs, and walking upstairs). 



Data Reference:

================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
================================================================


