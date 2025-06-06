#!/usr/bin/tcsh -xef

if ( $#argv != 3 ) then
        echo "usage: ../ana_scripts/run_glue_Tstat_briks.sh <maskstr> <Subjfn> <sesid>"
        echo "Example: ../ana_scripts/run_glue_Tstat_briks.sh R-L list_afni_subj.txt ses-01"
        exit 0
endif



set side = (R L)
set force = (40 60)
#set time_p = (`seq 0 1 9`)
set maskstr = $1
set Subjfn = $2
set ses = $3
set NrSubj = `cat $Subjfn | wc -l`




foreach s ( $side )
	foreach f ( $force )
		echo "Processing $s${f}_sel#0_Tstat..."
		../ana_scripts/glue_Tstat_briks.sh $s$f $maskstr $Subjfn $ses
	end
end
