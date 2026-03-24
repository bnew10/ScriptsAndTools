#!/usr/bin/env bash

# Validate input arguments
if [ $# -ne 4 ]; then
    echo "Usage: $0 <num_iterations> <min-max_size_KB> <target_directory> <num_files_per_iteration> <notify>"
    echo "Example: $0 10 1-200 /path/to/destination-folder 25 yes"
    exit 1
fi

# Assign input arguments to variables
num_iterations=$1
size=$2
target_dir=$3
num_files=$4 # Number of files to create per iteration
notify=$5

if [[ "$size" == *'-'* ]]; then
    # Extract min and max file sizes from the second argument
    min_size=$(echo "$size" | cut -d'-' -f1)
    max_size=$(echo "$size" | cut -d'-' -f2)

    # Validate min and max size
    if ! [[ $min_size =~ ^[0-9]+$ && $max_size =~ ^[0-9]+$ && $min_size -le $max_size ]]; then
        echo "Invalid size range. Provide a valid min-max range (e.g., 1-200)."
        exit 1
    fi
fi

# Validate number of files per iteration
if ! [[ $num_files =~ ^[0-9]+$ && $num_files -gt 0 ]]; then
    echo "Invalid number of files per iteration. Provide a positive integer."
    exit 1
fi

# Ensure the target directory exists
mkdir -p "$target_dir"

# Loop through the specified number of iterations
for iteration in $(seq 1 "$num_iterations"); do
    iter_msg="Iteration ${iteration}"
    echo "$iter_msg"
    [[ -n $notify ]] && ssh -p 12345 bnewton@localhost curl -s -d \""$iter_msg"\" "ntfy.sh/$HOSTNAME"

    # Generate num_files files
    for i in $(seq 1 "$num_files"); do
        if [[ -n $min_size && -n $max_size ]]; then
            diff=$((max_size - min_size))
            mod=$((RANDOM % diff))
            size=$((min_size + mod))
        fi
        head -c "$size" /dev/urandom >"${target_dir}/f${iteration}_${i}_${size}"
        # fallocate -l "${size}K" "${target_dir}/f${iteration}_${i}_${size}K"
    done
done
[[ -n $notify ]] && ssh -p 12345 bnewton@localhost curl -s -d "\"Finished Iterations-filecreation.sh\"" "ntfy.sh/$HOSTNAME"
