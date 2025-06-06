#!/bin/tcsh -ef


ls -a ../out/fmriprep/sub-* | grep : | cut -d - -f 2 | tr -d :/ > tmp_fmriprep


find /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData/sub*/mri      \
        -maxdepth 1                                             \
        | grep mri | cut -d / -f 8,10                           \
        | grep '/B.*L$' | cut -d / -f 1 | tr -d sub- > tmp_DP

#find /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData/sub-00*/mri \
#	| grep mri | cut -d - -f 2 | tr -d /mri/B_L:> tmp_dp

echo list subject with dropbox but no fmriprep folders

comm -2 -3  tmp_DP tmp_fmriprep > list_DP+fmriprep-.txt

cat list_DP+fmriprep-.txt


