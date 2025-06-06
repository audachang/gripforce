#!/bin/tcsh -xef

#usage: ./roi_ana.sh <condition string> <group data dir>
# example: ./roi_ana.sh R-L test.CSPLIN.3dMEMA

set ddir = '../out/afni/subject_results/group.young'
set scrdir = `pwd`
#set sids =  (`cat ../preproc_scripts/batch15_20210924.txt | tr -d sub-` )
set sids =  (`cat all_subjects.txt | tr -d sub-` )

set condstr = $1
set gp_dir = $2


if (-f $ddir/group_results/${condstr}_Coef+tlrc.HEAD) rm $ddir/group_results/${condstr}_Coef+tlrc.*

foreach subj ($sids)
	set subjdir = $ddir/subj.sub${subj}/sub${subj}.results

	set bid = `3dinfo -label2number "$condstr#0_Coef" $subjdir/stats.sub${subj}_REML+tlrc.HEAD`
	#echo $bid

        3dbucket -aglueto $ddir/group_results/${condstr}_Coef+tlrc  \
			$subjdir/stats.sub${subj}_REML+tlrc.HEAD"[$bid]" 

end


# -mask file from export_clust_mask.sh

3dROIstats -nzminmax -nzmean -nzsigma -nzvoxels \
	-mask $ddir/group_results/$gp_dir/R-L_q05_Clust_mask+tlrc \
	$ddir/group_results/${condstr}_Coef+tlrc > \
	$ddir/group_results/$gp_dir/${condstr}_Coef_ROI_q05.txt

