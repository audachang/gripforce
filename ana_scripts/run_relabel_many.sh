#!/usr/bin/tcsh -ef

if ( $#argv != 2 ) then
        echo "usage: ../ana_scripts/run_relabel_many.sh <sublist> <sesid>"
        echo "Example: ../ana_scripts/run_relabel_many.sh list_afni_ses01.txt ses-01"
        exit 0
endif



set sids = ( `cat $1` )
set ses = $2

foreach sid ( $sids )
	echo "relabelling sub-$sid"
	../ana_scripts/relabel_CSPLINzero.sh $sid $ses

end
