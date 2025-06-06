#!/bin/tcsh -ef


#ls -a ../BIDS/sourcedata/sub-* | grep : | cut -d - -f 2 | tr -d :/ > tmp_BIDS
./list_BIDS2.sh | cut -d - -f 2 > tmp_BIDS

./list_dropbox2.sh | cut -d - -f 2 > tmp_DP

#find /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData/sub-00*/mri \
#	| grep mri | cut -d - -f 2 | tr -d /mri/B_L:> tmp_dp

echo list subject with Dropbox but not BIDS folders
comm -2 -3 tmp_DP tmp_BIDS > list_DP+BIDS-.txt

cat list_DP+BIDS-.txt



