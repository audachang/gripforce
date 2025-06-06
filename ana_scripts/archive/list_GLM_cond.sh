#!/usr/bin/tcsh -ef

if ( $#argv != 1 ) then
	echo "usage: list_GLM_cond.sh <model>"
	exit 0
endif

set model = $1
set ddir = /media/DATA2/GripForce/out/afni/subject_results/group.young



set label = `3dinfo -label \
	$ddir/subj.sub0001/sub0001.$1.results/stats.sub0001.{$1}_REML+tlrc.HEAD`

echo $label


