#!/bin/bash

# exit on SIGINT
trap "exit" INT

# base dir from arg
BASE_DIR=$1
EXTRACTS_DIR=$BASEDIR/extracts

# Clone OSM Extracts repo
if [ ! -d $EXTRACTS_DIR ]; then
    git clone https://github.com/mvexel/osm-extracts.git $EXTRACTS_DIR
fi

# Install osmium requirements
sudo aptitude install zlib1g-dev libexpat1-dev libxml2-dev libgeos-dev libgeos++-dev libsparsehash-dev libprotobuf-dev protobuf-compiler libosmpbf-dev

# Get Osmium
cd $EXTRACTS_DIR/external/osmium
sudo make install

# Get osm-history-splitter
cd $EXTRACTS_DIR/external/osm-history-splitter
make
ln -s $EXTRACTS_DIR/lib/osm-history-splitter/osm-history-splitter $EXTRACTS_DIR/bin/osm-history-splitter

# Get osmconvert and osmupdate
cd EXTRACTS_DIR/bin
hash osmconvert 2>/dev/null || wget -O - http://m.m.i24.cc/osmconvert.c | cc -x c - -lz -O3 -o osmconvert
hash osmupdate 2>/dev/null || wget -O - http://m.m.i24.cc/osmupdate.c | cc -x c - -o osmupdate
