#!/bin/tcsh -ef
if ( $#argv != 6 ) then
	echo "usage: ../ana_scripts/roi_ana_model_Coef.sh <condstr> <atlas> "
	echo "	 <parameter id> <sub_fn>  <NNval> <sesid>"
	echo "Example: ../ana_scripts/roi_ana_model_Coef.sh R40 FS.MNI2009c_asym 0 list_afni_ses-01.txt 1 ses-01"
	echo condstr: the condition parameter to be extracted (side X force level)
    echo atlas: name of the atlas to use for ROI extraction
    echo parameter id: the nth impulse response beta
	echo sub_fn: number of subjects included in the analysis
    echo NNVal: voxel neighbor definition
    echo sesid: which session in logitudinal design 
	exit 0
endif

set ddir = '../out/afni/subject_results'
set scrdir = `pwd`
#set sids =  (`cat ../preproc_scripts/batch15_20210924.txt | tr -d sub-` )
#set sids =  (`cat list_afni_subj.txt` )
set Subjfn = $4
set sids =  (`cat $Subjfn` )


#echo $sids
set condstr = $1
set atlas = $2
set cid = $3
set NNval = $5
set ses = $6


set Num = `cat $Subjfn | wc -l`
# $6 determine if glueing parameter blocks is carried out

set gpdir  = $ddir/group_results
#This is the directory where the REML contrast identify ROIs
set anadir = $gpdir/test.CSPLINzero.3dMEMA_N=${Num}.$atlas.$ses.results

# tvalues at n = 98
# needs to be tuned for every set of participants
#set tval = 3.3166 # q=.05 for the group level

# p = .01 for the individual voxels within the above ROI
# t value at the highest position of the slider in afni gui
# set tval2 = 2.7079

# tvalues at n = 147
# needs to be tuned for every set of participants
#set tval = 4.1358 # q=.001 for the group level

# tvalues at n = 134, for MOCA=1, MRI=1
# needs to be tuned for every set of participants
#set tval = 4.1541 # q=.001 for the group level





## This is for extracting individual information of $condstr
# from the $maskstr ROI# such as R60, L40, 60-40, ... etc
# In this case, every subject has the SAME ROI.
# namely outcomes from the loop in glue_group_subriks.sh
# Compute statistics from significant clusters in alphasim
# q <= .05, cluster size > 40, NN = 1 (face touched)
# $anadir/${maskstr}_q001_NN1_mask+tlrc is the final output of
# create_group_clust.sh
3dROIstats -nomeanout -nzmean -nzsigma -nzvoxels -longnames \
	-mask $anadir/${atlas}_mask+tlrc \
	$anadir/"${condstr}#${cid}_Coef+tlrc" > \
	$anadir/"${condstr}#${cid}_Coef_${atlas}_ROI_atlas_info.txt"
