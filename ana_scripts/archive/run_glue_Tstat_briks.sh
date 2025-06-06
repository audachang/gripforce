#!/usr/bin/tcsh -xef

if ( $#argv != 2 ) then
        echo "usage: ./run_glue_Tstat_briks.sh <maskstr> <Subjfn>" 
        echo "Example: ./run_glue_Tstat_briks.sh R-L list_afni_subj.txt"
        exit 0
endif



set side = (R L)
set force = (40 60)
#set time_p = (`seq 0 1 9`)
set maskstr = $1
set Subjfn = $2
set NrSubj = `cat $Subjfn | wc -l`

foreach s ( $side )
	foreach f ( $force )
		echo "Processing $s${f}_sel#0_Tstat..."
		./glue_Tstat_briks.sh $s$f $maskstr $Subjfn
	end
end
