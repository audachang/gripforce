#!/bin/tcsh -ef
if ( $#argv != 2 ) then
	echo "usage: ./roi_ana_model.sh <condition string> <group data dir>"
	exit 0
endif
# example: ./roi_ana_model.sh R-L test.CSPLIN.3dMEMA

set ddir = '../out/afni/subject_results/group.young'
set scrdir = `pwd`
#set sids =  (`cat ../preproc_scripts/batch15_20210924.txt | tr -d sub-` )
set sids =  (`cat ../preproc_scripts/list_afni_subj.txt` )


set condstr = $1
set paramstr = $2
set gp_dir = $3


#flag to turn on the glue of parameters
if ( $4 == 1) then

#if (-f $ddir/group_results/${condstr}_${paramstr}+tlrc.HEAD) rm $ddir/group_results/${condstr}_${paramstr}+tlrc.*

foreach subj ($sids)

	set subjdir = $ddir/subj.sub${subj}/sub${subj}.CSPLIN.results

	set bid = `3dinfo -label2number "$condstr#0_${paramstr}" $subjdir/stats.sub${subj}.CSPLIN_REML+tlrc.HEAD`
	echo $bid

    3dbucket -aglueto $ddir/group_results/${condstr}_${paramstr}+tlrc  \
			$subjdir/stats.sub${subj}.CSPLIN_REML+tlrc.HEAD"[$bid]" 
		
end
endif


# -mask file from export_clust_mask.sh

3dROIstats -nzminmax -nzmean -nzsigma -nzvoxels \
	-mask $ddir/group_results/Clust_3dMEMA_R-L_CSPLIN_q05_mask+tlrc \
	$ddir/group_results/${condstr}_${paramstr}+tlrc > \
	$ddir/group_results/$gp_dir/${condstr}_CSPLIN_${paramstr}_ROI_q05.txt

3dcalc -a $ddir/group_results/${condstr}_${paramstr}+tlrc \
		-prefix $ddir/group_results/${condstr}_${paramstr}_thresholded \
		-expr "astep(a,3.3184)" -overwrite

3dROIstats -nzvoxels \
	-mask $ddir/group_results/Clust_3dMEMA_R-L_CSPLIN_q05_mask+tlrc \
	$ddir/group_results/${condstr}_${paramstr}_thresholded+tlrc > \
	$ddir/group_results/$gp_dir/${condstr}_CSPLIN_${paramstr}_ROI_p001_count.txt
