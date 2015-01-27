#!/usr/bin/env python

# append the date to a series of files and moves them to their final destination

import sys
import os
import time
import fnmatch

dateFormat = "%y%m%d"

def usage():
    print("""Appends the current date (YYMMDD) or optionally a random string to a file's base name.
Usage: append_date.py srcdir .ext [stringtoappend]""")
    sys.exit(1)

def find_matches(directory):
    matches = []
    for root, dirnames, filenames in os.walk(in_dir):
        for filename in fnmatch.filter(filenames, "*{}".format(extension)):
            matches.append(os.path.join(root, filename))
    return matches

def append_date(basename, append_string):
    if len(append_string) == 0:
        import time
        append_string = time.strftime("%y%m%d")
    return "{}-{}".format(
        basename,
        append_string
        )	

if __name__ == "__main__":
    append_string = ""
    if not len(sys.argv) >= 3:
    	usage()
    in_dir = sys.argv[1]
    extension = sys.argv[2]
    if len(sys.argv) > 3:
        append_string = sys.argv[3]
    if not os.path.isdir(in_dir):
    	usage()
    if not extension[0] == ".":
    	usage()

    matches = find_matches(in_dir)

    for orig in matches:
        path, filename = os.path.split(orig)
        basename = filename[:-len(extension)]
        dest = os.path.join(path, append_date(basename, append_string) + extension)
        print "going to rename {orig} to {dest}".format(orig=orig, dest=dest)
        os.renames(orig, dest)