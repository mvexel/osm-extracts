#!/usr/bin/env python

# append the date to a series of files and moves them to their final destination

import sys
import os
import time
import fnmatch

dateFormat = "%y%m%d"

def usage():
    print("Usage: append_date.py srcdir destdir extension")
    sys.exit(1)

def find_matches(directory):
    matches = []
    for root, dirnames, filenames in os.walk(in_dir):
        for filename in fnmatch.filter(filenames, "*{}".format(extension)):
            matches.append(os.path.join(root, filename))
    return matches

def append_date(basename):
    import time
    return "{}-{}".format(
        basename,
        time.strftime("%y%m%d"))	

if __name__ == "__main__":
    if not len(sys.argv) == 3:
    	usage()
    in_dir = sys.argv[1]
    extension = sys.argv[2]
    if not os.path.isdir(in_dir):
    	usage()
    if not extension[0] == ".":
    	usage()

    matches = find_matches(in_dir)

    for orig in matches:
        path, filename = os.path.split(orig)
        basename = filename[:-len(extension)]
        dest = os.path.join(path, append_date(basename) + extension)
        print "going to rename {orig} to {dest}".format(orig=orig, dest=dest)
        #os.renames(orig, dest)