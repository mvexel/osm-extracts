osm-us-extracts
===============

keep a set of OSM PBF extracts up to date, similar to download.geofabrik.de

install
=======

* clone this repo to wherever you have lots of space (150GB at least)
* install [`osmium`](https://github.com/joto/osmium) and [`osm-history-splitter`](https://github.com/MaZderMind/osm-history-splitter)
* install osmupdate (`apt-get install osmctools` on debian / ubuntu)
* download initial planet file into `planet/`: `wget -O planet/planet.osm.pbf  http://planet.openstreetmap.org/pbf/planet-latest.osm.pbf`
* edit `script/update-extracts.sh` and set `$BASEDIR` to wherever you cloned this repo
* edit `script/split-current.py` and set `splitterCommand` to the full path to `osm-history-splitter`

use
===

Add a line to your crontab to run `script/update-extracts.sh` daily:

```cron
0 0 * * * /data/osm-extracts/script/update-extracts.sh >> /data/osm-extracts/log/update-extracts.log
```

You can do it more often but bear in mind that the script takes a couple of hours to run even on a beefy machine.
