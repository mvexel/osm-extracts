# Install osmium requirements
sudo aptitude install zlib1g-dev libexpat1-dev libxml2-dev libgeos-dev libgeos++-dev libsparsehash-dev libprotobuf-dev protobuf-compiler libosmpbf-dev
# Clone OSM Extracts repo
if [ ! -d $[myJob/basedir] ]; then
    git clone https://github.com/mvexel/osm-extracts.git $[myJob/basedir]
fi
# Get Osmium
cd $[myJob/basedir]/lib
git clone https://github.com/joto/osmium.git
cd osmium
sudo make install
# Get osm-history-splitter
cd $[myJob/basedir]/bin
git clone https://github.com/MaZderMind/osm-history-splitter.git
cd osm-history-splitter
make
cd $[myJob/basedir]/bin
hash osmconvert 2>/dev/null || wget -O - http://m.m.i24.cc/osmconvert.c | cc -x c - -lz -O3 -o osmconvert
hash osmupdate 2>/dev/null || wget -O - http://m.m.i24.cc/osmupdate.c | cc -x c - -o osmupdate

cd osmium
sudo make install
cd ..
