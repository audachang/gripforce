#!/usr/bin/tcsh -ef

if ( $#argv != 2 ) then
        echo "usage: create_group_func_mask.sh <model> <subjfn>"
        echo Creating functional mask out of currently available full_mask.sub*+tlrc.HEAD
        exit 0
endif

set model = $1

set ddir = ../out/afni/subject_results

#find $ddir/subj.*/sub*.${model}.results/full_mask.sub*.CSPLIN+tlrc.HEAD \
# | grep  -v "49" > tmp

#find $ddir/subj.*/sub*.${model}.results/full_mask.sub*.CSPLIN+tlrc.HEAD > tmp

set sublist = `cat $2`


if -f tmp then
  rm tmp
endif

foreach sub ($sublist)
  	#echo $ddir/sub-{$s}/ses-01/anat/sub-{$sub}_ses-01_space-MNI152NLin2009cAsym_desc-brain_mask.nii.gz >> tmp
    echo $ddir/subj.sub{$sub}/ses-01/sub{$sub}.${model}.results/full_mask.sub{$sub}.CSPLINzero+tlrc.HEAD >> tmp
end


set fn = (`cat tmp`)
set nv = (`cat tmp | wc -l`)
echo $fn
#3dmask_tool -input $ddir/subj.*/sub*.${model}.results/full*.HEAD \
3dmask_tool -input $fn \
	-prefix $ddir/group_results/mask_intersection_n${nv}+tlrc \
	-inter -overwrite
3dcopy $ddir/group_results/mask_intersection_n${nv}+tlrc \
	 $ddir/group_results/mask_intersection_func_up2date+tlrc \
	-overwrite
