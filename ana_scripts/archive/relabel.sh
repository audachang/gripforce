#!/bin/tcsh -ef

set ddir = '../out/afni/subject_results'

set sid = $1

set sdir = $ddir/subj.sub$sid/sub$sid.CSPLIN.results

set tarfn = stats.sub$sid.CSPLIN_REML+tlrc

3dcopy -overwrite $sdir/$tarfn $sdir/tmp

3dinfo  -label $sdir/tmp+tlrc.HEAD | tr '|' '\n' | nl


3drefit -sublabel 100 "L60_sel#0_Coef" 	\
	-sublabel 101 "L60_sel#0_Tstat"	\
	-sublabel 102 L60_sel_Fstat 	\
	-sublabel 103 "R60_sel#0_Coef" 	\
   	-sublabel 104 "R60_sel#0_Tstat"	\
   	-sublabel 105 R60_sel_Fstat	\
   	-sublabel 106 "L40_sel#0_Coef"	\
  	-sublabel 107 "L40_sel#0_Tstat"	\
   	-sublabel 108 L40_sel_Fstat	\
	-sublabel 109 "R40_sel#0_Coef"	\
	-sublabel 110 "R40_sel#0_Tstat"	\
	-sublabel 111 R40_sel_Fstat 	\
	$sdir/tmp+tlrc.HEAD
