#!/bin/tcsh -ef


set mri_dir = /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData/sub*/mri 


find $mri_dir  -maxdepth 1 > tmp

cat tmp | cut -d / -f8 | sort | uniq -c | awk '$1 >= 18' 

#cat tmp2 | cut -d - -f2 > tmp3

#cat tmp3 
#echo 
#cat tmp3 | wc -l






