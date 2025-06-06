import os
import sys
import glob
import re

def extract_subject_id(path):
    # Extracts the subject ID with exactly four digits following 'sub-' from a given path
    match = re.search(r'sub-?\d{4}', path)
    return match.group(0) if match else None

def find_subjects_with_complete_data(session):
    raw_data_dir_template = "/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep/{subject}/{session}/func/"
    outcome_dir_template = "/media/DATA3/GripForce/out/afni/subject_results/{subject}/{session}/sub*.CSPLINzero.results/"
    
    subjects_raw = glob.glob("/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep/sub-*/")
    subjects_outcome = glob.glob("/media/DATA3/GripForce/out/afni/subject_results/subj.sub*/")
    raw_data_subjects = set()
    outcome_subjects = set()

    for subject_path in subjects_raw:
        subject_id = extract_subject_id(subject_path)
        if subject_id:
            raw_files = glob.glob(raw_data_dir_template.format(subject=subject_id, session=session) + "*task-GFORCE_run-2*_bold.nii.gz")
            #print(raw_data_dir_template.format(subject=subject_id, session=session)+"*task-GFORCE_run-2*_bold.nii.gz")
            if raw_files:
                raw_data_subjects.add(subject_id.replace('sub-',''))

    for subject_path in subjects_outcome:
        subject_id = extract_subject_id(subject_path.replace('subj.', ''))
        if subject_id:
            outcome_files = glob.glob(outcome_dir_template.format(subject="subj." + subject_id, session=session) + "stats.*.CSPLINzero_REML+tlrc.HEAD")
            if outcome_files:
                outcome_subjects.add(subject_id.replace('sub',''))
    
    complete_subjects = raw_data_subjects.intersection(outcome_subjects)
    only_raw_data_subjects = raw_data_subjects.difference(outcome_subjects)
    only_outcome_subjects = outcome_subjects.difference(raw_data_subjects)
    
    print(f"Total subjects with complete datasets: {len(complete_subjects)}")
    print(f"Subjects with only raw data: {len(only_raw_data_subjects)} - {sorted(list(only_raw_data_subjects))}")
    print(f"Subjects with only outcome data: {len(only_outcome_subjects)} - {sorted(list(only_outcome_subjects))}")
    
    with open('list_fp+_afni+.txt', 'w') as file:
        for subject in sorted(complete_subjects):
            file.write("%s\n" % subject)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <session>")
        sys.exit(1)
    
    session = sys.argv[1]
    if session not in ["ses-01", "ses-02"]:
        print("Invalid session. Use 'ses-01' or 'ses-02'.")
        sys.exit(1)
    
    find_subjects_with_complete_data(session)
