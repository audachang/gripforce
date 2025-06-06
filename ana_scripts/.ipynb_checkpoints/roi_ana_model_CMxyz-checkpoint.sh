#!/bin/tcsh -xef

# Check if the correct number of arguments is provided
if ( $#argv != 7 ) then
	echo "usage: ../ana_scripts/roi_ana_model_Tstat.sh <condstr> <maskstr> <tpval01> <subjfn> <qval> <NNval> <sesid>"
	echo "Example: ../ana_scripts/roi_ana_model_Tstat.sh R40 R-L 2.1633 list_afni_subj.txt"
	echo condstr: the condition parameter to be extracted
	echo maskstr: the contrast forming the statistical maps to be extracted
	echo tpval01: t value at p = .01 for the given sample of participants
    echo subjfn: subject list file
	echo qval: q-value of setting up the mask
	echo NNval: method of forming clusters
    echo sesid: which session is analyzed
    echo 
	echo updated on 2023-01-07 by EC
	echo update the individual condition Tstat voxel rule
	exit 0
endif

# Set directories for data and scripts
set ddir = '../out/afni/subject_results'
set scrdir = `pwd`

# Assign input arguments to variables
set condstr = $1      # Condition parameter
set contrstr = $2     # Contrast parameter
set tpval01 = $3      # T-statistic threshold value
set Subjfn = $4       # Subject list filename
set qval = $5         # Q-value for mask thresholding
set NNval = $6        # Clustering method
set ses = $7          # Session ID

# Read subject IDs from the provided subject list file
set sids = (`cat $Subjfn` )
set Num = (`cat $Subjfn | wc -l` ) # Count the number of subjects

# Define directories for group results
set gpdir  = $ddir/group_results
set anadir = $gpdir/test.CSPLINzero.3dMEMA_N=${Num}.$contrstr.$ses.results

# Start computing significant voxel mask using 3dcalc
echo 3dcalc start

3dcalc -a $anadir/"${condstr}_sel#0_Tstat+tlrc" \
	-b $anadir/${contrstr}_q{$qval}_NN{$NNval}_mask+tlrc \
	-prefix $anadir/"${condstr}_sel#0_Tstat=$tpval01" \
	-expr "ispositive(abs(a) - $tpval01)*step(b)" \
	-verbose -overwrite  # Overwrite existing files if needed

echo 3dcalc end

# Extract statistics including center of mass coordinates using 3dROIstats
echo 3dROIstats start
3dROIstats -nzvoxels -nomeanout -longnames \
	-mask $anadir/${contrstr}_q{$qval}_NN{$NNval}_mask+tlrc \
	$anadir/"${condstr}_sel#0_Tstat=${tpval01}+tlrc" > \
	$anadir/"${condstr}_sel#0_Tstat=${tpval01}_p001_ROI_xyz.txt"

echo 3dROIstats end
