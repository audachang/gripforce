#!/bin/tcsh -ef



#set sids = (1 2 5 9 11 12 15 16 17 18 19 21 22 23 24 25 26 29 31 56)
set sids = (9 12 15 16 17 18 19 22 23 24 25 26 29 31 56)

set condstr = $1


foreach s ($sids)
	set ss = (`printf "%04d" $s`)
	echo processing "sub-$ss"....
	./form_clust.sh $ss $1 $2

end
