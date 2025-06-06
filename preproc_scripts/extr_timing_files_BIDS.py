#!/home/tcnl/anaconda3/envs/base/bin/python

import pandas as pd
import re
import numpy as np
from glob import glob
import os
import  sys

debug = False
fproot = "/home/aclexp/TCNL_Dropbox/tcnl_tcnl/fmriprep_out/fmriprep"
sids = [int(sys.argv[1])]
lsuf = sys.argv[2]
rsuf = sys.argv[3]
ses = sys.argv[4]

nv = 196
TR = 2.4
offset = nv * TR


#regressor
for sid in sids:

    sub = f"sub-{sid:04d}"
    #sub = f"sub-{sid}" #when using list_afni_subj.txt
    print(f'processing {sub} regressor files ....')

    print(f'../preproc_scripts/grant_permit.sh {sub}')
    os.system(f'../preproc_scripts/grant_permit.sh {sub}  -S acl2023@@')

    logfile = [f"/media/DATA3/GripForce/beh/rawbeh/{sub}_{ses}_task-GFORCE_run-{lsuf}.csv",
                   f"/media/DATA3/GripForce/beh/rawbeh/{sub}_{ses}_task-GFORCE_run-{rsuf}.csv"]



    runs = ['2','1'] #always map run-R to run-01, and run-L to run-02

    for i in range(2):
        data = pd.read_csv(logfile[i])
        #print(data.columns)
        data2 = data.loc[:,
                         ['Target_Size','Ins_key.rt','TARGET.started',
                          'Ins_key.started', 'ISItime', 'ISI_4.stopped',
                          'trials.thisN']]
        target_starts = data.loc[:, "TARGET.started"].dropna().reset_index()
        data3 = data2.iloc[target_starts['index'], :]

        data3 = data3.assign(Target_onsets =                    \
                             data3.loc[:,"TARGET.started"]-     \
                             data.loc[0, 'Ins_key.rt'] -        \
                             data.loc[0, 'Ins_key.started'])

        data4 = pd.DataFrame()
        data4['onset'] = np.round(data3.Target_onsets, decimals=3)
        data4['duration'] = 4.8
        data4['trial_type'] = data.Target_Size

        if i == 0:
            data4["trial_type"].replace({0.6: "L_40%", 0.9: "L_60%"}, inplace=True)
        else:
            data4["trial_type"].replace({0.6: "R_40%", 0.9: "R_60%"}, inplace=True)

#         timingfn = re.sub('/media/DATA3/GripForce/beh/rawbeh/',
# 		f'/home/aclexp/Dropbox/fmriprep_out/fmriprep/{sub}/ses-01/func/', \
#             re.sub(f"-[{lsuf}{rsuf}]+.csv",f"-{runs[i]}_events.tsv",\
#                 logfile[i]))

#         print(f"run {runs[i]}: 40%:")
#         temp40 = data4[data4['trial_type'].str.contains('40%')]
#         print(temp40.onset.to_string(index=False).replace('\n',' '))
#         print(temp40.duration.to_string(index=False).replace('\n',' '))
#         print(f"run {runs[i]}: 60%:")
#         temp60 = data4[data4['trial_type'].str.contains('60%')]
#         print(temp60.onset.to_string(index=False).replace('\n',' '))
#         print(temp60.duration.to_string(index=False).replace('\n',' '))


        timingfn = re.sub(f'/media/DATA3/GripForce/beh/rawbeh',
		f'{fproot}/{sub}/{ses}/func', \
            re.sub(f"-[{lsuf}{rsuf}]+.csv",f"-{runs[i]}_events.tsv",\
                logfile[i]))

        print(f"run {runs[i]}: 40%:")
        temp40 = data4[data4['trial_type'].str.contains('40%')]
        print(temp40.onset.to_string(index=False).replace('\n',' '))
        print(temp40.duration.to_string(index=False).replace('\n',' '))
        print(f"run {runs[i]}: 60%:")
        temp60 = data4[data4['trial_type'].str.contains('60%')]
        print(temp60.onset.to_string(index=False).replace('\n',' '))
        print(temp60.duration.to_string(index=False).replace('\n',' '))

        print(timingfn)

        data4.to_csv(timingfn, sep="\t", index=False, header = True)




        print(f'timing regressor written to:\n {timingfn}')
