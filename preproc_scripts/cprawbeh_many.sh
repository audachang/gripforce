#!/bin/tcsh -xvef

set sidlistfn = $1




foreach args ( `cat $sidlistfn` )

	set args2 = `echo $args |  sed "s/,/ /g"`

	echo $args2

	../preproc_scripts/cprawbeh.sh $args2


end

