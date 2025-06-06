#!/usr/bin/tcsh -ef

find ../BIDS/sourcedata/sub-*/mri/ -maxdepth 1 > tmp
cat tmp | cut -d / -f 1-4 | sort | uniq -c > tmp2
awk '$1 < 5' tmp2
