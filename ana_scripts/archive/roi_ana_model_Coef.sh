#!/bin/tcsh -ef
if ( $#argv != 4 ) then
	echo "usage: ./roi_ana_model_Coef.sh <condstr> <maskstr>" 
	echo "	 <parameter id> <Subjfn> "
	echo "Example: ./roi_ana_model_Coef.sh R40 R-L 0 list_afni_subj.txt"
	echo condstr: the condition parameter to be extracted
	echo maskstr: the contrast forming the statistical maps to be extracted
	echo parameter id: the nth impulse response beta
	echo sample size N: number of subjects included in the analysis
	exit 0
endif

set ddir = '../out/afni/subject_results/group.young'
set scrdir = `pwd`
#set sids =  (`cat ../preproc_scripts/batch15_20210924.txt | tr -d sub-` )
#set sids =  (`cat list_afni_subj.txt` )
set Subjfn = $4
set sids =  (`cat $Subjfn` )


#echo $sids
set condstr = $1 
set maskstr = $2
set cid = $3
set Num = `cat $Subjfn | wc -l`
# $6 determine if glueing parameter blocks is carried out

set gpdir  = $ddir/group_results
#This is the directory where the REML contrast identify ROIs
set anadir = $gpdir/test.CSPLIN.3dMEMA_N=${Num}.$maskstr.results

# tvalues at n = 98
# needs to be tuned for every set of participants
set tval = 3.3166 # q=.05 for the group level

# p = .01 for the individual voxels within the above ROI 
# t value at the highest position of the slider in afni gui
set tval2 = 2.7079 


## This is for extracting individual information of $condstr
# from the $maskstr ROI# such as R60, L40, 60-40, ... etc
# In this case, every subject has the SAME ROI. 
# namely outcomes from the loop in glue_group_subriks.sh
# Compute statistics from significant clusters in alphasim
# q <= .05, cluster size > 40, NN = 1 (face touched)
# $anadir/${maskstr}_q05_NN1_mask+tlrc is the final output of 
# create_group_clust.sh
3dROIstats -nomeanout -nzmean -nzsigma -nzvoxels -longnames \
	-mask $anadir/${maskstr}_q05_NN1_mask+tlrc \
	$anadir/"${condstr}#${cid}_Coef+tlrc" > \
	$anadir/"${condstr}#${cid}_Coef_q05_ROI_info.txt"
