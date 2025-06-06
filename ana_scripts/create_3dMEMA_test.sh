#!/usr/bin/tcsh -ef

#
# Originally this script generated a 3dMEMA command for group analysis.
# It has been updated to perform the group test with 3dttest++
# and to run ETAC/Clustsim for cluster thresholding.
#
if ( $#argv != 4 ) then

        echo "usage: create_3dMEMA_test.sh <model> <condition> <subfn> <sesid>"
        echo "example: create_3dMEMA_test.sh CSPLINzero R-L  list_afni_subj.txt ses-01"
    echo "model: "
    echo "condstr: "
    echo "subfn: file containing list of subjects to include in group analysis"
    echo "sesid: ses-01 or ses-02"
        exit 0
endif


cat $3 | grep "^[^#]" > tmp

set model = $1
set condstr = $2
set ses = $4
set sublist = (`cat tmp`)
set ddir = ../out/afni/subject_results


#find $ddir/subj.sub*/sub*.{$1}.results/stats.sub*.{$1}_REML+tlrc.HEAD |\
#	grep -v "49" > tmp

rm tmp
foreach sub ($sublist)
  	echo $ddir/subj.sub{$sub}/$ses/sub{$sub}.{$1}.results/stats.sub{$sub}.{$1}_REML+tlrc.HEAD >> tmp
end


set nv = (`cat tmp | wc -l`)

set mask_dset = $ddir/group_results/mask_intersection_func_up2date+tlrc
set beta_A = `3dinfo -label2index "${condstr}#0_Coef" $ddir/subj.sub0001/$ses/sub0001.$1.results/stats.sub0001.{$1}_REML+tlrc.HEAD`
set tstat_A = `3dinfo -label2index "${condstr}#0_Tstat" $ddir/subj.sub0001/$ses/sub0001.$1.results/stats.sub0001.{$1}_REML+tlrc.HEAD`

echo $beta_A $tstat_A

set results_dir = $ddir/group_results/test.${model}.3dttest++_N=$nv.${condstr}.$ses.results
echo $results_dir

if ( ! -d $results_dir ) then
   mkdir $results_dir
else
   rm -R $results_dir
endif



set fn = (`cat tmp`)

# Build list of datasets including the beta sub-brick used for testing
set dsets_A = ()
foreach d ($fn)
    set dsets_A = ( $dsets_A "$d[$beta_A]" )
end

# Run group analysis with 3dttest++ and perform ETAC/Clustsim
3dttest++ -prefix $results_dir/stats.ttest++ \
          -mask $mask_dset \
          -setA $condstr $dsets_A \
          -ETAC \
          -Clustsim

