#!/bin/tcsh -ef

set ddir = '../out/afni/subject_results'

set sid = $1
set ses = $2

set sdir = $ddir/subj.sub$sid/$ses/sub$sid.CSPLINzero.results

set tarfn = stats.sub$sid.CSPLINzero_REML+tlrc

3dcopy -overwrite $sdir/$tarfn $sdir/tmp

3dinfo  -label $sdir/tmp+tlrc.HEAD | tr '|' '\n' | nl
3dinfo -label2index "L60_all#0_Coef" $sdir/tmp+tlrc.HEAD

3drefit -sublabel 81 "L60_sel#0_Coef" 	\
	-sublabel 82 "L60_sel#0_Tstat"	\
	-sublabel 83 "L60_sel_Fstat" 	\
	-sublabel 84 "R60_sel#0_Coef" 	\
   	-sublabel 85 "R60_sel#0_Tstat"	\
   	-sublabel 86 "R60_sel_Fstat"	\
   	-sublabel 87 "L40_sel#0_Coef"	\
  	-sublabel 88 "L40_sel#0_Tstat"	\
   	-sublabel 89 "L40_sel_Fstat"	\
	-sublabel 90 "R40_sel#0_Coef"	\
	-sublabel 91 "R40_sel#0_Tstat"	\
	-sublabel 92 "R40_sel_Fstat" 	\
	$sdir/tmp+tlrc.HEAD
