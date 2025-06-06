#!/home/aclexp/anaconda3/envs/neuro/bin/python

import os
import pandas as pd
import sys

fnlist = sys.argv[1]
ses = sys.argv[2]

#sids = pd.read_csv('list_afni_subj.txt', header = None )
sids = pd.read_csv(fnlist, header = None )

for s in range(sids.shape[0]):
	sid = sids.iloc[s,0]
	lsuf = sids.iloc[s,1]
	rsuf = sids.iloc[s,2]
	print(f'Processing subject {sid:04d}...')
	os.system(f"python ../preproc_scripts/extr_timing_files_BIDS.py {sid} {lsuf} {rsuf} {ses}")
