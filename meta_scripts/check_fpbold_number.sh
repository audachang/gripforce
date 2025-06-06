#!/bin/bash

# Check if two arguments were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <base_dir_option> <session_option>"
    echo "<base_dir_option>: 1 for '/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep/'"
    echo "                   2 for '/media/DATA3/GripForce/out/fmriprep/'"
    echo "<session_option>: 1 for 'ses-01'"
    echo "                  2 for 'ses-02'"
    exit 1
fi

# Assign base path based on the first argument
case $1 in
    1) base_path="/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep/";;
    2) base_path="/media/DATA3/GripForce/out/fmriprep/";;
    *) echo "Invalid base directory option: $1"; exit 1 ;;
esac

# Assign session based on the second argument
case $2 in
    1) session="ses-01";;
    2) session="ses-02";;
    *) echo "Invalid session option: $2"; exit 1 ;;
esac

# Log file to save the check information
log_file="check_bold_files_${session}.log"

# Initialize counters for run-1 and run-2
total_run_1=0
total_run_2=0

# Write header to log file
echo "SubjectID Run-1_Found Run-2_Found" > "$log_file"

# Loop through each subject directory
for subject_dir in "${base_path}"sub-0???; do
    subject_id=$(basename "$subject_dir")
    func_dir="${subject_dir}/${session}/func"
    
    # Initialize existence flags
    run_1_exists=0
    run_2_exists=0
    
    # Check for run-1 file
    run_1_file="${func_dir}/${subject_id}_${session}_task-GFORCE_run-1_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz"
    if [ -f "$run_1_file" ]; then
        run_1_exists=1
        ((total_run_1++))
    fi
    
    # Check for run-2 file
    run_2_file="${func_dir}/${subject_id}_${session}_task-GFORCE_run-2_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz"
    if [ -f "$run_2_file" ]; then
        run_2_exists=1
        ((total_run_2++))
    fi
    
    # Write the check information to log file
    echo "${subject_id:4} $run_1_exists $run_2_exists" >> "$log_file"
done

# Print out the total numbers
echo "Total run-1 bold files found: $total_run_1" >> "$log_file"
echo "Total run-2 bold files found: $total_run_2" >> "$log_file"

# Also print the totals to the terminal
echo "Total run-1 bold files found: $total_run_1"
echo "Total run-2 bold files found: $total_run_2"
