#!/usr/bin/tcsh -xef

if ( $#argv != 3 ) then
        echo "usage: ./run_glue_Coef_briks.sh <contrstr> <Subjfn> <sesid>"
        echo "Example: ./run_glue_Coef_briks.sh R-L list_afni_subj.txt ses-01"
	echo "maskstr: "
	echo "Subjfn: participant lists"
	#echo "tval: t-values for the designated number of participants"
    echo "sesid: session ID (ses-01 or ses-02)"
        exit 0
endif



set side = (R L)
set force = (40 60)
# time_p can only be between [0, 7] for CSPLINzero
set time_p = (`seq 0 1 7`)
set contrstr = $1
set Subjfn =  $2
set ses = $3

foreach s ( $side )
	foreach f ( $force )
		foreach tp ( $time_p )
			echo "Processing $s${f}#${tp}_Coef..."
			# del tval on 20240611 original ../ana_scripts/glue_Coef_briks.sh $s$f $maskstr $tp $Subjfn $tval
   			#../ana_scripts/glue_Coef_briks.sh $s$f $maskstr $tp $Subjfn $ses
             ../ana_scripts/glue_Coef_briks.sh $s$f $contrstr $tp $Subjfn $ses
		end
	end
end
