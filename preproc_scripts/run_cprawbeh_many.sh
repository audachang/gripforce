#!/usr/bin/tcsh -ef


set list2afni = `cat list2afni.txt`

foreach sid ( $list2afni)
	echo processing $sid
	./cprawbeh.sh sub-$sid


end
