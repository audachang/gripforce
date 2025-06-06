#!/usr/bin/tcsh -ef

if ($#argv != 2) then

	echo "usage: run_fmriprep-docker_many.sh <listfn> <opflag>"
	echo "opflag"
	echo "0 = full, 1 = no freesurfer, 2 = only anatomy"
	  exit 0


endif

set listfn = $argv[1]
set list2fmriprep = `cat $listfn`
set opflag = $argv[2]

foreach sid ( $list2fmriprep)
	if ( $opflag == 0 ) then
		echo ./run_fmriprep-docker.sh sub-$sid
		./run_fmriprep-docker.sh sub-$sid
		
	else if ( $opflag == 1 ) then
		echo ./run_fmriprep-docker-nofs.sh sub-$sid
		./run_fmriprep-docker-nofs.sh sub-$sid

	else
		echo ./run_fmriprep-docker-anatonly.sh sub-$sid
		./run_fmriprep-docker-anatonly.sh sub-$sid


	endif

end
