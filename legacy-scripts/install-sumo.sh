#!/bin/bash
wget http://sumo.dlr.de/daily/sumo-src-svn.tar.gz
tar xzf sumo-src*
cd sumo-svn
./configure
sudo make install
