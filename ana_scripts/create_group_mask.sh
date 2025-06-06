#!/usr/bin/tcsh -ef


set ddir = ../out/afni/subject_results/group.young

find $ddir/subj.*/sub*.$1.results/sub-????_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc.HEAD \
 | grep  -v "49" > tmp 


set fn = (`cat tmp`)
set nv = (`cat tmp | wc -l`)

3dmask_tool -input $ddir/subj.*/sub*.$1.results/full*.HEAD \
	-prefix $ddir/mask_intersection_n${nv}+tlrc \
	-inter -overwrite
