#!/usr/bin/tcsh -xef

if ( $#argv != 3 ) then
	echo "usage: nii2funcgii.sh <model> <subject number> <contr>"
	echo "Example: vnii2funcgii.sh CSPLINzero 254 R-L"
	exit 0
endif



set rdir = ../out/afni/subject_results/group_results/
set model = $1
set sn = $2
set contr = $3
set giidir = ../out/freesurfer/fsaverage/surf
set giidir2 = ../cerebellar_atlases/tpl-SUIT

set ddir = $rdir/test.$model.3dMEMA_N=$sn.$contr.results
set niifn = $ddir/stats.mema.nii

set lhgiifn = $giidir/lh.pial.surf.gii 
set rhgiifn = $giidir/rh.pial.surf.gii 
set cerebgiifn = $giidir2/tpl-SUIT.surf.gii

#left surface
wb_command -volume-to-surface-mapping $niifn \
    $lhgiifn \
    $ddir/stats.mema.lh.pial.surf.metric.func.gii \
    -trilinear

#right surface
wb_command -volume-to-surface-mapping $niifn \
    $rhgiifn \
    $ddir/stats.mema.rh.pial.surf.metric.func.gii \
    -trilinear


#cerebellum flat
wb_command -volume-to-surface-mapping $niifn \
    $cerebgiifn \
    $ddir/stats.tpl-SUIT.metric.func.gii \
    -trilinear


