#!/bin/tcsh -ef

#listing DROPBOX mri files by comparing B*.L & B*.R folders
# both Left and Right functional folders shall be larger than 
# 4096 bytes to be include in the list

find /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData/sub*/mri 	\
	-maxdepth 1 -printf "%p\t%s\n"				\
	| grep mri | cut -d / -f 8,10 				\
	| grep '/B.*L' | cut -f 1,2 | awk '$2 > 4096'		\
	| cut -d / -f 1 | tr -d sub- > tmp_BL

find /media/DATA1n/Dropbox/Dropbox/Tests/3_RawData/sub*/mri 	\
	-maxdepth 1 -printf "%p\t%s\n"				\
	| grep mri | cut -d / -f 8,10 				\
	| grep '/B.*R' | cut -f 1,2 | awk '$2 > 4096'		\
	| cut -d / -f 1 | tr -d sub- > tmp_BR

comm -1 -2 tmp_BL tmp_BR




