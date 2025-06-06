#!/bin/tcsh -ef


set mri_dir = /media/DATA2/GripForce/BIDS/sourcedata/sub*/mri 


find $mri_dir  -maxdepth 1 > tmp

cat tmp | cut -d / -f7 | sort | uniq -c | awk '$1 >= 5'






