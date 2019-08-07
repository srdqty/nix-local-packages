#!@bash@

set -eu

input_file=$1
output_file=$2

@ffmpeg@ -i "${input_file}" \
  -c:v libx264 -crf 23 -profile:v baseline -level 3.0 -pix_fmt yuv420p \
  -c:a aac -ac 2 -b:a 128k \
  -movflags faststart \
  "${output_file}"
