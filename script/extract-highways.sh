#!/bin/bash
shopt -s nullglob

FILES=$1/*.pbf
OUTDIR=$2

for f in $FILES
    do
        echo "Processing $f..."
        FILENAME=$(basename "$f")
        FILENAME=${FILENAME%%.*}
        OUTFILE="$OUTDIR/$FILENAME-highways.osm.pbf"
        echo $OUTFILE
        /mnt/osm/bin/osmosis --rb $f --tf accept-ways highway=\* --tf reject-relations --used-node --wb $OUTFILE
    done
