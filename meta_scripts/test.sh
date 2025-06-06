#!/bin/tcsh

set SOURCE='/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep'
set DESTINATION='/media/DATA3/GripForce/out/fmriprep/'

ls $SOURCE
ls $DESTINATION

while (1)
    inotifywait -r -e modify,create,delete,move "$SOURCE"
    rsync -av --delete "$SOURCE" "$DESTINATION"
end
