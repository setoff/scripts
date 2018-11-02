#!/usr/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <source image filename>"
    exit 1
fi

FILENAME=$1
echo "Source file ${FILENAME}"

sizes=( "48x48" "72x72" "96x96" "144x144" "192x192")

for i in "${sizes[@]}"
do
    outfile="ic_launcher${i}.png"
    echo "converting to: $outfile"
    convert $FILENAME -resize $i $outfile
done
