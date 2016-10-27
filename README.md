# install-gis-ubuntu

Inspired by a post on [installing commonly needed GIS software on Ubuntu](https://medium.com/@ramiroaznar/how-to-install-the-most-common-open-source-gis-applications-on-ubuntu-dbe9d612347b) and having recently got a new computer (well, a second hand [Lenovo laptop](http://www.ebay.co.uk/sch/PC-Laptops-Netbooks/177/i.html?_from=R40&_nkw=lenovo&_dcat=177&rt=nc&_mPrRngCbx=1&_udlo=0&_udhi=200)) with Ubuntu freshly installed, I decided to make the process of installing GIS software on it as reproducible as possible.

This is not intended to replace the excellent [OSGeo Live distro](https://live.osgeo.org/en/index.html). Instead it's for people who want core GIS functionality on their existing Ubuntu machine. Core programs it includes are:

- **QGIS**, probably the most popular GUI-driven GIS in the world
- An optimised version of **R** (with BLAS libraries), a powerhouse for statistical computing
- **RStudio**, a space-aged editor for **R**
- Recent versions of **GDAL** and **GEOS** C/C++ libraries
- A tonne of R packages for working with spatial data

All this can be a pain to install manually, this script is designed to make your life easier. Any comments/suggestions: welcome

## Prerequisites

- A working installation of Ubuntu 16.04, 'Xenial'

## Installation

Fire up a terminal, e.g. with `Ctl-Alt-T`, then enter the following:

```bash
# download the file
wget https://cdn.rawgit.com/Robinlovelace/install-gis-ubuntu/master/install-gis.sh
# make it executable
chmod +x ./install-gis.sh
# execute it!
./install-gis.sh
```

If you already have github installed, this will do the trick:

```bash
# download the file
git clone git@github.com:robinlovelace/install-gis-ubuntu/
install-gis-ubuntu/install-gis.sh
```

This is just a starter for 10. If you find it useful, please fork it and push any useful updates back to this repo or make and issue if anything goes wrong.

## Alternative projects

- [ubuntu-post-install](https://github.com/snwh/ubuntu-post-install)
- [install-tl-ubuntu](https://github.com/scottkosty/install-tl-ubuntu)

