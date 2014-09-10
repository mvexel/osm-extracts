osm-us-extracts
===============

keep a set of US and US state OSM PBF extracts up to date

install
=======

* clone this repo to wherever you have lots of space (150GB at least)
* install `osmium` and `osm-history-splitter`
* create symlink to `osm-history-splitter` in `bin/`
* download initial planet file into `planet/`
* convert planet to `o5m` format: `bin/osmconvert planet/planet-latest.osm.pbf -o=planet.o5m`
* edit `script/update-extracts.sh` and set BASEDIR to wherever you cloned this repo
* edit the files in `conf/` to point to the right directories.

use
===

Add a line to your crontab to run `script/update-extracts.sh` daily. You can do it more often but bear in mind that the script takes a couple of hours to run even on a beefy machine.
