#!/usr/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <source image filename>"
    exit 1
fi

FILENAME=$1
echo "Source file ${FILENAME}"

sizes=( "29x29" "58x58" "87x87"  "40x40"  "80x80" "120x120" "57x57" "114x114" "171x171" "60x60" "120x120" "180x180" "50x50" "100x100" "72x72" "144x144" "76x76" "152x152" )

for i in "${sizes[@]}"
do
    outfile="icon-${i}.png"
    echo "converting to: $outfile"
    convert $FILENAME -resize $i $outfile
done
