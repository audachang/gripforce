#!/bin/tcsh -ef




ls -a ../out/freesurfer/sub-* |grep : | cut -d - -f 2 | tr -d :/ > tmp_fs

ls ../out/afni/subject_results/group.young | \
	grep subj |\
	 tr -d subj.sub | tr -d / > tmp_afni


comm -1 -3 tmp_afni tmp_fs > list_fs+afni-.txt
cat list_fs+afni-.txt

