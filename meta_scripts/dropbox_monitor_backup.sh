#!/bin/tcsh

set SOURCE='/home/aclexp/TCNL Dropbox/tcnl tcnl/fmriprep_out/fmriprep'
set DESTINATION='/media/DATA3/GripForce/out'

echo $SOURCE
echo $DESTINATION

while (1)
    inotifywait -r -e modify,create,delete,move "$SOURCE"
    rsync -av "$SOURCE" "$DESTINATION"
end
