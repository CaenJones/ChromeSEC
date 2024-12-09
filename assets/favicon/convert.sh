# Install inkscape and image.... to do this

ROOT=$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")

export sizes=({16..256})
convert -background transparent -size 1024x1024 favicon.svg favicon.png
convert -background transparent -define "icon:auto-resize=$(IFS=","; echo "${array[*]}")" favicon.svg favicon.ico

cp favicon.ico $ROOT