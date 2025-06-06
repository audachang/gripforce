#!/usr/bin/tcsh -ef
# computing the cluster threshold by averaging the blur_est* from individdual subjects
# adapted from 
# https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/main_det_2018_TaylorEtal.html
# s.nimh_group_level_02_mema.tcsh
# 


set path_proc = ../out/afni/subject_results
set maskfn = $path_proc/group_results/mask_intersection_func_up2date+tlrc 

# output from 3dMEMA
set omema       = "$path_proc/group_results/test.CSPLINzero.N=254.R-L/stats.mema+tlrc"      # output effect+stats filename
set omema_mskd  = mema_results_mskd.nii.gz # masked, stats in brain


# Cluster parameters
set csim_NN     = "NN1"    # neighborhood; could be NN1, NN2, NN3
set csim_sided  = "1sided" # could be 1sided, 2sided or bisided
set csim_pthr   = 0.01     # voxelwise thr in 3dClustSim
set csim_alpha  = 0.05     # nominal FWE


# ==================== Calc average smoothness =======================

# Get the line from each blur estimate file that has our desired
# parameters; we are running REML here and using the ACF smoothness
# estimation, so the gpattern variable reflects both.  For N subjects,
# the output *1D file contains N rows of the 3 ACF parameters.
set gpattern = 'err_reml ACF'


#blur_est.sub0001.CSPLINzero

grep -h "$gpattern" ${path_proc}/subj*/sub*.CSPLINzero.results/blur_est*   \
    | cut -d\  -f1-3                              \
    > group_ACF_ests.1D

# Get the group average ACF parameters.
set blur_est = ( `3dTstat -mean -prefix - group_ACF_ests.1D\'` )
echo "++ The group average ACF params are: $blur_est"



# ==================== Cluster simulations =======================

# Simulations for FWE corrected cluster-size inference 
3dClustSim                                       \
    -both                                        \
    -mask   $maskfn \
    -acf    $blur_est                            \
    -prefix $path_proc/group_results/ClustSim 

# Get the volume threshold value from the ClustSim results, based on
# user's choice of parameters as set above.  The "-verb 0" means that
# just the threshold number of voxels is returned, so we can save that
# as a variable.
set clust_thrvol = `1d_tool.py -verb 0                                \
                        -infile $path_proc/group_results/ClustSim.${csim_NN}_${csim_sided}.1D  \
                        -csim_pthr   $csim_pthr                       \
                        -csim_alpha "$csim_alpha"`

# Get the statistic value equivalent to the desired voxelwise p-value,
# for thresholding purposes.  Using the same p-value and sidedness
# that were selected in the ClustSim results.  This program also gets
# the number of degrees of freedom (DOF) from the header of the volume
# containing the statistic. The "-quiet" means that only the
# associated statistic value is returned, so we can save it to a
# variable.
set voxstat_thr = `p2dsetstat -quiet                    \
                    -pval $csim_pthr                    \
                    "-${csim_sided}"                    \
                    -inset ${omema}'[controls:t]'`

echo "++ The final cluster volume threshold is:  $clust_thrvol"
echo "++ The voxelwise stat value threshold is:  $voxstat_thr"

# ================== Make cluster maps =====================

# Apply WB mask to the statistics results, so we only find clusters
# that lie within the mask of interest.
3dcalc                              \
    -a ${omema}                     \
    -b $maskfn                      \
    -expr 'a*b'                     \
    -prefix ${omema_mskd} 

# Following the previous paper, these commands extract the "positive"
# and "negative" cluster info, respectively, into separate files.
# Each applies clustering parameters above and makes: a *map* of
# cluster ROIs (regions numbered 1, 2, 3, ...); a map of the effect
# estimate (EE) values within those clusters; and a table report of
# the clusters.  
# Technical note: '-1tindex 1' means that the threshold is applied to
# the [1]st volume of the input dset, which here holds the statistic
# values; '-1dindex 0' means that data values saved in '-prefix ...'
# come from the [0]th volume of the input dset, which here holds the
# EE values.  
set csim_pref = "clust_tpos"
3dclust                                                        \
    -1Dformat -nosum -1tindex 1 -1dindex 0                     \
    -2thresh -1e+09 $voxstat_thr  -dxyz=1                      \
    -savemask $proc_path/group_results/${csim_pref}_map.nii.gz                          \
    -prefix   $proc_path/group_results/${csim_pref}_EE.nii.gz                           \
    1.01 ${clust_thrvol} ${omema_mskd} > $proc_path/group_results/${csim_pref}_table.1D
# Also make a mask of t-stats (not necessary, but matching previous
# work)
3dcalc \
    -a $proc_path/group_results/${csim_pref}_map.nii.gz                \
    -b ${omema}'[1]'                          \
    -expr "step(a)*b"                         \
    -prefix $proc_path/group_results/${csim_pref}_t.nii.gz             \
    -float

set csim_pref = "clust_tneg"
3dclust                                                        \
    -1Dformat -nosum -1tindex 1 -1dindex 0                     \
    -2thresh -$voxstat_thr 1e+09 -dxyz=1                       \
    -savemask ${csim_pref}_map.nii.gz                          \
    -prefix   ${csim_pref}_EE.nii.gz                           \
    1.01 ${clust_thrvol} ${omema_mskd} > $proc_path/group_results/${csim_pref}_table.1D
# Also make a mask of t-stats (not necessary, but matching previous
# work)
3dcalc \
    -a $proc_path/group_results/${csim_pref}_map.nii.gz                \
    -b $proc_path/group_results/${omema}'[1]'                          \
    -expr "step(a)*b"                         \
    -prefix $proc_path/group_results/${csim_pref}_t.nii.gz             \
    -float


# ===================================================================

# Again, Biowulf-running considerations: if processing went fine and
# we were using a temporary directory, copy data back.
if( $usetemp && -d $tempdir )then
    echo "Copying data from $tempdir to $path_mema"
    mkdir -p $path_mema
    \cp -pr $tempdir/* $path_mema/
endif

# ===================================================================

echo "\n++ DONE with group level stats + clustering!\n"

time ; exit 0
