#!/bin/tcsh

set SOURCE='/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep'
#set DESTINATION='/media/DATA3/GripForce/out/'
set DESTINATION='/home/aclexp/TCNL_Dropbox/tcnl_tcnl/fmriprep_out/'

echo $SOURCE
echo $DESTINATION

rsync -av --delete "$SOURCE" "$DESTINATION"
