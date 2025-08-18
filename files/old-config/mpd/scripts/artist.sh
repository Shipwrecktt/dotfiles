#!/bin/bash
# Define the directory containing your music files
MUSIC_DIR="Music/Dead_Kennedys/Dead_Kennedys_-_Give_Me_Convenience_Or_Give_Me_Death"
# Define the new artist name
NEW_ARTIST="Dead Kennedys"

# Loop through all .flac files in the folder
for song in "$MUSIC_DIR"/*.flac; do
    # Update the artist metadata for each file
    metaflac --remove-tag=ARTIST "$song"
    metaflac --set-tag=ARTIST="$NEW_ARTIST" "$song"
done

