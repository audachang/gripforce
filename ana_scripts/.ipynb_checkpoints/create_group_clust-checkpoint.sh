#!/usr/bin/tcsh -xef

if ( $#argv != 7 ) then
	echo Create statistical threshold mask and clustered statistical maps
	echo "Usage: create_group_clust.sh <model> <nv> <contraststr> <tval> <qval> <NNval> <ses>"
	echo "Example: create_group_clust.sh CSPLIN 98 R-L 3.0210 001 1"
	exit 0

endif

set model = $1
set nv = $2
set contraststr = $3
set tval = $4 #set at q = .0001
set qval = $5
set NNval = $6
set ses = $7

set ddir = ../out/afni/subject_results/group_results/test.$model.3dMEMA_N=${nv}.${contraststr}.${ses}.results

echo "create $tval thresholded mask from the contrast $contraststr"
3dClusterize -nosum -1Dformat \
	-inset  $ddir/stats.mema+tlrc.HEAD \
	-idat 1 -ithr 1 -NN $NNval -clust_nvox 40 \
	-bisided -$tval $tval \
	-pref_map $ddir/${contraststr}_q{$qval}_NN{$NNval}_mask \
	-overwrite

echo "apply the thresholded mask on stats.mema+tlrc to extract the clusters"
echo "statistical maps saved out to ${contraststr}_q${qval}_NN{$NNval}_MEMA.nii"

3dcalc 	-a $ddir/${contraststr}_q{$qval}_NN{$NNval}_mask+tlrc \
       	-b $ddir/stats.mema+tlrc \
	-expr 'step(a)*b' \
       	-prefix  $ddir/${contraststr}_q{$qval}_NN{$NNval}_MEMA.nii \
     	-overwrite


#3dClusterize -nosum -1Dformat \
#-inset test.CSPLIN.3dMEMA_N=80.results/stats.mema+tlrc.HEAD \
#-idat 0 -ithr 1 -NN 1 -clust_nvox 40 \
#-bisided -3.0594 3.0594 \
#-pref_map R-L_CSPLIN_N=77_q05_mask
