#!/usr/bin/tcsh -ef

if ( $#argv != 1 ) then
        echo "usage: create_group_anat_mask.sh <subjfn>"
        exit 0
endif

set ddir = /media/DATA3/GripForce/out/fmriprep
set outdir = ../out/afni/subject_results/group_results



#find $ddir/sub-*/ses-01/anat/*MNI152NLin2009cAsym_desc-brain_mask.nii.gz
#	| grep  -v "49" > tmp

#find $ddir/sub-*/ses-01/anat/*MNI152NLin2009cAsym_desc-brain_mask.nii.gz

set sublist = `cat $1`

if -f tmp then
  rm tmp
endif


foreach sub ($sublist)
  	echo $ddir/sub-{$sub}/ses-01/anat/sub-{$sub}_ses-01_space-MNI152NLin2009cAsym_desc-brain_mask.nii.gz >> tmp
end


set nv = `cat tmp | wc -l`
set fn = ( `cat tmp` )

3dmask_tool -input $fn  \
	-prefix $outdir/N=${nv}_MNI152NLin2009cAsym_desc-brain_mask+tlrc \
	-inter -overwrite

3dcopy $outdir/N=${nv}_MNI152NLin2009cAsym_desc-brain_mask+tlrc \
   $outdir/mask_intersection_anat_up2date+tlrc \
  -overwrite
