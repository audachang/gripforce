#!/usr/bin/tcsh -ef

if ( $#argv != 2 ) then
	echo "usage: mask_compare.sh <maksfile1> <maskfile2>"
	exit 0
endif


set maskfn1 = $1
set maskfn2 = $2

set maskpth = ../out/afni/subject_results/group_results

3dcalc -a $maskpth/$maskfn1+tlrc.BRIK.gz \
	-b $maskpth/$maskfn2+tlrc.BRIK.gz \
	-expr 'a-b' -prefix $maskpth/diff \
	-overwrite

#3dTstat -sum -prefix $maskpth/sum_diff $maskpth/diff+tlrc.BRIK.gz
# Count the number of non-zero voxels
3dBrickStat -count -non-zero $maskpth/diff+tlrc.BRIK.gz > $maskpth/diff_count.txt

echo "Number of different voxels: " `cat $maskpth/diff_count.txt`