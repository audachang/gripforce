#!/bin/bash

atlas="FS.afni.MNI2009c_asym"

# Check if the mask file exists and remove it if it does
if [ -f "${atlas}_mask+tlrc.HEAD" ]; then
    rm "${atlas}_mask+tlrc."*
fi




# Extract ROI labels and codes
region_labels_codes=$(whereami -atlas $atlas -show_atlas_code | grep -o '[^:]*:[^:]*$' | awk -F':' '{print $1 ":" $2}')

# Initialize an empty list to store mask file names
mask_files=()

# Extract individual region masks
while IFS=: read -r label code; do
    # Create a mask with the region code as the value
    #3dcalc -a "$atlas::$label" -expr "equals(a,1)*$code" -prefix mask_$(echo $label | tr -d ' ')
    mask_files+=("mask_$(echo $label | tr -d ' ')"+tlrc)
done <<< "$region_labels_codes"



# Create input options and expression for 3dcalc
input_options=()
expr=""
index=0

for mask in "${mask_files[@]}"; do
    letter=$(echo "$index" | tr '0123456789' 'abcdefghij')
    input_options+=("-${letter} ${mask}")
    if [ -z "$expr" ]; then
        expr="${letter}"
    else
        expr+="+${letter}"
    fi
    index=$((index + 1))
    echo $index, $expr
done

# Combine all region masks into one
3dcalc "${input_options[@]}" -expr "$expr" -prefix ${atlas}_mask












