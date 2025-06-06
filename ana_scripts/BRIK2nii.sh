#!/usr/bin/tcsh -ef

if ( $#argv != 3 ) then
	echo "usage: BRIK2nii.sh <model> <subject number> <contr>"
	echo "Example: BRIK2nii.sh CSPLINzero 254 R-L"
	exit 0
endif



set rdir = ../out/afni/subject_results/group_results/
set model = $1
set sn = $2
set contr = $3

set ddir = $rdir/test.$model.3dMEMA_N=$sn.$contr.results

3dAFNItoNIFTI -prefix $ddir/stats.mema \
	-float \
	$ddir/stats.mema+tlrc