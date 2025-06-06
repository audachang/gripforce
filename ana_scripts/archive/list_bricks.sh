#!/usr/bin/tcsh -ef

set gpdir = ../out/afni/subject_results/group.young
set sid = $1 
set ddir = $gpdir/subj.sub$sid/sub$sid.CSPLIN.results
set gpstatsdir = $gpdir/group_results/"test.CSPLIN.3dMEMA_N=80.results"


if ($sid == "gp") then

	set fn = $gpstatsdir/stats.mema+tlrc  
else
	set fn = $ddir/stats.sub$sid.CSPLIN_REML+tlrc
endif

echo BRIK list of $fn ":"
echo

3dinfo -label $fn | sed -e "s/|/\n/g" 

echo 
