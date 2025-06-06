#!/bin/tcsh -ef
if ( $#argv != 3 ) then
	echo "usage: ./roi_ana_model_Tstat.sh <condstr> <contrast> <maskstr> <sub_list.txt>" 
	echo "	<subjfn> "
	echo "Example: ./roi_ana_model_Tstat.sh R40 R-L 0 list_afni_subj.txt"
	echo condstr: the condition parameter to be extracted
	echo maskstr: the contrast forming the statistical maps to be extracted
	echo sample size N: number of subjects included in the analysis
	exit 0
endif

set ddir = '../out/afni/subject_results/group.young'
set scrdir = `pwd`
#set sids =  (`cat ../preproc_scripts/batch15_20210924.txt | tr -d sub-` )
#set sids =  (`cat list_afni_subj.txt` )


#echo $sids
set condstr = $1 
set maskstr = $2
set Subjfn = $3

set sids =  (`cat $Subjfn` )
set Num = (`cat $Subjfn | wc -l` )
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


# From :https://afni.nimh.nih.gov/afni/community/board/read.php?1,51137,51142#msg-51142 
# 3dROIstats -mask \
#   '3dcalc(-a func_slim+orig[3] -b mask+orig -expr b*ispositive(a-1.4))' \
#   func_slim+orig'[2]'
#
# Thresholding each indivdidual's voxels in the 
# Tstat sub-brik within the 
#  $masktr ROI  at t threshold of $tval2 
# All voxels with t value > $tval2 will remain
# and these voxels will be within the $maskstr ROI

echo 3dcalc start

3dcalc -a $anadir/"${condstr}_sel#0_Tstat+tlrc" 			\
	-b $anadir/"${maskstr}_q05_NN1_mask+tlrc"  			\
		-prefix $anadir/"${condstr}_sel#0_Tstat=$tval2" 	\
		-expr "ispositive(a - $tval2)*step(b)" 			\
		-verbose -overwrite
echo 3dcalc end
# find significant voxels above threshold within each group ROI
# from the $condstr#$cid_Tstat=$tval2 statistical map 
# for each individual subjects 
# and only get voxel counts
echo 3dROIstats start
3dROIstats -nzvoxels  -nomeanout -longnames \
	-mask $anadir/${maskstr}_q05_NN1_mask+tlrc \
	$anadir/"${condstr}_sel#0_Tstat=${tval2}+tlrc" > \
	$anadir/"${condstr}_sel#0_Tstat=${tval2}_p01_ROI_count.txt"
echo 3dROIstats end
