#!/usr/bin/tcsh -ef

if ( $#argv != 3 ) then
	echo "usage: create_3dMEMA_test_sub.sh <model> <condition> <subfn>"
	exit 0
endif


cat $3 | grep "^[^#]" > tmp

set model = $1
set condstr = $2
set sublist = (`cat tmp`)
set ddir = ../out/afni/subject_results


#find $ddir/subj.sub*/sub*.{$1}.results/stats.sub*.{$1}_REML+tlrc.HEAD |\
#	grep -v "49" > tmp

rm tmp
foreach sub ($sublist)
  	echo $ddir/subj.sub{$sub}/sub{$sub}.{$1}.results/stats.sub{$sub}.{$1}_REML+tlrc.HEAD >> tmp
end


set nv = (`cat tmp | wc -l`)

set mask_dset = $ddir/group_results/mask.anat.up2date+tlrc
set beta_A = `3dinfo -label2index "${condstr}#0_Coef" $ddir/subj.sub0001/sub0001.$1.results/stats.sub0001.{$1}_REML+tlrc.HEAD`
set tstat_A = `3dinfo -label2index "${condstr}#0_Tstat" $ddir/subj.sub0001/sub0001.$1.results/stats.sub0001.{$1}_REML+tlrc.HEAD`

echo $beta_A $tstat_A

set results_dir = $ddir/group_results/subset.${model}.3dMEMA_N=$nv.${condstr}.results

if ( ! -d $results_dir ) then
   mkdir $results_dir
else
   rm -R $results_dir
endif


set fn = (`cat tmp`)

uber_ttest.py -no_gui -save_script cmd.$model.MEMA.${condstr}       \
	-program 3dMEMA                                 \
	-mask $mask_dset                                 \
	-set_name_A $condstr                                \
# 	-dsets_A $ddir/subj.sub*/sub*.{$1}.results/stats.sub*.{$1}_REML+tlrc.HEAD                            \
	-dsets_A $fn \
	-beta_A $beta_A -tstat_A $tstat_A                            \
	-results_dir $results_dir
