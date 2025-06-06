#!/usr/bin/tcsh -ef

set in_niidir = /media/data1/Cereb2022/out/afni_vrot/group_results
echo $in_niidir
#set temp_gii = /media/DATA2/cerebellar_atlases-master/tpl-SUIT/tpl-SUIT.surf.gii
set temp_gii_R = /media/data1/Cereb2022/cerebmap20/surf/rh.pial.gii
set temp_gii_L = /media/data1/Cereb2022/cerebmap20/surf/lh.pial.gii
set out_giidir = $in_niidir

echo creating $out_giidir/vrot_n20_3dMEMA.cere.R.shape.gii

wb_command -volume-to-surface-mapping \
	$in_niidir/vrot_n20_3dMEMA.nii \
	${temp_gii_R} \
	$out_giidir/vrot_n20_3dMEMA.cere.R.shape.gii \
	-trilinear

echo creating $out_giidir/vrot_n20_3dMEMA.cere.L.shape.gii

wb_command -volume-to-surface-mapping \
	$in_niidir/vrot_n20_3dMEMA.nii \
	${temp_gii_L} \
	$out_giidir/vrot_n20_3dMEMA.cere.L.shape.gii \
	-trilinear
