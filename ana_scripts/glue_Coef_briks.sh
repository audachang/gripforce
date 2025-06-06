#!/bin/tcsh -ef
if ( $#argv != 5 ) then
	echo "usage: ./glue_Coef_briks.sh <condstr> <contrstr> <parameterid> <subjfn> <sesid> "
	echo "Example: ./glue_Coef_briks.sh R40 R-L 0 list_afni_ses02.txt ses-02"
	echo condstr: the condition parameter to be extracted
	echo contrstr: the contrast forming the statistical maps to be extracted
	echo parameter id: the nth impulse response beta
	echo subjfn: subject list file
    echo sesid: the session ID (ses-01 or ses-02)
	#echo sample size N: number of subjects included in the analysis
	exit 0
endif

set ddir = '../out/afni/subject_results'
set scrdir = `pwd`
set subjfn = $4
#set sids =  (`cat ../preproc_scripts/batch15_20210924.txt | tr -d sub-` )
set sids =  (`cat $subjfn` )


#echo $sids
set condstr = $1
set contrstr = $2
set cid = $3
set ses = $5

set Num = `cat $subjfn | wc -l`
# $6 determine if glueing parameter blocks is carried out

set gpdir  = $ddir/group_results
#This is the directory where the REML contrast identify ROIs
set anadir = $gpdir/test.CSPLINzero.3dMEMA_N=${Num}.$contrstr.$ses.results

# tvalues at n = 147
# needs to be tuned for every set of participants
# set tval = $5 # q=.001 for the group level

#flag to turn on the glue of parameters
echo
echo "remove $anadir/${condstr}\#${cid}_Coef+tlrc.* if it exists"
echo

if (-f $anadir/"${condstr}#${cid}_Coef+tlrc.HEAD") then
	echo removing files...
	rm $anadir/${condstr}\#${cid}_Coef+tlrc.*
endif

@ id = 0
@ inc = 1

echo
echo "looping through all $Num subjects"
echo
# gather the <parameter> block from individual subjects
#  into  one file

#			$subjdir/stats.sub${subj}.CSPLIN_REML+tlrc.HEAD`
#			$subjdir/stats.sub${subj}.CSPLIN_REML+tlrc.HEAD"[$bid]" \


foreach subj ($sids)

	set subjdir = $ddir/subj.sub${subj}/$ses/sub${subj}.CSPLINzero.results
	echo "Processing $subjdir ..."
	#get the index  of the parameter block
	set bid = `3dinfo -verbal \
		-label2number "${condstr}#${cid}_Coef" \
		$subjdir/tmp+tlrc.HEAD`
	
	echo "subject = $subj, block ID = $bid"

	3dbucket -aglueto $anadir/"${condstr}#${cid}_Coef+tlrc"  \
			$subjdir/tmp+tlrc.HEAD"[$bid]"

	3drefit -sublabel $id ${subj} \
			$anadir/"${condstr}#${cid}_Coef+tlrc"


	@ id = $id + $inc

end

