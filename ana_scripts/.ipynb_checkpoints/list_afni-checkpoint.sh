#!/bin/tcsh -ef
# Check if the number of arguments is less than 2
if ($#argv < 1) then
    echo 
    echo "Error: This script requires at least 1 arguments."
    echo
    echo "Usage: ./list_afni.sh <sesid>"
    echo "sesid: the session ID"
    echo 
    exit 1  # Exit with a non-zero status to indicate an error
endif

set ses = $1

set afnidir = ../out/afni/subject_results

#find $afnidir/sub*/sub*.CSPLIN.results/stats*CSPLIN_REML+tlrc.HEAD \
#	-maxdepth 1 | cut -d / -f 6

ls $afnidir/sub*/$ses/sub*.CSPLINzero.results/stats*CSPLINzero_REML+tlrc.HEAD

find $afnidir/sub*/$ses/sub*.CSPLINzero.results/stats*CSPLINzero_REML+tlrc.HEAD \
	-maxdepth 1 | cut -d / -f 7 |cut -d . -f 1 |\
	tr -d sub | uniq -c | awk '{print $2}'> list_afni_$ses.txt

echo list all afni subjects
cat list_afni_$ses.txt
echo ===========
echo total number of subjects: `cat list_afni_$ses.txt | wc -l`
#echo list difference between fmriprep and afni folders
#comm -1 -3 tmp_afni tmp_fp > list2afni.txt
#cat list_afni_subjects.txt
