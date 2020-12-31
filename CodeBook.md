The R script will perform the following:

1. Merges the training and test sets together

2. It will remove the unrelevant columns except for the mean and std.

3. Clean up the columns of the dataset by removing underscore, parenthesis and convert to lowercase

4. The entire dataset is then merged together called mergeTable with dimension of 10299X68 dataframe
which will create a new text file called "merged_tidy_dataset.txt

5. Then the script will create a 2nd, independent tidy data set with the average of each measurement 
for each activity and each subject. The output table is saved as "average_dataset.txt" 
