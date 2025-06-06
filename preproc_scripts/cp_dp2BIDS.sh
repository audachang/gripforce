#!/usr/bin/tcsh -xef

set dbdir = /media/DATA1/Dropbox/Dropbox/Tests/3_RawData
set BIDdir = /media/DATA2/GripForce/BIDS/sourcedata
set list = `cat list_DP+BIDS-.txt`
set fstr = '^B|T1|FMAP$|FMAP_P|FMAP_AB|FMAP_ABP'

foreach sid ( $list )
	echo sub-$sid

	set dir2cp = `ls $dbdir/sub-$sid/mri | tr " " "\n" | grep -E $fstr`
	echo $dir2cp

	if (-d  $BIDdir/sub-$sid) then
		echo removing existing $BIDdir/sub-$sid ...
		sudo rm -R $BIDdir/sub-$sid
		mkdir $BIDdir/sub-$sid
	else
		mkdir $BIDdir/sub-$sid
		mkdir $BIDdir/sub-$sid/mri
		sudo chmod 777 $BIDdir/sub-$sid/mri

	endif

	foreach did ( $dir2cp )
		echo copying $dbdir/sub-$sid/mri/$did...
		sudo cp -R $dbdir/sub-$sid/mri/$did $BIDdir/sub-$sid/mri

	end


end
