#!/bin/bash
# process_assets.sh
# Converts video animations to optimized GIFs for web portfolio.
#
# Usage: bash scripts/process_assets.sh
# Requirements: ffmpeg, gifsicle (optional, for further optimization)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

ROTATION_MOV="$PROJECT_ROOT/assets/animations/crankshaft_rotation.mov"
ANIMATED_MP4="$PROJECT_ROOT/assets/animations/crankshaft_animated.mp4"
RAW_GIF="$PROJECT_ROOT/assets/animations/turntable_raw.gif"
FINAL_GIF="$PROJECT_ROOT/assets/animations/turntable.gif"

convert_to_gif() {
    local input="$1"
    local output="$2"

    echo "Converting $input to GIF..."
    ffmpeg -y -i "$input" \
        -vf "fps=15,scale=600:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
        -loop 0 "$output"

    echo "Created $output"
}

optimize_gif() {
    local input="$1"
    local output="$2"

    if command -v gifsicle &> /dev/null; then
        echo "Optimizing with gifsicle..."
        gifsicle -O3 --lossy=80 "$input" -o "$output"
        rm "$input"
        echo "Optimized to $output"
    else
        echo "gifsicle not found, skipping optimization"
        if [ "$input" != "$output" ]; then
            mv "$input" "$output"
        fi
    fi
}

# Primary: convert rotation .mov
if [ -f "$ROTATION_MOV" ]; then
    convert_to_gif "$ROTATION_MOV" "$RAW_GIF"
    optimize_gif "$RAW_GIF" "$FINAL_GIF"
    echo "Done: $FINAL_GIF"
# Fallback: convert animated .mp4
elif [ -f "$ANIMATED_MP4" ]; then
    echo "Rotation .mov not found, falling back to .mp4..."
    convert_to_gif "$ANIMATED_MP4" "$RAW_GIF"
    optimize_gif "$RAW_GIF" "$FINAL_GIF"
    echo "Done: $FINAL_GIF"
else
    echo "Error: No source video found in assets/animations/"
    exit 1
fi
