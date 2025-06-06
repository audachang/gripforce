#!/usr/bin/tcsh -ef

set listfn = $1
set list = `cat $listfn`

foreach sid ( $list)

	./run_dcm2bids.sh sub-$sid


end
