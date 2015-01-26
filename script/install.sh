#!/bin/bash

# exit on SIGINT
trap "exit" INT

# base dir from arg, defaults to / so the default extracts dir is /extracts
EXTRACTS_DIR=${0-/extracts}

# Install osmium requirements
sudo aptitude -yq update
sudo aptitude -yq upgrade
sudo aptitude -yq install make clang git libboost-test-dev zlib1g-dev libexpat1-dev libxml2-dev libgeos-dev libsparsehash-dev libprotobuf-dev protobuf-compiler libosmpbf-dev doxygen

# Clone OSM Extracts repo
if [ ! -d $EXTRACTS_DIR ]; then
	sudo mkdir -p $EXTRACTS_DIR
	sudo chown -R `whoami` $EXTRACTS_DIR
    git clone --recursive https://github.com/mvexel/osm-extracts.git $EXTRACTS_DIR
fi

# Get Osmium
cd $EXTRACTS_DIR/external/osmium
make doc
sudo make install

# Get osm-history-splitter
cd $EXTRACTS_DIR/external/osm-history-splitter
make
ln -s $EXTRACTS_DIR/external/osm-history-splitter/osm-history-splitter $EXTRACTS_DIR/bin/osm-history-splitter

# Get osmconvert and osmupdate
cd $EXTRACTS_DIR/bin
hash osmconvert 2>/dev/null || wget -O - http://m.m.i24.cc/osmconvert.c | cc -x c - -lz -O3 -o osmconvert
hash osmupdate 2>/dev/null || wget -O - http://m.m.i24.cc/osmupdate.c | cc -x c - -o osmupdate
