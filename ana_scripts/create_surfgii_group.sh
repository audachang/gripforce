#!/usr/bin/tcsh -ef
if ( $#argv != 1 ) then
        echo "usage: ./create_surf_group.sh <N of the group>"
        exit 0
endif


set in_niidir = /media/DATA2/GripForce/out/afni/subject_results/group.young/group_results/"test.CSPLIN.3dMEMA_N=$1.results"
set fs_dir = /media/DATA2/GripForce/out/freesurfer/fsaverage/surf
#set temp_gii_L = /media/DATA2/GripForce/HCP_S1200_GroupAvg_v1/S1200.L.midthickness_MSMAll.32k_fs_LR.surf.gii
#set temp_gii_R = /media/DATA2/GripForce/HCP_S1200_GroupAvg_v1/S1200.R.midthickness_MSMAll.32k_fs_LR.surf.gii

#use the surface file fitting the current resolution so that 
#wb_view can load the surf.gii and the shape.gii files together
set temp_gii_L = $fs_dir/lh.pial.surf.gii
set temp_gii_R = $fs_dir/rh.pial.surf.gii
set out_giidir = $in_niidir

echo creating $out_giidir/R-L_CSPLIN.R.shape.gii

wb_command -volume-to-surface-mapping \
	$in_niidir/R-L_CSPLIN.nii \
	$temp_gii_R \
	$out_giidir/R-L_CSPLIN.R.shape.gii \
	-trilinear

echo creating $out_giidir/R-L_CSPLIN.L.shape.gii
wb_command -volume-to-surface-mapping 			\
	$in_niidir/R-L_CSPLIN.nii 				\
	$temp_gii_L									\
	$out_giidir/R-L_CSPLIN.L.shape.gii 	\
	-trilinear	
