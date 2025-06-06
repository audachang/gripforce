#!/usr/bin/tcsh -ef


set sids = ( `cat $1` )


foreach sid ( $sids )
	echo "relabelling sub-$sid"
	./relabel.sh $sid

end
