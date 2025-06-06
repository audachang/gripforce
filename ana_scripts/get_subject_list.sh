#!/usr/bin/tcsh  -ef
echo "Extracting subjects with afni outcomes "

ls -d ../out/afni/subject_results/subj.*/*CSPLIN.results/stat*REML+tlrc.HEAD | \
	cut -d . -f 4 | sed 's/sub/sub-/' |\
	 tr -d sub- | cut -d / -f 1 > list_afni_subjects.txt

cat list_afni_subjects.txt
