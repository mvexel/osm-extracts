#!/bin/bash

# Get options
while getopts ":i:o:d:" opt; do
  case $opt in
    i)
	  IN_PBF=$OPTARG
      echo "using input file: $IN_PBF" >&2
      ;;
    o)
	  OUT_DIR=$OPTARG
      echo "using output dir: $OUT_DIR" >&2
      ;;
    d)
	  DATESTAMP=$OPTARG
      echo "using datestamp: $DATESTAMP" >&2
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

# Add bin to path
export PATH=$BASEDIR/bin:$PATH

echo '=== starting run ==='
echo "base directory: $BASEDIR"
date

# splitting
echo 'going to split into regions...'
date
$BASEDIR/script/split-current.py $BASEDIR $IN_PBF $BASEDIR/tmp/pbf

# rename .osm.pbf files
echo 'going to append datestamp to all PBF files...'
date
$BASEDIR/script/append-date.py $BASEDIR/tmp/pbf .osm.pbf $DATESTAMP

# move to web dir
echo 'going to move everything in place...'
date
rsync -av --min-size=131 $BASEDIR/tmp/pbf/ $OUT_DIR
rm -r $BASEDIR/tmp/pbf/*
date
echo '=== done ==='
