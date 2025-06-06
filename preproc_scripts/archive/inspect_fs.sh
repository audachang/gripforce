#!/bin/tcsh -xef

#https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/OutputData_freeview
set ddir = '../out/afni/subject_results/group.young'
set subid = sub-$1
set subid2 = sub$1

set good_output = /media/DATA2/GripForce/out/freesurfer/$subid


freeview -f  $good_output/surf/lh.pial:annot=aparc.annot:name=pial_aparc:visible=0 \
	$good_output/surf/lh.pial:annot=aparc.a2009s.annot:name=pial_aparc_des:visible=0 \
	$good_output/surf/lh.inflated:overlay=lh.thickness:overlay_threshold=0.1,3::name=inflated_thickness:visible=0 \
	$good_output/surf/lh.inflated:visible=0 \
	$good_output/surf/lh.white:visible=0 \
	$good_output/surf/lh.pial \
	--viewport 3d