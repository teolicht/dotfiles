#!/bin/bash

# Get the current working directory
cwd=$(pwd)

# Extract the base name (current directory)
base_name=$(basename "$cwd")

# Extract the parent directory
parent_dir=$(basename "$(dirname "$cwd")")

# Format the output as .../<parent>/<cwd>
formatted_cwd=".../$parent_dir/$base_name"

# Output the formatted path
echo "$formatted_cwd"
