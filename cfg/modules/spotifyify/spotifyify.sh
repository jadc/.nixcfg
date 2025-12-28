#!/usr/bin/env bash
set -euo pipefail

# Usage: spotifyify "file" "artist name"

input="$1"
artist="$2"
filename="${input%.*}"       # Strip extension
ext="${input##*.}"           # Get extension
title="${filename##*/}"      # Remove path
title="${title//_/ }"        # Replace underscores with spaces

tmpfile="$(mktemp --suffix=.mp3)"

if [[ "${ext,,}" == "mp3" ]]; then
    echo "Tagging MP3 without re-encoding: $input"
    ffmpeg -i "$input" -hide_banner -y -vn -codec:a copy \
        -metadata artist="$artist" \
        -metadata title="$title" \
        -metadata album="Unreleased" \
        "$tmpfile"
else
    echo "Converting ${ext^^} → MP3 and tagging: $input"
    ffmpeg -i "$input" -hide_banner -y -vn -b:a 320k \
        -metadata artist="$artist" \
        -metadata title="$title" \
        -metadata album="Unreleased" \
        "$tmpfile"

    echo "Deleting original non-MP3 file: $input"
    rm -f "$input"
fi

mv -f "$tmpfile" "${filename}.mp3"
echo "✅ Done: ${filename}.mp3"
