#!/usr/bin/tcsh -ef 


foreach dir (/media/DATA3/GripForce/out/afni/subject_results/subj.sub*)
    if (-d $dir) then
        mkdir -p $dir/ses-01
    endif
end
