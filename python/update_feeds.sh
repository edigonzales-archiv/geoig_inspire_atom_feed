#!/bin/bash

/home/stefan/Apps/kettle5/pan.sh -file=/home/stefan/Dropbox/Projekte/inspire_atom/kettle/metadb_update_av_gemeinden_timestamp.ktr >> /home/stefan/Dropbox/Projekte/inspire_atom/kettle/update_timestamp.log

/usr/bin/python2.6 /home/stefan/Dropbox/Projekte/inspire_atom/python/servicefeed.py
