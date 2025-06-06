#!/home/aclexp/anaconda3/envs/neuro/bin/python

import pandas as pd
import re
import numpy as np
from glob import glob
import os
import  sys

debug = False
#sids = [1, 2, 9, 11, 12,15, 16, 17, 18, 19, 
#21, 22, 23,24,25, 26, 29, 30, 31, 45, 46, 48, 49, 56]
sids = [int(sys.argv[1])]
lsuf = sys.argv[2]
rsuf = sys.argv[3]
#sids = pd.read_csv('list2afni.txt', header = None )

nv = 196
TR = 2.4
offset = nv * TR


#regressor
for sid in sids:

    sub = f"sub-{sid:04d}"
    print(f'processing {sub} regressor files ....')

    print(f'sudo ./grant_permit.sh {sub}')
    os.system(f'sudo ./grant_permit.sh {sub}')

    logfile = [f"/media/tcnl/data2/GRIPFORCE/beh/rawbeh/{sub}_ses-01_task-GFORCE_run-{lsuf}.csv",
                   f"/media/tcnl/data2/GRIPFORCE/beh/rawbeh/{sub}_ses-01_task-GFORCE_run-{rsuf}.csv"]


    runs = ['02','01'] #always map run-R to run-01, and run-L to run-02

    for i in range(2):
        data = pd.read_csv(logfile[i])
        #print(data.columns)
        data2 = data.loc[:,
                         ['Target_Size','Ins_key.rt','TARGET.started',
                          'Ins_key.started', 'ISItime', 'ISI_4.stopped',
                          'trials.thisN']]
        target_starts = data.loc[:, "TARGET.started"].dropna().reset_index()
        data3 = data2.iloc[target_starts['index'], :]

        data3 = data3.assign(Target_onsets = \
                             data3.loc[:,"TARGET.started"]-data.loc[0, 'Ins_key.rt'] - data.loc[0, 'Ins_key.started']) 
        #data3.head()
        # 40% disc
        data_s6 = data3.loc[data3['Target_Size']==0.6,:]
        tmp = data_s6.Target_onsets
        tmp2 = np.round(tmp, decimals=3)


        timingfn40 = re.sub('rawbeh/','', re.sub("-[LR_1236]+.csv",f"-{runs[i]}-40%.1D",logfile[i]))
        with open(timingfn40, 'w') as file:
            if runs[i] == '01':
                file.write(tmp2.to_string(index=False).replace("\n"," "))
                file.write('\n* *\n')
            else:
                file.write('* *\n')
                file.write(tmp2.to_string(index=False).replace("\n"," "))
        print(f'timing regressor written to:\n {timingfn40}')
        

        #60% disc

        data_s9 = data3.loc[data3['Target_Size']==0.9,:]
        tmp3 = data_s9.Target_onsets
        tmp4 = np.round(tmp3, decimals=3)

        timingfn60 = re.sub('rawbeh/','',re.sub(f"-[{lsuf}{rsuf}]+.csv",f"-{runs[i]}-60%.1D",logfile[i]))
        with open(timingfn60, 'w') as file:
            if runs[i]=='01':
                file.write(tmp4.to_string(index=False).replace("\n"," "))
                file.write('\n* *\n')
            else:
                file.write('* *\n')            
                file.write(tmp4.to_string(index=False).replace("\n"," "))

        print(f'timing regressor written to:\n {timingfn60}')



    # confounds
    fdir = f"/media/tcnl/data2/GRIPFORCE/out/fmriprep/sub-{sid:04d}/ses-01/func/"

    cdf = glob(fdir+"*GFORCE*confounds_timeseries.tsv")

    i = 1
    alldata = pd.DataFrame()
    for cf in cdf:
        cdata = pd.read_csv(cf, sep="\t")

        print(cdata.shape)
        coln = cdata.columns
        colsel = coln[coln.str.contains(
            "(global_signal$)|(trans_[xyz]$)|(rot_[xyz]$)|(a_comp_cor_[0][0-5]$)|cosine")]
        cdata2 = cdata.loc[:,colsel]
        cfnew = re.sub('run-[12]_desc-confounds_timeseries.tsv',
                   f'run-{i}_desc-confounds_sel_timeseries.1D', 
                   cf)
        cdata2.to_csv(cfnew, sep="\t",index=False, header=False)    

        alldata = pd.concat((alldata, cdata2))
        i += 1

    allfn = re.sub('run-[12]_desc-confounds_timeseries.tsv',
                   f'desc-confounds_sel_timeseries.1D', 
                   cf)
    alldata.to_csv(allfn, sep="\t", index=False, header = False)
        
        
    #print(f'confounds list: {colsel}')
    print(f'matrix dimesions: {alldata.shape}')
    print(f'export confounds to:\n {cfnew}')
