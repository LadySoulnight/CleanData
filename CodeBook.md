# "Code Book"

This document describes the source code inside `CleanData.R`.

It contains two sections:

1. Extracting, filtering and transforming the original [UCI Human Activity Recognition dataset](http://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones)
1. Summarising the average of each variable/feature for each activity and each subject

The tidy dataset is provided as `tidy_uci_har_dataset.csv` and the summarised dataset as `summarised_uci_har_dataset.csv`. 

## The Datasets

### tidy_uci_har_dataset

The code reassembles the training and test data from

- `UCI HAR Dataset/train/subject_train.txt`
- `UCI HAR Dataset/test/subject_test.txt`
- `UCI HAR Dataset/train/X_train.txt`
- `UCI HAR Dataset/test/X_test.txt`
- `UCI HAR Dataset/train/y_train.txt`
- `UCI HAR Dataset/test/y_test.txt`

into a single dataset. The subject id is stored in the first column (labeled `Subject`), followed by a subset of variables/features and the activites (labeled `Activity`).

Regarding the features, only the means and standard deviations are extracted from the original dataset. The column names are extracted from `UCI HAR Dataset/features.txt`. All other features are excluded.

The subjects and activites are represented as `factor`s. The features are provided as `numeric`s. Futhermore, the activites are labeled by `UCI HAR Dataset/activity_labels.txt`, providing a human readable representation instead of the original integer values.

Further information regarding the features, their units and how these where measured/calculated can be found on the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones).

### summarised_uci_har_dataset

This dataframe summaries the data provided by `tidy_uci_har_dataset.csv`, by averaging each feature for each activity and subject.

The calculation makes use of the [dplyr libary](https://www.r-project.org/nosvn/pandoc/dplyr.html). If not found, it is (automatically) requested to be installed.

## Helper Variables

- featureNames

    Contains the names of all features provided by `UCI HAR Dataset/features.txt`

- selectedFeatures

    Contains the index number of each feature listed in `featureNames` which contains either `-mean(` or `-std(`. It is used to subset the features of interest, stored in `tidy_uci_har_dataset.csv`.

