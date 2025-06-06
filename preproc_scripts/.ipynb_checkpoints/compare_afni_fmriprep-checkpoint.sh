#!/bin/tcsh -ef


set fmriprep_dir = "/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep"

ls -a ../out/afni/subject_results/subj* | grep : |\
    cut -d . -f 4 | tr -d sub |\
    tr -d :> tmp_ana

# before the update of dropbox in 2024/01
#ls -a ../out/fmriprep/sub-* |grep : | cut -d - -f 2 | tr -d :/ > tmp_fp

#after the update of dropbox in 2024/01
ls -a $fmriprep_dir/sub-* |grep : | cut -d - -f 2 | tr -d :/ > tmp_fp

#find /media/DATA1/Dropbox/Dropbox/Tests/3_RawData/sub-00*/mri \
#	| grep mri | cut -d - -f 2 | tr -d /mri/B_L:> tmp_dp

echo list difference between fmriprep and BIDS folders
comm -2 -3 tmp_ana tmp_fp


