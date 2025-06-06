#!/usr/bin/tcsh -xef

if (-d ../BIDS/tmp_dcm2bids) then
	rm -R ../BIDS/tmp_dcm2bids
endif

fmriprep-docker  			\
   ../BIDS/ ../out/ participant 	\
   --participant-label $1 		\
   --output-spaces MNI152NLin2009cAsym \
   --nthreads 20 			\
   --omp-nthreads 10			\
   --mem_mb 64 				\
   -w ../work/ 				\
   -v




