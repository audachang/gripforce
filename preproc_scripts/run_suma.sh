#!/bin/tcsh -ef

set subid = sub$1
set subid2 = sub-$1
set outdir = /media/DATA2/GripForce/out/afni/subject_results/group.young
set curdir = `pwd`

set subdir = $outdir/subj.$subid/$subid.suma.results

cd $subdir

afni -niml 
	{$subid2}_ses-01_space-MNI152NLin2009cAsym_dsec-preproc_T1w & 
suma -spec $fs_data/$subid2/surf/SUMA/std.141.{$subid2}_both.spec \
	-sv {$subid2}_SurfVol+orig.HEAD \
	-input stats.$subid.suma.?h.niml.dset 


cd $curdir