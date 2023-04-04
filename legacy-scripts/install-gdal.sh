#!/bin/bash
L_URL="http://download.osgeo.org/gdal/CURRENT/"
wget -O temp.html $GDAL_URL
GDAL_VERSION=`cat temp.html | grep -o -P '(?<=gdal-).*(?=.tar.gz\")'`
GDAL_FILE="gdal-"$GDAL_VERSION".tar.gz"
rm temp.html
wget $GDAL_URL$GDAL_FILE
tar zxf $GDAL_FILE
cd "gdal-"$GDAL_VERSION
./configure
make
sudo make install
cd ..
rm -rf "gdal-"$GDAL_VERSION $GDAL_FILE
