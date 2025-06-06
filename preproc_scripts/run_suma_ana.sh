#!/bin/tcsh -xef


#This is required because somehow there is a textline
# Comment #!ascii text.... in surf.smooth.params.1D
setenv AFNI_1D_ZERO_TEXT YES


set subid1 = $1
set subid2 = sub{$subid1}
set subid3 = sub-{$subid1}
set out_root = /media/DATA2/GripForce/out/afni/subject_results/group.young
set regstimorder = $2
set extrfile1 = /media/DATA2/GripForce/out/fmriprep/sub-{$subid1}/ses-01/func/{$subid3}_ses-01_task-GFORCE_run-1_desc-confounds_sel_timeseries.1D
set extrfile2 = /media/DATA2/GripForce/out/fmriprep/sub-{$subid1}/ses-01/func/{$subid3}_ses-01_task-GFORCE_run-2_desc-confounds_sel_timeseries.1D
set extrfile = /media/DATA2/GripForce/out/fmriprep/sub-{$subid1}/ses-01/func/{$subid3}_ses-01_task-GFORCE_desc-confounds_sel_timeseries.1D

#set extralab = `head -1 $extrfile`
if  ! ( -d $out_root/subj.$subid2) then
    #echo output dir "$subj.results" already exists
    mkdir $out_root/subj.$subid2
    #mkdir $out_root/subj.$subid2/$subid2.results
endif



if  ( -d $out_root/subj.$subid2/$subid2.suma.results) then
    #echo output dir "$subj.results" already exists
    #mkdir $out_root/subj.$subid2
    rm -R $out_root/subj.$subid2/$subid2.suma.results
endif


if  ! ( -d $out_root/subj.$subid2/$subid2.suma.results) then
	mkdir $out_root/subj.$subid2/$subid2.suma.results
endif




set regstilab = "R40 R60 L40 L60 "



afni_proc.py -subj_id sub{$subid1}.suma \
    -script proc.suma.sub$subid1 \
 	-scr_overwrite \
	-blocks                   \
	     surf blur scale regress \
	-copy_anat                                                   \
	    /media/DATA2/GripForce/out/afni/$subid3/ses-01/anat/{$subid3}_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w.nii.gz                    \
	-dsets                                                                                                                                    \
	    /media/DATA2/GripForce/out/afni/$subid3/ses-01/func/{$subid3}_ses-01_task-GFORCE_run-1_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz \
	    /media/DATA2/GripForce/out/afni/$subid3/ses-01/func/{$subid3}_ses-01_task-GFORCE_run-2_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz \
	-tcat_remove_first_trs 0  \
    -regress_stim_times                                                                               \
	    /media/DATA2/GripForce/beh/{$subid3}_ses-01_task-GFORCE_run-01-40%.1D                                                                        \
	    /media/DATA2/GripForce/beh/{$subid3}_ses-01_task-GFORCE_run-01-60%.1D                                                                        \
	    /media/DATA2/GripForce/beh/{$subid3}_ses-01_task-GFORCE_run-02-40%.1D                                                                        \
	    /media/DATA2/GripForce/beh/{$subid3}_ses-01_task-GFORCE_run-02-60%.1D                                                                        \
	-surf_anat $fs_data/$subid3/surf/SUMA/{$subid3}_SurfVol.nii       \
	-surf_spec $fs_data/$subid3/surf/SUMA/std.141.{$subid3}_?h.spec  \
    -blur_size 4.0    \
	-regress_stim_labels $regstilab -regress_basis GAM                 \
	-regress_extra_stim_files $extrfile \
	-regress_extra_stim_labels non_interest\
	-regress_opts_3dD                                          \
	-jobs 16                                                   \
	-num_glt 10                                                \
    -gltsym 'SYM: L40 +L60 -R60 -R40' -glt_label 1 L-R          \
    -gltsym 'SYM: R40 +R60 -L40 -L60' -glt_label 2 R-L          \
    -gltsym 'SYM: R60 -R40 -L60 +L40' -glt_label 3 int        \
    -gltsym 'SYM: L60 +R60 -L40 -R40' -glt_label 4 60-40        \
    -gltsym 'SYM: L40 +L60' -glt_label 5 L                      \
    -gltsym 'SYM: R40 +R60' -glt_label 6 R                      \
    -gltsym 'SYM: L60 +R60' -glt_label 7 60                    \
    -gltsym 'SYM: L40 +R40' -glt_label 8 40                     \
    -gltsym 'SYM: L60 -L40' -glt_label 9 L60-L40               \
    -gltsym 'SYM: R60 -R40' -glt_label 10 R60-R40                \
    -regress_compute_fitts                                      \
    -regress_make_ideal_sum sum_ideal.1D                        \
    -regress_censor_outliers 0.15


# -regress_local_times                                                                                                        \                                                                                                                \

#-regress_apply_mot_types demean deriv -regress_motion_per_run                                                                             \



mv proc.suma.sub$subid1 $out_root/subj.$subid2


#For handling SUMA_SurfSmooth_ParseInput: error
# solution: change the blur_size to a different value from the orginal one 
# Error SUMA_SurfSmooth_ParseInput:
# Unexpected combo: fwhm -1.000000, tfwhm -1.000000, sigma 1.039500 
#https://afni.nimh.nih.gov/afni/community/board/read.php?1,146445,146509#msg-146509