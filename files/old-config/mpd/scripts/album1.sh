#!/bin/bash

# Script for changing specific album names.

# Path to the specific album directory
album_dir=""

# The desired album name for these files
album_name=""

# Loop through all FLAC files in the directory
find "$album_dir" -type f -name "*.flac" | while read -r file; do
    # Extract the current ALBUM metadata
    raw_album=$(metaflac --show-tag=ALBUM "$file")

    # Check if the ALBUM tag exists
    if [[ "$raw_album" == ALBUM=* ]]; then
        echo "Updating existing ALBUM metadata for: $file"
    else
        echo "No ALBUM metadata found for: $file. Adding ALBUM tag."
    fi

    # Remove the existing ALBUM tag (if it exists)
    metaflac --remove-tag=ALBUM "$file"

    # Set the new ALBUM tag with the desired name
    metaflac --set-tag=ALBUM="$album_name" "$file"

    echo "Updated ALBUM metadata for: $file -> $album_name"
done

