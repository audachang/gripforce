#!/usr/bin/tcsh -xvef

if ( $#argv != 5 ) then
        echo "usage: ../ana_scripts/run_roi_ana_model_atlas_many.sh <atlas> <tpval01> <Subjfn> <NNval> <sesid>"
        echo "Example: ../ana_scripts/run_roi_ana_model_atlas_many.sh  FS.MNI2009c_asym 2.6060 list_afni_ses-01.txt 1 ses-01"
        exit 0
endif



set side = (R L)
set force = (40 60)
set time_p = (`seq 0 1 7`)
set atlas = $1
set tpval01 = $2
set Subjfn = $3
set NNval = $4
set ses = $5

foreach s ( $side )
	foreach f ( $force )

			echo "Processing $s${f}_sel#0_Tstat..."
			../ana_scripts/roi_ana_model_Tstat_atlas.sh $s$f $atlas $tpval01 $Subjfn $NNval $ses

            foreach tp ( $time_p )
            echo "Processing $s${f}#${tp}_Coef..."
            ../ana_scripts/roi_ana_model_Coef_atlas.sh $s$f $atlas $tp $Subjfn $NNval $ses
        end
	end
end






