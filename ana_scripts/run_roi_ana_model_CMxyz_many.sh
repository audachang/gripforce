#!/usr/bin/tcsh -ef

if ( $#argv != 6 ) then
        echo "usage: ../ana_scripts/run_roi_ana_model_CMxyz_many.sh <maskstr> <tpval01> <Subjfn> <qval> <NNval> <sesid>"
        echo "Example: ../ana_scripts/run_roi_ana_model_CMxyz_many.sh  R-L 2.6060 list_afni_subj.txt .001 1 ses-01"
        exit 0
endif



set side = (R L)
set force = (40 60)
set contrstr = $1
set Subjfn = $3
set tpval01 = $2
set qval = $4
set NNval = $5
set ses = $6

foreach s ( $side )
	foreach f ( $force )

			echo "Processing $s${f}_sel#0_Tstat..."
			../ana_scripts/roi_ana_model_CMxyz.sh $s$f $contrstr $tpval01 $Subjfn $qval $NNval $ses

	end
end






