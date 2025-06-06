#!/bin/tcsh -xef

set sid = $1
set L_suf = $2
set R_suf = $3

set dropboxdir = /home/aclexp/TCNL_Dropbox/tcnl_tcnl
#echo $dropboxdir

# change bdir to a new directory due to re-connections to Dropbox; 20231006;
# original: /media/DATA1n/Dropbox/Dropbox/Tests/Motor/Grip_force_fMRI/data
set rawbehdir = ${dropboxdir}/Tests/Motor/Grip_force_fMRI/data

echo "I am here"


#ls "$rawbehdir"
echo "$rawbehdir"

set behdir = /media/DATA3/GripForce/beh/rawbeh


echo $sid $L_suf $R_suf
#echo $rawbehdir/sub-{$sid}_ses-01_task-GFORCE_run-{$L_suf}.csv 
cp  $rawbehdir/sub-{$sid}_ses-01_task-GFORCE_run-{$L_suf}.csv \
	$behdir
cp  "$rawbehdir"/sub-{$sid}_ses-01_task-GFORCE_run-{$R_suf}.csv \
	$behdir


ls -l $behdir/sub-{$sid}_ses-01_task-GFORCE_run-{$L_suf}.csv
ls -l $behdir/sub-{$sid}_ses-01_task-GFORCE_run-{$R_suf}.csv
