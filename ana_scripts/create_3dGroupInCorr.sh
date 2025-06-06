#!/usr/bin/tcsh -ef

if ( $#argv != 1 ) then
	echo "usage: create_3dGroupInCorr.sh <model> "
	exit 0
endif

set model = $1
set ddir = /media/DATA2/GripForce/out/afni/subject_results/group.young


#find $ddir/subj.sub*/sub*.{$1}.results/errts.sub*.{$1}_REML+tlrc.HEAD |\
#	grep -v "49" > tmp
find $ddir/subj.sub*/sub*.{$1}.results/fitts.sub*.{$1}_REML+tlrc.HEAD > tmp


set nv = (`cat tmp | wc -l`)
set fns = (`cat tmp`)
set ggg = ( )

foreach fn ( $fns )
	set ggg = ( $ggg $fn )
end

3dSetupGroupInCorr -mask $ddir/group_results/mask_intersection_n${nv}+tlrc.HEAD  \
		  -prefix $ddir/group_results/GPcorr_fitts_${nv} $ggg

