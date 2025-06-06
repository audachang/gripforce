#!/usr/bin/tcsh -xvef

docker run -it --rm \
	-v /media/DATA3/GripForce/BIDS:/data:ro \
	-v /media/DATA3/GripForce/out/mriqc:/out \
	nipreps/mriqc:latest \
	/data /out group 

# https://mriqc.readthedocs.io/en/latest/docker.html
#docker run -it --rm -v <bids_dir>:/data:ro \
#	-v <output_dir>:/out nipreps/mriqc:latest /data /out group
