#!/usr/bin/tcsh -ef

set gpdir = ../out/afni/subject_results/group.young
set sid = $1 
set ddir = $gpdir/subj.sub$sid/sub$sid.CSPLIN.results
set fn = $ddir/stats.sub$sid.CSPLIN_REML+tlrc


3dinfo -label $fn | sed -e "s/|/\n/g" |\
	grep "Tstat"
