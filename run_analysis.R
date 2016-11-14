## Let's clear the environment

rm(list=ls())

## Let's store the file paths to each file and  folder within the main folder UCI HAR Dataset in a variable

wdpath <- file.path(getwd())
ucipath <- file.path(wdpath,"UCI HAR Dataset")
featpath <- file.path(ucipath,"features.txt")
actpath <- file.path(ucipath,"activity_labels.txt")


## Let's store the file paths to each file and folder for the train data set.

trainpath <- file.path(ucipath,"train")
subtrainpath <- file.path(trainpath,"subject_train.txt")
xtrainpath <- file.path(trainpath,"X_train.txt")
ytrainpath <- file.path(trainpath,"y_train.txt")

## Lets store the proper names of all the variables in a variable

featnames <- read.table(featpath)

## Let's store the names of all the activities in a variable

acts <- read.table(actpath)

## Let's create a data set which is "TIDY" and stores the subjects, activity and all the 561 variables of the TRAIN data set in one TIDY DATA FRAME

trpred <- read.table(xtrainpath)
names(trpred) <- featnames[,2]
trsubs <- read.table(subtrainpath)
names(trsubs) <- "subject"                       ### >>STEP # 4<<
pretrainfinal <- cbind(trsubs,trpred)            ### >>STEP # 4<<
trtarget <- read.table(ytrainpath)
library(dplyr)
trtarget.2 <- inner_join(trtarget,acts)
pretrainfinal.2 <- cbind(pretrainfinal,"activity"=trtarget.2$V2) ### >>STEP # 3<<

## Let's store the file paths to each file and folder for the test data set.

testpath <- file.path(ucipath,"test")
subtestpath <- file.path(testpath,"subject_test.txt")
xtestpath <- file.path(testpath,"X_test.txt")
ytestpath <- file.path(testpath,"y_test.txt")

## Let's create a "TIDY" data set which stores the subjects, activity and all the other 561 variables of the TEST data set within one TIDY DATA FRAME


testpred <- read.table(xtestpath)
names(testpred) <- featnames[,2]
testsubs <- read.table(subtestpath)
names(testsubs) <- "subject"                    ### >>STEP # 4<<
pretestfinal <- cbind(testsubs,testpred)        ### >>STEP # 4<<
testtarget <- read.table(ytestpath)
testtarget.2 <- inner_join(testtarget,acts)
pretestfinal.2 <- cbind(pretestfinal,"activity"=testtarget.2$V2)   ### >>STEP # 3<<

## Let's combine the train and test data set. >>STEP # 1<<

final <- rbind(pretrainfinal.2,pretestfinal.2)

## Let's extract the mean and standard deviations of each measurement >>STEP # 2<<

qpreds <- grep("mean()|std()",names(final))
subsetfinal <- final[,c(1,qpreds,563)]

## Let's create a second independent tidy data set with the average of each variable for each activity and each subject ### >>STEP # 5<<

grouped <- subsetfinal %>% group_by(subject,activity)
summarized <- summarize_each(grouped,funs(mean))

## Let's write the table to a new txt file

write.table(summarized,"summarized.txt",row.name=F)