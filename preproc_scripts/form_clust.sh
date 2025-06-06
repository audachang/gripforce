#!/bin/tcsh -ef

set subroot = /media/DATA2/GripForce/out/afni/subject_results/group.young
set sid = $1
set subdir = $subroot/subj.sub{$sid}/sub{$sid}.results 

set condstr = $2
set lab_dat = "{$condstr}#0_Coef"
set lab_thr = "{$condstr}#0_Tstat"


3dClusterize -nosum -1Dformat \
	-inset $subdir/stats.sub{$sid}_REML+tlrc \
	-idat $lab_dat -ithr $lab_thr -NN 1 \
	-clust_nvox 30 -bisided p=$3 \
	-mask $subroot/group_results/mask_intersection+tlrc \
	-overwrite  \
	-pref_map $subroot/cluster_masks/sub{$sid}_{$condstr}_Clust_mask \
	> $subroot/cluster_masks/sub{$sid}_{$condstr}_Clust_tbl.txt




#COMMAND export from the Cluster GUI
#3dClusterize -nosum -1Dformat \
#	-inset /media/DATA2/GripForce/out/afni/subject_results/group.young/subj.sub0001/sub0001.results/stats.sub0001_REML+tlrc.HEAD \
#	-idat 40 -ithr 41 -NN 3 \
#	-clust_nvox 40 -bisided -3.3084 3.3084 \
#	-mask_from_hdr
