#!/bin/tcsh -ef

set fsdir = /media/DATA2/GripForce/out/freesurfer
set sid = $1
set suma_dir  = $fsdir/sub-`printf "%04d" $sid`/surf/SUMA


if !(-d $suma_dir ) then
	#echo $suma_dir
	echo "there is no $suma_dir "

endif