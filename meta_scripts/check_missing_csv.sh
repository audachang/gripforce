#!/bin/bash

# Define the base path to the directory containing the subject folders
base_path="/home/aclexp/TCNL Dropbox/tcnl tcnl/Tests/Motor/Grip_force_fMRI/data"

# Loop through each subject directory
for subject_dir in "${base_path}"/sub-0???; do
  # Define the paths for the left and right CSV files for each subject
  left_csv="${subject_dir}_ses-01_task-GFORCE_run-L.csv"
  right_csv="${subject_dir}_ses-01_task-GFORCE_run-R.csv"
  
  # Check if both files exist
  if [[ ! -e "$left_csv" || ! -e "$right_csv" ]]; then
    # Extract and print the subject identifier if either file is missing
    echo "Missing files for $(basename $subject_dir)"
  fi
done
