#!/usr/bin/tcsh -xef

foreach d (/media/DATA3/GripForce/out/afni/subject_results/subj.sub*/)
  mkdir -p $d/ses-01
  foreach item ($d/*)
    # Check if item is a directory and not ses-01 or ses-02
    if (-d $item && $item !~ */ses-01 && $item !~ */ses-02) then
      mv $item $d/ses-01/
    endif
    # If item is a file, move it to ses-01
    if (-f $item) then
      mv $item $d/ses-01/
    endif
  end
end
