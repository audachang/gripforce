#!/bin/tcsh -ef


ls -a ../BIDS/sourcedata/sub-* | grep : | cut -d - -f 2 | tr -d :/ > tmp_bids


ls -a ../out/fmriprep/sub-* |grep : | cut -d - -f 2 | tr -d :/ > tmp_fp
#find /media/DATA1/Dropbox/Dropbox/Tests/3_RawData/sub-00*/mri \
#	| grep mri | cut -d - -f 2 | tr -d /mri/B_L:> tmp_dp

echo list difference between fmriprep and BIDS folders
comm -2 -3 tmp_bids tmp_fp > list2fmriprep.txt
cat list2fmriprep.txt


