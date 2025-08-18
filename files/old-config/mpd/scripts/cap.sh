#!/bin/bash

# Path to your music directory
music_dir="Music/Dead_Kennedys/Dead_Kennedys_-_Give_Me_Convenience_Or_Give_Me_Death"

# Loop through all FLAC files in the directory (sorted by name)
find "$music_dir" -type f -name "*.flac" | sort | while read -r file; do
    # Extract the base filename without extension
    base_name=$(basename "$file" .flac)

    # Format the title by replacing underscores with spaces and capitalizing the first letters
    title=$(echo "$base_name" | sed -e 's/_/ /g' -e 's/^\(.\)/\U\1/' -e 's/\b\(.\)/\U\1/g')

    # Remove the original TITLE tag
    metaflac --remove-tag=TITLE "$file"

    # Set the new TITLE tag
    metaflac --set-tag=TITLE="$title" "$file"

    echo "Updated title for: $file -> $title"
done

