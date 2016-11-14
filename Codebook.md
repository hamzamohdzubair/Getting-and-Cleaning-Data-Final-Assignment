# Codebook

## Following Transformations were done on available data

1. Names of variable were extracted from features.txt
2. Names of activities were extracted from activity_labels.txt

### The following was done separately for train and test data
1. Subjects were taken from subject_train.txt and subject_test.txt
2. Activity was taken from y_train.txt and y_test.txt
3. Main measurements were taken from X_train.txt and X_test.txt
4. The above three were combined to give a data frame of 563 columns and 7352 rows for train and 2947 rows for test data set.

##  Final Steps
1. Finally train and test data was combined
2. The mean and std measurements were extracted
3. This data was grouped by subject and activity and summarized to averages.
