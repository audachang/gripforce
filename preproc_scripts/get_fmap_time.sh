#!/usr/bin/tcsh -ef

find /media/DATA1/Dropbox/Dropbox/Tests/3_RawData/sub-*/mri/ \
	-maxdepth 1 -regex ".*FMAP.*" -printf "%p %AX\n"


