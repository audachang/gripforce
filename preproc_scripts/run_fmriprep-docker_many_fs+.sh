#!/usr/bin/tcsh -ef


set list2fmriprep = `cat list2fmriprep.txt`


foreach sid ( $list2fmriprep)

	#./run_fmriprep-docker.sh sub-$sid
	./run_fmriprep-docker-nofs.sh sub-$sid


end
