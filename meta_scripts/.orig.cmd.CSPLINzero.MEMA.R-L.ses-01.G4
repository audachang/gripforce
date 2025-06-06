#!/bin/tcsh -xef

# created by uber_ttest.py: version 2.1 (May 11, 2020)
# creation date: Mon Jul  8 09:49:41 2024

# ---------------------- set process variables ----------------------

set mask_dset = ../out/afni/subject_results/group_results/mask_intersection_func_up2date+tlrc

set dirA = ../out/afni/subject_results

# specify and possibly create results directory
set results_dir = ../out/afni/subject_results/group_results/G4.CSPLINzero.3dMEMA_N=45.R-L.ses-01.results
if ( ! -d $results_dir ) mkdir $results_dir

# ------------------------- process the data -------------------------

3dMEMA -prefix $results_dir/stats.mema                                                               \
       -mask $mask_dset                                                                              \
       -set R-L                                                                                      \
          001                                                                                        \
       "$dirA/subj.sub0001/ses-01/sub0001.CSPLINzero.results/stats.sub0001.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0001/ses-01/sub0001.CSPLINzero.results/stats.sub0001.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          012                                                                                        \
       "$dirA/subj.sub0012/ses-01/sub0012.CSPLINzero.results/stats.sub0012.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0012/ses-01/sub0012.CSPLINzero.results/stats.sub0012.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          021                                                                                        \
       "$dirA/subj.sub0021/ses-01/sub0021.CSPLINzero.results/stats.sub0021.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0021/ses-01/sub0021.CSPLINzero.results/stats.sub0021.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          022                                                                                        \
       "$dirA/subj.sub0022/ses-01/sub0022.CSPLINzero.results/stats.sub0022.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0022/ses-01/sub0022.CSPLINzero.results/stats.sub0022.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          024                                                                                        \
       "$dirA/subj.sub0024/ses-01/sub0024.CSPLINzero.results/stats.sub0024.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0024/ses-01/sub0024.CSPLINzero.results/stats.sub0024.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          025                                                                                        \
       "$dirA/subj.sub0025/ses-01/sub0025.CSPLINzero.results/stats.sub0025.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0025/ses-01/sub0025.CSPLINzero.results/stats.sub0025.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          030                                                                                        \
       "$dirA/subj.sub0030/ses-01/sub0030.CSPLINzero.results/stats.sub0030.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0030/ses-01/sub0030.CSPLINzero.results/stats.sub0030.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          055                                                                                        \
       "$dirA/subj.sub0055/ses-01/sub0055.CSPLINzero.results/stats.sub0055.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0055/ses-01/sub0055.CSPLINzero.results/stats.sub0055.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          057                                                                                        \
       "$dirA/subj.sub0057/ses-01/sub0057.CSPLINzero.results/stats.sub0057.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0057/ses-01/sub0057.CSPLINzero.results/stats.sub0057.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          068                                                                                        \
       "$dirA/subj.sub0068/ses-01/sub0068.CSPLINzero.results/stats.sub0068.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0068/ses-01/sub0068.CSPLINzero.results/stats.sub0068.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          069                                                                                        \
       "$dirA/subj.sub0069/ses-01/sub0069.CSPLINzero.results/stats.sub0069.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0069/ses-01/sub0069.CSPLINzero.results/stats.sub0069.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          070                                                                                        \
       "$dirA/subj.sub0070/ses-01/sub0070.CSPLINzero.results/stats.sub0070.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0070/ses-01/sub0070.CSPLINzero.results/stats.sub0070.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          071                                                                                        \
       "$dirA/subj.sub0071/ses-01/sub0071.CSPLINzero.results/stats.sub0071.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0071/ses-01/sub0071.CSPLINzero.results/stats.sub0071.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          073                                                                                        \
       "$dirA/subj.sub0073/ses-01/sub0073.CSPLINzero.results/stats.sub0073.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0073/ses-01/sub0073.CSPLINzero.results/stats.sub0073.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          074                                                                                        \
       "$dirA/subj.sub0074/ses-01/sub0074.CSPLINzero.results/stats.sub0074.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0074/ses-01/sub0074.CSPLINzero.results/stats.sub0074.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          075                                                                                        \
       "$dirA/subj.sub0075/ses-01/sub0075.CSPLINzero.results/stats.sub0075.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0075/ses-01/sub0075.CSPLINzero.results/stats.sub0075.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          076                                                                                        \
       "$dirA/subj.sub0076/ses-01/sub0076.CSPLINzero.results/stats.sub0076.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0076/ses-01/sub0076.CSPLINzero.results/stats.sub0076.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          078                                                                                        \
       "$dirA/subj.sub0078/ses-01/sub0078.CSPLINzero.results/stats.sub0078.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0078/ses-01/sub0078.CSPLINzero.results/stats.sub0078.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          092                                                                                        \
       "$dirA/subj.sub0092/ses-01/sub0092.CSPLINzero.results/stats.sub0092.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0092/ses-01/sub0092.CSPLINzero.results/stats.sub0092.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          095                                                                                        \
       "$dirA/subj.sub0095/ses-01/sub0095.CSPLINzero.results/stats.sub0095.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0095/ses-01/sub0095.CSPLINzero.results/stats.sub0095.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          106                                                                                        \
       "$dirA/subj.sub0106/ses-01/sub0106.CSPLINzero.results/stats.sub0106.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0106/ses-01/sub0106.CSPLINzero.results/stats.sub0106.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          110                                                                                        \
       "$dirA/subj.sub0110/ses-01/sub0110.CSPLINzero.results/stats.sub0110.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0110/ses-01/sub0110.CSPLINzero.results/stats.sub0110.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          112                                                                                        \
       "$dirA/subj.sub0112/ses-01/sub0112.CSPLINzero.results/stats.sub0112.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0112/ses-01/sub0112.CSPLINzero.results/stats.sub0112.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          113                                                                                        \
       "$dirA/subj.sub0113/ses-01/sub0113.CSPLINzero.results/stats.sub0113.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0113/ses-01/sub0113.CSPLINzero.results/stats.sub0113.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          116                                                                                        \
       "$dirA/subj.sub0116/ses-01/sub0116.CSPLINzero.results/stats.sub0116.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0116/ses-01/sub0116.CSPLINzero.results/stats.sub0116.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          132                                                                                        \
       "$dirA/subj.sub0132/ses-01/sub0132.CSPLINzero.results/stats.sub0132.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0132/ses-01/sub0132.CSPLINzero.results/stats.sub0132.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          138                                                                                        \
       "$dirA/subj.sub0138/ses-01/sub0138.CSPLINzero.results/stats.sub0138.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0138/ses-01/sub0138.CSPLINzero.results/stats.sub0138.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          139                                                                                        \
       "$dirA/subj.sub0139/ses-01/sub0139.CSPLINzero.results/stats.sub0139.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0139/ses-01/sub0139.CSPLINzero.results/stats.sub0139.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          142                                                                                        \
       "$dirA/subj.sub0142/ses-01/sub0142.CSPLINzero.results/stats.sub0142.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0142/ses-01/sub0142.CSPLINzero.results/stats.sub0142.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          143                                                                                        \
       "$dirA/subj.sub0143/ses-01/sub0143.CSPLINzero.results/stats.sub0143.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0143/ses-01/sub0143.CSPLINzero.results/stats.sub0143.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          148                                                                                        \
       "$dirA/subj.sub0148/ses-01/sub0148.CSPLINzero.results/stats.sub0148.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0148/ses-01/sub0148.CSPLINzero.results/stats.sub0148.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          149                                                                                        \
       "$dirA/subj.sub0149/ses-01/sub0149.CSPLINzero.results/stats.sub0149.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0149/ses-01/sub0149.CSPLINzero.results/stats.sub0149.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          156                                                                                        \
       "$dirA/subj.sub0156/ses-01/sub0156.CSPLINzero.results/stats.sub0156.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0156/ses-01/sub0156.CSPLINzero.results/stats.sub0156.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          178                                                                                        \
       "$dirA/subj.sub0178/ses-01/sub0178.CSPLINzero.results/stats.sub0178.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0178/ses-01/sub0178.CSPLINzero.results/stats.sub0178.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          181                                                                                        \
       "$dirA/subj.sub0181/ses-01/sub0181.CSPLINzero.results/stats.sub0181.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0181/ses-01/sub0181.CSPLINzero.results/stats.sub0181.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          183                                                                                        \
       "$dirA/subj.sub0183/ses-01/sub0183.CSPLINzero.results/stats.sub0183.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0183/ses-01/sub0183.CSPLINzero.results/stats.sub0183.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          202                                                                                        \
       "$dirA/subj.sub0202/ses-01/sub0202.CSPLINzero.results/stats.sub0202.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0202/ses-01/sub0202.CSPLINzero.results/stats.sub0202.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          214                                                                                        \
       "$dirA/subj.sub0214/ses-01/sub0214.CSPLINzero.results/stats.sub0214.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0214/ses-01/sub0214.CSPLINzero.results/stats.sub0214.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          215                                                                                        \
       "$dirA/subj.sub0215/ses-01/sub0215.CSPLINzero.results/stats.sub0215.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0215/ses-01/sub0215.CSPLINzero.results/stats.sub0215.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          223                                                                                        \
       "$dirA/subj.sub0223/ses-01/sub0223.CSPLINzero.results/stats.sub0223.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0223/ses-01/sub0223.CSPLINzero.results/stats.sub0223.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          228                                                                                        \
       "$dirA/subj.sub0228/ses-01/sub0228.CSPLINzero.results/stats.sub0228.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0228/ses-01/sub0228.CSPLINzero.results/stats.sub0228.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          230                                                                                        \
       "$dirA/subj.sub0230/ses-01/sub0230.CSPLINzero.results/stats.sub0230.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0230/ses-01/sub0230.CSPLINzero.results/stats.sub0230.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          232                                                                                        \
       "$dirA/subj.sub0232/ses-01/sub0232.CSPLINzero.results/stats.sub0232.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0232/ses-01/sub0232.CSPLINzero.results/stats.sub0232.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          246                                                                                        \
       "$dirA/subj.sub0246/ses-01/sub0246.CSPLINzero.results/stats.sub0246.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0246/ses-01/sub0246.CSPLINzero.results/stats.sub0246.CSPLINzero_REML+tlrc[94]" \
                                                                                                     \
          250                                                                                        \
       "$dirA/subj.sub0250/ses-01/sub0250.CSPLINzero.results/stats.sub0250.CSPLINzero_REML+tlrc[93]" \
       "$dirA/subj.sub0250/ses-01/sub0250.CSPLINzero.results/stats.sub0250.CSPLINzero_REML+tlrc[94]"

