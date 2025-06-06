%%
subj = 'sub-0002';
subj2 = 'sub0002';
%subj='';
%subj2='';
delim='_';
delim2='_';
rootdir = '/media/DATA2/GripForce/out/afni';
%datadir = 'subject_results/group.young/group_results';
datadir = sprintf('subject_results/group.young/subj.%s/%s.CSPLIN.results',subj2,subj2);
% T1_gray_nii_fn = 'ave_T1+tlrc_seg1.nii';
% T1_white_nii_fn = 'ave_T1+tlrc_seg2.nii';
% T1_nii_fn = 'ave_T1+tlrc.nii';
T1_stem = 'ses-01_space-MNI152NLin2009cAsym_desc-preproc_T1w';
%T1_stem = 'ave_T1+tlrc'
T1_nii_fn =join({subj, T1_stem, '.nii'}, {delim, ''});
T1_gray_nii_fn = join({subj, T1_stem, 'seg1.nii'}, {delim, delim2});
T1_white_nii_fn = join({subj, T1_stem, 'seg2.nii'}, {delim, delim2});


T1_nii_pth = fullfile(rootdir, datadir, T1_nii_fn);
T1_nii_iso_pth = fullfile(rootdir, datadir, join({'c', T1_nii_fn{1}}, '_'));
T1_nii_gray_pth = fullfile(rootdir, datadir, T1_gray_nii_fn);
T1_nii_white_pth = fullfile(rootdir, datadir, T1_white_nii_fn);



%%
suit_isolate(T1_nii_pth{1});
job.subjND.isolation = T1_nii_iso_pth;
job.subjND.gray = {T1_nii_gray_pth};
job.subjND.white = {T1_nii_white_pth};
suit_normalize_dartel(job);
%% 
job.subj.affineTr = {'../Affine_ave_T1+tlrc_seg1.mat'};
job.subj.flowfield={'../u_a_ave_T1+tlrc_seg1.nii'};
job.subj.resample={'test.results/R-L_CSPLIN+tlrc_t.nii'};
job.subj.mask = {'../c_ave_T1+tlrc_pcereb.nii'};
suit_reslice_dartel(job);

%%
map = suit_map2surf('test.results/wdR-L_CSPLIN+tlrc_t.nii');
suit_plotflatmap(map);
shg
