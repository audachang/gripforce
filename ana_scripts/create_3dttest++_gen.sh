#!/usr/bin/tcsh -xef


set model = $1
set nv = $2
set contrstr = $3

set ddir = ../out/afni/subject_results
set resdir = ../out/afni/subject_results/group_results/test.$model.ttest++_N=$nv.$contrstr.results

if (-f $resdir) then
	rm -r  $resdir

endif

gen_group_command.py -command 3dttest++			\
			-write_script cmd.tt++.R-L	\
			-prefix $resdir/stats.tt++.	\
			-dsets $ddir/subj.sub*/sub*.$model.results/stats.sub*.${model}_REML+tlrc.HEAD	\
			-set_labels R-L	\
			-subs_betas 'R-L#0_Coef' \
			-options			\
			-mask $ddir/group_results/mask_intersection_func_up2date+tlrc

