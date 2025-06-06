suit_isolate('sub-0001_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc.nii');
job.subjND.isolation = {'c_sub-0001_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc.nii'};
job.subjND.gray = {'sub-0001_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc_seg1.nii'};
job.subjND.white = {'sub-0001_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc_seg2.nii'};
suit_normalize_dartel(job);

job.subj.affineTr = {'Affine_sub-0001_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc_seg1.mat'};
job.subj.flowfield={'u_a_sub-0001_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc_seg1.nii'};
job.subj.resample={'stats.sub0001.CSPLIN_REML.nii'};
job.subj.mask = {'c_sub-0001_ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc_pcereb.nii'};;
suit_reslice_dartel(job);

map = suit_map2surf('wdstats.sub0001.CSPLIN_REML.nii');
suit_plotflatmap(map);
shg
