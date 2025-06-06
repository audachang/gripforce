#!/usr/bin/tcsh -ef

if ( $#argv != 5 ) then
	
	echo "usage: create_3dMEMA_test_agegroup.sh <model> <condition> <subfn> <sesid> <agegroup>"
	echo "example: create_3dMEMA_test.sh CSPLINzero R-L agegroups/ID_G1.txt ses-01 G1"
    echo "model: "
    echo "condstr: "
    echo "subfn: file containing list of sub-<????> to be included in the group analysis"
    echo "sesid: ses-01 or ses-02"
	exit 0
endif


cat $3 | grep "^[^#]" > tmp

set model = $1
set condstr = $2
set ses = $4
set agegroup = $5
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

set results_dir = $ddir/group_results/${agegroup}.${model}.3dMEMA_N=$nv.${condstr}.$ses.results
echo $results_dir

if ( ! -d $results_dir ) then
   mkdir $results_dir
else
   rm -R $results_dir
endif


set fn = (`cat tmp`)

uber_ttest.py -no_gui -save_script cmd.$model.MEMA.${condstr}.$ses.${agegroup}       \
	-program 3dMEMA                                 \
	-mask $mask_dset                                 \
	-set_name_A $condstr                                \
	-dsets_A $fn \
	-beta_A $beta_A -tstat_A $tstat_A                            \
	-results_dir $results_dir 

# dealing with additional commands in 3dMEMA that cannot be added with uber_ttest.py
set linecount=`wc -l cmd.$model.MEMA.${condstr}.$ses.${agegroup} | awk '{print $1}'`
@ linecount--
head -n $linecount cmd.$model.MEMA.${condstr}.$ses.${agegroup} > \
	cmd.$model.MEMA.${condstr}.tmp && \
	mv cmd.$model.MEMA.${condstr}.tmp cmd.$model.MEMA.${condstr}.$ses.${agegroup}


# add a trailing / to the end of the last line
sed -i -e '$ s/$/ \\/' cmd.$model.MEMA.${condstr}.$ses.${agegroup}

#echo '\t\t-jobs 20 \\\n\t\t-verb 1\\\n\t\t -max_zeros 0.25' >> cmd.$model.MEMA.${condstr}
echo '\t\t-jobs 20 \\\n' >> cmd.$model.MEMA.${condstr}.$ses.${agegroup}

chmod +x cmd.$model.MEMA.${condstr}.$ses.${agegroup}
