#!/usr/bin/tcsh -xef

set fpdir = /media/DATA1n/tcnl@ncyu/Public/backup/tcnl/tcnl@NYCU_120.126.40.76/fmriprep/fmriprep/out/fmriprep
set curdir = /media/DATA2/GripForce/out/fmriprep
set list = `cat list_DP+fmriprep-.txt`

set key2exclude = ( wordpic wordname MST speechcomp rest) 

foreach sid ( $list )
	echo sub-$sid
	set dir2cp = $fpdir/sub-$sid
	cp -R $dir2cp $curdir/
	foreach kid ( $key2exclude )
		echo ====
		# $curdir/sub-$sid/ses-01/func/*$kid*
		rm $curdir/sub-$sid/ses-01/func/*$kid*
		echo ====
	end 

end
