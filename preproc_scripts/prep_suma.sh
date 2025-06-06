#!/bin/tcsh -xef

#2021-08-20 redone @SUMA_Make_Spec_FS with the -NIFTI command
# also remove the sufVol_Alnd_Exp+orig files and the 
# *ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w_shft_resamp_+orig.HEAD
# otherwise there will be SurfSmooth error with the following:
# https://afni.nimh.nih.gov/afni/community/board/read.php?1,146445,146445#msg-146445

set subid = sub-$1
set subid2 = sub$1
set curdir = `pwd`

set suma_make_spec = $2
set afnidir = /media/DATA2/GripForce/out/afni/subject_results/group.young/subj.$subid2/$subid2.results
set fsdir = /media/DATA2/GripForce/out/freesurfer/$subid/surf
set sumafn = $fsdir/SUMA/{$subid}_SurfVol.nii
set anatsuffix  = ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc

if ( $suma_make_spec == 1) then

	@SUMA_Make_Spec_FS -NIFTI \
		-sid $subid \
		-fspath $fsdir \
		-inflate 100 \
		-inflate 200 \
		-inflate 400 


endif


cd $afnidir
if (-f {$subid}_SurfVol_Alnd_Exp+orig.HEAD) then
	rm {$subid}_SurfVol_Alnd_Exp+orig.*
endif

if (-f {$subid}_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w_shft_resamp_+orig.HEAD) then
	rm {$subid}_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w_shft_resamp_+orig.*
endif



@SUMA_AlignToExperiment \
	-exp_anat {$subid}_$anatsuffix \
	-surf_anat  $sumafn \
	-align_centers \
	-overwrite_resp O 


cd $curdir
