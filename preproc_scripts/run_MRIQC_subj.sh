docker run -it --rm \
	-v /media/DATA3/GripForce/BIDS:/data:ro \
	-v /media/DATA3/GripForce/out/mriqc:/out \
	nipreps/mriqc:latest \
	/data /out participant --participant_label $1 -m T1w bold 
