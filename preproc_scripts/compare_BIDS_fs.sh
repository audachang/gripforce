#!/bin/tcsh -ef


ls -a ../BIDS/sourcedata/sub-* | grep : | cut -d - -f 2 | tr -d :/ > tmp_bids


ls -a ../out/freesurfer/sub-* |grep : | cut -d - -f 2 | tr -d :/ > tmp_fs
#find /media/DATA1/Dropbox/Dropbox/Tests/3_RawData/sub-00*/mri \
#	| grep mri | cut -d - -f 2 | tr -d /mri/B_L:> tmp_dp

#echo list difference between fmriprep and BIDS folders
comm -2 -3 tmp_bids tmp_fs > list2fmriprep-anatonly.txt
cat list2fmriprep-anatonly.txt


