#!/bin/bash
echo 'starting run ===================================================================='
date
BASEDIR="/mnt/osm"
PATH=/mnt/osm/bin:$PATH
# move new file to old
cd $BASEDIR/bin
# make the current planet old
echo 'going to back up old planet...'
date
mv $BASEDIR/planet/planet.osm.pbf $BASEDIR/planet/planet_old.osm.pbf
# update the planet
echo 'going to update planet'
date
./osmupdate  -t=$BASEDIR/tmp/osmupdate $BASEDIR/planet/planet_old.osm.pbf $BASEDIR/planet/planet.osm.pbf
# splitting
echo 'going to split into regions...'
date
$BASEDIR/script/split-current.py
# creating highway only PBFs
#echo 'going to create highway only PBFs for the US...'
#date
#mkdir -p $BASEDIR/tmp/pbf/us/highways-only
#$BASEDIR/script/extract-highways.sh $BASEDIR/tmp/pbf/us $BASEDIR/tmp/pbf/us/highways-only
# copy
echo 'moving everything in place...'
date
rm -r $BASEDIR/srv/*
mv $BASEDIR/tmp/pbf/* $BASEDIR/srv
date
echo 'done'
