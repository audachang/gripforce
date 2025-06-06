#!/usr/bin/tcsh -xef

set dbdir = /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData
set BIDdir = /media/DATA2/GripForce/BIDS/sourcedata
set list = `cat list_DP+BIDS-.txt`

foreach sid ( $list )
	echo -------
	echo sub-$sid
	set fstr = (BL BR B_L B_R T1 FMAP FMAP_P)

	#if (-d  $BIDdir/sub-$sid) then
	#	echo removing existing $BIDdir/sub-$sid ...
	#	rm -R $BIDdir/sub-$sid
	#endif

	if !(-d  $BIDdir/sub-$sid) then

		mkdir $BIDdir/sub-$sid
		mkdir $BIDdir/sub-$sid/mri
		chmod 777 $BIDdir/sub-$sid/mri

	endif

	foreach did ($dir2cp)
		echo "copying $dbdir/sub-$sid/mri/$did..."
		sudo cp -R $dbdir/sub-$sid/mri/$did $BIDdir/sub-$sid/mri

	end


end
