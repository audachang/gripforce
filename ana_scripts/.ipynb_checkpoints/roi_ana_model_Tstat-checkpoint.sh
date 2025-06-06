#!/bin/tcsh -ef
if ( $#argv != 7 ) then
	echo "usage: ../ana_scripts/roi_ana_model_Tstat.sh <condstr> <maskstr> <tpval01> <subjfn> <qval> <NNval> <sesid>"
	echo "Example: ../ana_scripts/roi_ana_model_Tstat.sh R40 R-L 2.1633 list_afni_subj.txt"
	echo condstr: the condition parameter to be extracted
	echo maskstr: the contrast forming the statistical maps to be extracted
	echo tpval01: t value at p = .01 for the given sample of participants
    echo subjfn: subject list file
	echo qval: q-value of setting up the mask
	echo NNval: method of forming clusters
    echo sesid: which session is analyzed
    echo 
	echo updated on 2023-01-07 by EC
	echo update the individual condition Tstat voxel rule
	exit 0
endif

set ddir = '../out/afni/subject_results'
set scrdir = `pwd`
#set sids =  (`cat ../preproc_scripts/batch15_20210924.txt | tr -d sub-` )
#set sids =  (`cat list_afni_subj.txt` )


#echo $sids
set condstr = $1
set contrstr = $2
set tpval01 = $3
set Subjfn = $4
set qval = $5
set NNval = $6
set ses = $7


set sids =  (`cat $Subjfn` )
set Num = (`cat $Subjfn | wc -l` )
# $6 determine if glueing parameter blocks is carried out

set gpdir  = $ddir/group_results
#This is the directory where the REML contrast identify ROIs
set anadir = $gpdir/test.CSPLINzero.3dMEMA_N=${Num}.$contrstr.$ses.results

# tvalues at n = 98
# needs to be tuned for every set of participants
# set tval = 3.3166 # q=.05 for the group level

# tvalues at n = 147
# needs to be tuned for every set of participants
#set tval = 4.1358 # q=.001 for the group level




# From :https://afni.nimh.nih.gov/afni/community/board/read.php?1,51137,51142#msg-51142
# 3dROIstats -mask \
#   '3dcalc(-a func_slim+orig[3] -b mask+orig -expr b*ispositive(a-1.4))' \
#   func_slim+orig'[2]'
#
# Thresholding each indivdidual's voxels in the
# Tstat sub-brik within the
#  $masktr ROI  at t threshold of $tpval01
# All voxels with t value > $tpval01 will remain
# and these voxels will be within the $maskstr ROI

echo 3dcalc start

3dcalc -a $anadir/"${condstr}_sel#0_Tstat+tlrc" 			\
	-b $anadir/${contrstr}_q{$qval}_NN{$NNval}_mask+tlrc  			\
		-prefix $anadir/"${condstr}_sel#0_Tstat=$tpval01" 	\
#		-expr "ispositive(a - $tpval01)*step(b)" 	#2022-08-02     \
		-expr "ispositive(abs(a) - $tpval01)*step(b)" 		\
		-verbose -overwrite
echo 3dcalc end
# find significant voxels above threshold within each group ROI
# from the $condstr#$cid_Tstat=$tpval01 statistical map
# for each individual subjects
# and only get voxel counts
echo 3dROIstats start
3dROIstats -nzvoxels  -nomeanout -longnames \
	-mask $anadir/${contrstr}_q{$qval}_NN{$NNval}_mask+tlrc \
	$anadir/"${condstr}_sel#0_Tstat=${tpval01}+tlrc" > \
	$anadir/"${condstr}_sel#0_Tstat=${tpval01}_p01_ROI_count.txt"
echo 3dROIstats end
