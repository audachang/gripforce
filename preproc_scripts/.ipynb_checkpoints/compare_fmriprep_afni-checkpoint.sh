#!/bin/tcsh -ef

echo "listing subjects that have fmriprep but no afni"

# to be used in ACL@NCU IP34
# modify due to connections to dropbox 20231006; oringinal: set fmriprepdir = /media/DATA3/GripForce/out/fmriprep
set fmriprepdir = /home/aclexp/TCNL_Dropbox/tcnl_tcnl/fmriprep_out/fmriprep/
set ses = $1
#where fmriprep has two functional runs
#find $fmriprepdir/sub-*/ses-01/func/*GFORCE*bold.nii.gz |\
#	cut -d / -f 10 | tr -d sub- | cut -d _ -f 1


find $fmriprepdir/sub-*/$ses/func/*GFORCE*bold.nii.gz |\
	 cut -d / -f 10 | tr -d sub- |\
	 cut -d _ -f 1 |\
	 uniq -c |\
	 awk '$1 == 2' | awk '{print $2}' > tmp_fp

# modify due to connections to dropbox 20231006; oringinal: set afnidir = /media/DATA1/GripForce/out/afni/subject_results
set afnidir = /media/DATA3/GripForce/out/afni/subject_results

#find $afnidir/sub*/sub*.CSPLINzero.results/stats*CSPLINzero_REML+tlrc.HEAD \
#	-maxdepth 1 | cut -d / -f 8 | cut -d . -f 2

find $afnidir/sub*/$ses/sub*.CSPLINzero.results/stats*CSPLINzero_REML+tlrc.HEAD \
	-maxdepth 1 | cut -d / -f 8 |cut -d . -f 2 |\
	tr -d sub | uniq -c | awk '{print $2}'> tmp_afni


echo "subjects that have fmriprep but no afni"

comm -1 -3 tmp_afni tmp_fp > list2afni.txt
cat list2afni.txt

