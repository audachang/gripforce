#!/bin/tcsh -ef
if ( $#argv != 4 ) then
	echo "usage: ../ana_scripts/glue_Tstat_briks.sh <condstr> <maskstr> <subjfn> <sesid>"
	echo "Example: ../ana_scripts/glue_Tstat_briks.sh R40 R-L 0 list_young40.txt ses-01"
	echo condstr: the condition parameter to be extracted
	echo maskstr: the contrast forming the statistical maps to be extracted
	echo sample size N: number of subjects included in the analysis
    echo sesid: stats file from which session are glued
	exit 0
endif

set ddir = '../out/afni/subject_results'
set scrdir = `pwd`
#set sids =  (`cat list_afni_subj.txt` )


#echo $sids
set condstr = $1
set maskstr = $2
set subjfn = $3
set ses = $4
set sids = (`cat $subjfn`)
set Num = `cat $subjfn | wc -l`
# $6 determine if glueing parameter blocks is carried out

set gpdir  = $ddir/group_results
#This is the directory where the REML contrast identify ROIs
set anadir = $gpdir/test.CSPLINzero.3dMEMA_N=${Num}.$maskstr.$ses.results

# tvalues at n = 98
# needs to be tuned for every set of participants
# set tval = 3.3166 # q=.05 for the group level

# tvalues at n = 147
# needs to be tuned for every set of participants
#set tval = $4 # q=.001 for the group level


#flag to turn on the glue of parameters
echo
echo "remove $anadir/${condstr}#0_Tstat+tlrc.* if it exists"
echo

if (-f $anadir/"${condstr}#0_Tstat+tlrc.HEAD") then
	echo removing files...
	rm "$anadir/${condstr}#0_Tstat+tlrc.*"
endif

@ id = 0
@ inc = 1

echo
echo "looping through all $Num subjects"
echo
# gather the <parameter> block from individual subjects
#  into  one file
foreach subj ($sids)

	set subjdir = $ddir/subj.sub${subj}/$ses/sub${subj}.CSPLINzero.results
	#get the index  of the parameter block
	set bid = `3dinfo -verbal -label2number \
			"${condstr}_sel#0_Tstat" \
			$subjdir/tmp+tlrc.HEAD`
	echo "subject = $subj, block ID = $bid"

	3dbucket -aglueto $anadir/"${condstr}_sel#0_Tstat+tlrc"  \
			$subjdir/tmp+tlrc.HEAD"[$bid]"

	3drefit -sublabel $id ${subj} \
			$anadir/"${condstr}_sel#0_Tstat+tlrc"


	@ id = $id + $inc

end
