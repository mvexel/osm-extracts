osm-us-extracts
===============

keep a set of OSM PBF extracts up to date, similar to download.geofabrik.de

install
=======

You will need a beefy server (more cores = better) and lots of space (150GB at least, depending on how much of an archive you intend to keep)

* Inspect the [install script](https://github.com/mvexel/osm-extracts/blob/master/script/install.sh): 
* Run it on the target machine. You will need sudo rights.

``` bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/mvexel/osm-extracts/master/script/install.sh)" [basedir]
```

By default, this will install everything in `/extracts` but you can specify an optional `basedir` (ending in trailing slash) which will override this.

* download initial planet file into `/extracts/planet/`: `wget -O /extracts/planet/planet.osm.pbf  http://planet.openstreetmap.org/pbf/planet-latest.osm.pbf`. (If you want to test the process quickly first, you can fake it by downloading a tiny, recent planet from geofabrik, for example Antarctica: `wget -O planet/planet.osm.pbf http://download.geofabrik.de/antarctica-latest.osm.pbf`.
* edit `/extracts/script/split-current.py` and tweak `maxParallel` and `maxProcesses` to match the number of cores and memory size on your machine, see the inline documentation.

use
===

Add a line to your crontab to run `script/update-extracts.sh` daily:

```cron
0 0 * * * /data/osm-extracts/script/update-extracts.sh >> /data/osm-extracts/log/update-extracts.log
```

You can do it more often but bear in mind that the script takes a couple of hours to run even on a beefy machine.
