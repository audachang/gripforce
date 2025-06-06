#!/bin/tcsh -ef

# to be used on tcnl@nycu ()

set ses = $1
set afnidir = ../out/afni/subject_results



find $afnidir/sub*/$ses/sub*.CSPLINzero.results/stats*CSPLINzero_REML+tlrc.HEAD \
	-maxdepth 1 | cut -d / -f 7 |cut -d . -f 1 |\
	tr -d sub | uniq -c | awk '{print $2}'> list_afni_subjects.txt

echo list all afni subjects
cat list_afni_subjects.txt
echo ===========
echo total number of subjects: `cat list_afni_subjects.txt | wc -l`
#echo list difference between fmriprep and afni folders
#comm -1 -3 tmp_afni tmp_fp > list2afni.txt
#cat list_afni_subjects.txt
