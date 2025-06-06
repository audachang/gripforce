#!/bin/tcsh -ef



#where fmriprep has two functional runs
set fpdir = /media/DATA1n/tcnl@ncyu/Public/backup/tcnl/tcnl@NYCU_120.126.40.76/fmriprep/fmriprep/out/fmriprep

find $fpdir/sub-*/ses-01/func/*task-GFORCE*bold.nii.gz |\
	 cut -d / -f 16 |\
	 cut -d _ -f 1  > tmp_fp

set eventdir = ../beh/events

find $eventdir/*events.tsv \
	-maxdepth 1 | cut -d / -f 4 | \
	cut -d _ -f 1 > tmp_events

echo list subjects with fmriprep but no event files
comm -3 tmp_fp tmp_events | tr -d sub- | uniq > list_fp+_events-.txt
cat list_fp+_events-.txt

