# coursera-getting-and-cleaning-data-project
See: https://www.coursera.org/course/getdata

== How the script works ==

Run the script run_analysis.R. As an output, you should find the same folder a file called tidy-data-set-created-in-step-5.txt with a content like this:

-----------------------------------------------------------------
subject_activity_variable|average
10|LAYING|fBodyAcc-mean()-X|-0.96918420862069
10|LAYING|fBodyAcc-mean()-Y|-0.954341849137931
.
.
.
24|WALKING_DOWNSTAIRS|fBodyGyro-std()-Z|-0.573281905454545
24|WALKING_DOWNSTAIRS|tBodyAcc-mean()-X|0.288631208909091
.
.
.
9|WALKING|tGravityAccMag-mean()|-0.0980840496143461
9|WALKING|tGravityAccMag-std()|-0.37942877
-----------------------------------------------------------------

== Code book describing the variables ==

* Subject: identify by a number each person that volunteered for the project.
* Activity: are the phisical activities when taking the measure. There are 6 types: walking, walking upstairs, walking downstairs, sitting, standing, and laying
* Variable: type of meassure. There are 561 types. See file features.txt for further info.
* Average: average of each variable for each activity and each subject.

