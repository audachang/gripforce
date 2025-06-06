#!/usr/bin/tcsh -ef
# for merging the T1 of all participants with designated statistical analysis
# 2024-03-04 EC
# We will just use the ses-01 T1 for averaging

if ( $#argv != 2 ) then
        echo "usage: create_avg_T1.sh <model> <subjfn>"
        echo Creating average T1 out of currently available sub-????_ses-01_space-MNI152NLin2009cAsym*>
        exit 0
endif



set ddir = ../out/afni/subject_results
set model = $1

#find $ddir/subj.*/sub*.$1.results/sub-????_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc.HEAD \
# | grep  -v "49" > tmp

#find $ddir/subj.*/sub*.$1.results/sub-????_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc.HEAD > tmp

set sublist = `cat $2`

if -f tmp then
  rm tmp
endif
  
foreach sid ($sublist)
  	#echo $ddir/sub-{$s}/ses-01/anat/sub-{$sub}_ses-01_space-MNI152NLin2009cAsym_desc-brain_mask.nii.gz >> tmp
    echo $ddir/subj.sub{$sid}/ses-01/sub{$sid}.${model}.results/sub-{$sid}_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc.HEAD >> tmp
    
end


set fn = (`cat tmp`)
set nv = (`cat tmp | wc -l`)

3dmerge -prefix $ddir/group_results/ave_T1_n$nv -1blur_fwhm 3 \
	-overwrite \
	$fn
3dcopy -overwrite $ddir/group_results/ave_T1_n$nv $ddir/group_results/ave_T1_up2date

echo $fn, $nv
