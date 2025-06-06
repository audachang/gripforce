#!/bin/tcsh -ef

#list of  participants with complete functional Grip Force datasets 
find /media/DATA2/GripForce/BIDS/sourcedata/sub*/mri/B*  	\
	-maxdepth 0 -printf "%p\t%s\n"				\
	| cut -d / -f 7,9				\
	| awk '$2 > 4096' > tmp

cat tmp | awk '{print $1}' \
	| tr -d /B{_LR} | uniq -c \
	| awk '$1 == 2' | awk '{print $2}' \
	| tr -d sub-  > list_BIDS_complete.txt

cat list_BIDS_complete.txt



