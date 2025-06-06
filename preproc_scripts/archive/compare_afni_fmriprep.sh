#!/bin/tcsh -ef


ls -a ../BIDS/sourcedata/sub-* | grep : | cut -d - -f 2 | tr -d :/ > tmp_ana


ls -a ../out/fmriprep/sub-* |grep : | cut -d - -f 2 | tr -d :/ > tmp_fp
#find /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData/sub-00*/mri \
#	| grep mri | cut -d - -f 2 | tr -d /mri/B_L:> tmp_dp

echo list difference between fmriprep and BIDS folders
comm -2 -3 tmp_ana tmp_fp


