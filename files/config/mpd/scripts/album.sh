#!/bin/bash

# Path to your music directory
music_dir="Music/Dead_Kennedys"

# Loop through all FLAC files in the directory and its subdirectories
find "$music_dir" -type f -name "*.flac" | while read -r file; do
    # Extract the current ALBUM metadata
    raw_album=$(metaflac --show-tag=ALBUM "$file")

    # Check if the ALBUM tag exists
    if [[ "$raw_album" == ALBUM=* ]]; then
        # Extract the actual album name
        album_name=$(echo "$raw_album" | sed 's/^ALBUM=//')

        # Format the album name: capitalize the first letter of each word
        capitalized_album=$(echo "$album_name" | sed -e 's/\b\(.\)/\U\1/g')

        # Remove the original ALBUM tag
        metaflac --remove-tag=ALBUM "$file"

        # Set the new ALBUM tag with the properly capitalized name
        metaflac --set-tag=ALBUM="$capitalized_album" "$file"

        echo "Updated album metadata for: $file -> $capitalized_album"
    else
        echo "No ALBUM metadata found for: $file"
    fi
done

