# Install inkscape and image.... to do this

PARDIR="$(dirname "$(realpath "$0")")"

cd $PARDIR

export sizes=({16..256})
convert -background transparent -size 1024x1024 favicon.svg favicon.png
convert -background transparent -define "icon:auto-resize=$(IFS=","; echo "${array[*]}")" favicon.svg favicon.ico

cp favicon.ico ../../