#!/bin/tcsh -ef


ls -a ../out/afni/subject_results/group.young/subj.sub* |\
	 grep subj | cut -d / -f 6 \
	 | tr -d subj.sub:/ | grep -v "49" > list_afni_subj.txt

cat list_afni_subj.txt | wc -l 
cat list_afni_subj.txt


