#!/bin/bash

BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

# Add bin to path
export PATH=$BASEDIR/bin:$PATH

echo '=== starting run ==='
echo "base directory: $BASEDIR"
date

# make the current planet old
echo 'going to back up old planet...'
date
mv $BASEDIR/planet/planet.osm.pbf $BASEDIR/planet/planet_old.osm.pbf

# update the planet
echo 'going to update planet'
date
$BASEDIR/bin/osmupdate  -t=$BASEDIR/tmp/osmupdate $BASEDIR/planet/planet_old.osm.pbf $BASEDIR/planet/planet.osm.pbf

# splitting
echo 'going to split into regions...'
date
$BASEDIR/script/split-current.py $BASEDIR

# rename .osm.pbf files
echo 'going to append datestamp to all PBF files...'
date
$BASEDIR/script/append-date.py $BASEDIR/tmp/pbf .osm.pbf

# move to web dir
echo 'going to move everything in place...'
date
rsync -av --min-size=131 $BASEDIR/tmp/pbf/ $BASEDIR/srv/
rm -r $BASEDIR/tmp/pbf/*
date
echo '=== done ==='
