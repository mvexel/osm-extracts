#!/bin/bash
date
BASEDIR="/mnt/osm"
PATH=/mnt/osm/bin:$PATH
# move new file to old
cd $BASEDIR/bin
# make the current planet old
echo 'going to back up old planet'
date
mv $BASEDIR/planet/planet.o5m $BASEDIR/planet/planet_old.o5m
# update the planet
echo 'going to update planet'
date
./osmupdate  -t=$BASEDIR/tmp/osmupdate $BASEDIR/planet/planet_old.o5m $BASEDIR/planet/planet.o5m
# create US extract
echo 'going to create US extract'
date
./osmconvert -B=$BASEDIR/poly/us.poly /mnt/osm/planet/planet.o5m -o=$BASEDIR/planet/us.o5m
# convert to pbf
echo 'going to convert US extract to PBF'
date
./osmconvert $BASEDIR/planet/us.o5m -o=$BASEDIR/tmp/pbf/us.osm.pbf
# split into states
echo 'going to split US extract to states'
date
mkdir -p $BASEDIR/tmp/pbf/states
for c in /mnt/osm/conf/*.conf;do $BASEDIR/bin/osm-history-splitter --hardcut $BASEDIR/tmp/pbf/us.osm.pbf $c;done
# copy
echo 'moving everything in place'
date
rm -r $BASEDIR/srv/*
mv $BASEDIR/tmp/pbf/* $BASEDIR/srv
echo 'done'
date
