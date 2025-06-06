#!/usr/bin/tcsh -ef 


set ses = $1
#set fpdir = /media/tcnl/data2/fmriprep/out/fmriprep
#set fpdir = /media/DATA3/GripForce/out/fmriprep
#set fpdir = '/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep'
set fpdir = '/home/aclexp/TCNL_Dropbox/tcnl_tcnl/fmriprep_out/fmriprep'
echo $fpdir


#sub-0001_ses-01_task-GFORCE_run-1_space-MNI152NLin2009cAsym_desc-preproc_bold

# the trailing / is important for only listing directory


ls  "$fpdir"/*/*/func/*GFORCE_run-2*preproc_bold.nii.gz | grep $ses |\
	cut -d  '/' -f 8 | grep sub|\
	cut -d -  -f2 | tr -d / > list_fp+.txt 
