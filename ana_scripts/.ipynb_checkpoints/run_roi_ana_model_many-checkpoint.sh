#!/usr/bin/tcsh -xef

if ( $#argv != 2 ) then
        echo "usage: ./run_roi_ana_model_many.sh <maskstr> <Subjfn>" 
        echo "Example: ./run_roi_ana_model_many.sh  R-L list_afni_subj.txt"
        exit 0
endif



set side = (R L)
set force = (40 60)
set time_p = (`seq 0 1 9`)
set maskstr = $1
set Subjfn = $2

foreach s ( $side )
	foreach f ( $force )

			echo "Processing $s${f}_sel#0_Tstat..."
			./roi_ana_model_Tstat.sh $s$f $maskstr $Subjfn

		foreach tp ( $time_p )
			echo "Processing $s${f}#${tp}_Coef..."
			./roi_ana_model_Coef.sh $s$f $maskstr $tp $Subjfn
		end
	end
end
