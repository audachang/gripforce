#!/bin/bash

# Define the base path to the directory containing the data files
base_path="/home/aclexp/TCNL Dropbox/tcnl tcnl/Tests/Motor/Grip_force_fMRI/data"

# Loop through each potential subject identifier
for subject_id in ${base_path}/sub-0???; do
  # Construct the wildcard paths for the left and right CSV files
  left_files=(${subject_id}_ses-01_task-GFORCE_run-L.csv)
  right_files=(${subject_id}_ses-01_task-GFORCE_run-R.csv)
  
  # Count the number of files matching each pattern
  num_left_files=${#left_files[@]}
  num_right_files=${#right_files[@]}
  
  # Check if there are extra files for either left or right
  if [[ $num_left_files -gt 1 || $num_right_files -gt 1 ]]; then
    echo "Extra files found for $(basename $subject_id):"
    [[ $num_left_files -gt 1 ]] && echo "  Left: ${num_left_files} files"
    [[ $num_right_files -gt 1 ]] && echo "  Right: ${num_right_files} files"
  fi
done
