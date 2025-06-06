#!/bin/bash

atlas="FS.afni.MNI2009c_asym"
# Initialize the final mask
final_mask="${atlas}_mask"



# Check if the mask file exists and remove it if it does
if [ -f "${final_mask}+tlrc.HEAD" ]; then
    rm "${final_mask}+tlrc."*
fi

template_path=/media/DATA3/GripForce/out/afni/subject_results/group_results/test.CSPLINzero.3dMEMA_N=373.FS.afni.MNI2009c_asym.ses-01.results
template_fn=${template_path}/'L40#0_Coef+tlrc'

# Extract ROI labels and codes
region_labels_codes=$(whereami -atlas $atlas -show_atlas_code | grep -o '[^:]*:[^:]*$' | awk -F':' '{print $1 ":" $2}')


# Use a region to create a blank dataset as the initial final mask
initial_region=$(echo "$region_labels_codes" | head -n 1 | awk -F':' '{print $1}')
3dcalc -a "$atlas::$initial_region" -expr '0' -prefix ${final_mask}+tlrc
3dresample -master ${template_fn} -prefix ${final_mask}_resam -input ${final_mask}+tlrc 


# Check if the initial mask was created successfully
if [ ! -f ${atlas}_mask+tlrc.HEAD ]; then
    echo "Failed to create initial mask"
    exit 1
fi



# Extract individual region masks and combine them
while IFS=: read -r label code; do
    # Create a mask with the region code as the value
    region_mask="mask_$(echo $label | tr -d ' ')"
    3dcalc -a "$atlas::$label" -expr "equals(a,1)*$code" -prefix ${region_mask}
    
    #3dinfo -ad3 -nv ${region_mask}+tlrc 
    
    #3dinfo -ad3 -nv ${template_fn}
    
    echo "running 3dresample... on ${region_mask}"
    3dresample -master ${template_fn} -prefix ${region_mask}_resam -input ${region_mask}+tlrc 

    3dinfo -ad3 -nv ${region_mask}_resam+tlrc 
    3dinfo -ad3 -nv ${final_mask}+tlrc 

    # Combine the region mask with the final mask
    3dcalc -a ${final_mask}_resam+tlrc -b ${region_mask}_resam+tlrc -expr 'a+b' -prefix ${final_mask}_tmp

    

    # Replace the final mask with the updated mask
    mv ${final_mask}_tmp+tlrc.BRIK.gz ${final_mask}_resam+tlrc.BRIK.gz
    mv ${final_mask}_tmp+tlrc.HEAD ${final_mask}_resam+tlrc.HEAD
done <<< "$region_labels_codes"

# Clean up individual masks if needed
rm mask_*

# Print completion message
echo "Combined mask created: ${final_mask}_resam+tlrc"
