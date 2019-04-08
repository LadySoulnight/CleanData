# Selects the features of interest
featureNames <- read.table("./UCI HAR Dataset/features.txt", colClasses = "character")[, 2]
selectedFeatures <- grep("-(mean|std)\\(", featureNames)

# Extracts and reassembles the training and test data
tidy_uci_har_dataset.csv <- data.frame(
  # Subjects
  rbind(
    read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses = "factor"),
    read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses = "factor")
  ),
  # Features
  rbind(
    read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = "numeric"),
    read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = "numeric")
  )[, selectedFeatures],
  # Activities
  rbind(
    read.table("./UCI HAR Dataset/test/y_test.txt", colClasses = "factor"),
    read.table("./UCI HAR Dataset/train/y_train.txt", colClasses = "factor")
  )
)

# Renames the columns
names(tidy_uci_har_dataset.csv) <- c(
  "Subject",
  featureNames[selectedFeatures],
  "Activity"
)

# Renames the activites
levels(tidy_uci_har_dataset.csv$Activity) <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = "character")[, 2]

# Stores the tidy dataset
write.csv(tidy_uci_har_dataset.csv, file = "tidy_uci_har_dataset.csv")

#################################

# Loads (and installs if needed) the "dplyr" package
if (!require(dplyr)) {
  install.packages("dplyr")
  library(dplyr)
}

# Creates a summarised dataframe, averaging each feature for each activity and subject. 
summarised_uci_har_dataset <- tidy_uci_har_dataset.csv %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)

# Stores the summarised dataset
write.csv(summarised_uci_har_dataset, file = "summarised_uci_har_dataset.csv")
