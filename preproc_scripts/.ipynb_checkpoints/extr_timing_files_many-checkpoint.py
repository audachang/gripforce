#!/home/aclexp/anaconda3/envs/neuro/bin/python

import pandas as pd
import re
import numpy as np
from glob import glob
import os
import  sys

debug = False
droot = "/media/DATA3/GripForce"
#fproot = f"{droot}/out/fmriprep"
fproot = "/home/aclexp/TCNL_Dropbox/tcnl_tcnl/fmriprep_out/fmriprep"
filestrs = pd.read_csv(sys.argv[1], header = None)
ses = sys.argv[2]

nv = 196
TR = 2.4
offset = nv * TR


#regressor
for i in range(filestrs.shape[0]):
    
    # print(filestrs)

    sid = filestrs.iloc[i, 0]
    lsuf = filestrs.iloc[i, 1]
    rsuf = filestrs.iloc[i, 2]

    sub = f"sub-{sid:04d}"
    print(f'processing {sub} regressor files ....')

    #print(f'sudo ../preproc_scripts/grant_permit.sh {sub}')
    #os.system(f'sudo ../preproc_scripts/grant_permit.sh {sub}')

    logfile = [f"{droot}/beh/rawbeh/{sub}_{ses}_task-GFORCE_run-{lsuf}.csv",
               f"{droot}/beh/rawbeh/{sub}_{ses}_task-GFORCE_run-{rsuf}.csv"]


    runs = ['02','01'] #always map run-R to run-01, and run-L to run-02

    for i in range(2):
        print(logfile[i])
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


        timingfn40 = re.sub(f'rawbeh',f'{ses}', re.sub("-[LR_12346]+.csv",f"-{runs[i]}-40%.1D",logfile[i]))
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

        timingfn60 = re.sub(f'rawbeh',f'{ses}',re.sub("-[LR_12346]+.csv",f"-{runs[i]}-60%.1D",logfile[i]))
        with open(timingfn60, 'w') as file:
            if runs[i]=='01':
                file.write(tmp4.to_string(index=False).replace("\n"," "))
                file.write('\n* *\n')
            else:
                file.write('* *\n')
                file.write(tmp4.to_string(index=False).replace("\n"," "))

        print(f'timing regressor written to:\n {timingfn60}')



    # confounds
    fdir = f'{fproot}/sub-{sid:04d}/{ses}/func/'

    cdf = glob(fdir+"*GFORCE*confounds_timeseries.tsv")

    i = 1
    alldata = pd.DataFrame()
    for cf in cdf:
        print("Processing confounds....")
        cdata = pd.read_csv(cf, sep="\t")
        print(cdata.shape)
        coln = cdata.columns
        colsel = coln[coln.str.contains(
            "(?:trans_[xyz]$)|(?:rot_[xyz]$)|framewise_displacement|^global_signal$|(?:a_comp_cor_[0][0-5]$)|cosine[0][0-5]$")]
        cdata2 = cdata.loc[:,colsel]
        cfnew = re.sub('run-[12]_desc-confounds_timeseries.tsv',
                   f'run-{i}_desc-confounds_sel_timeseries.1D',
                       cf)
        
        print(f'saving {cfnew}....')
        cdata2.to_csv(cfnew, sep="\t",index=False, header=False)

        alldata = pd.concat((alldata, cdata2))
        i += 1

        allfn = re.sub('run-[12]_desc-confounds_timeseries.tsv',
                       f'desc-confounds_sel_timeseries.1D',
                       cf)

        alldata.to_csv(allfn, sep="\t", index=False, header = False)


        print(f'confounds list: {colsel}')
        print(f'matrix dimesions: {alldata.shape}')
        print(f'export confounds to:\n {cfnew}')
