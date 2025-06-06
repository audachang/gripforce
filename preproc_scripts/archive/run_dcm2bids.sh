#!/usr/bin/tcsh -ef

set curdir = `pwd`
#set dpdir = /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData

cd ../BIDS

if (-d ../BIDS/tmp_dcm2bids) then
	rm -R ../BIDS/tmp_dcm2bids
endif


dcm2bids -d ../BIDS/sourcedata/$1 -p $1 -s 01 \
#dcm2bids -d $dpdir/$1 -p $1 -s 01 \
    -c ../codes/dcm2bids_config.json \
	--forceDcm2niix --clobber \
	-l DEBUG 

cd $curdir

#dcm2bids_config -"intendedFor": 0- writes the reference file path without session number #67
#https://githubmemory.com/repo/UNFmontreal/Dcm2Bids/issues/67
#https://github.com/UNFmontreal/Dcm2Bids/issues/58
