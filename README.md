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

## Getting started

Once you have the software installed, you can run it as follows:

- For QGIS, you can launch it with the usual launcer or from the command line

```
qgis # run QGIS
```

See the [QGIS manual](http://docs.qgis.org/2.14/en/docs/index.html)

- For R, you can run R from the bash shell by entering `R`. For beginners, RStudio is recommended, which can be opened from the Ubuntu Dash launcher or from bash with:

```
rstudio
```

[This tutorial](https://github.com/Robinlovelace/Creating-maps-in-R) provides a good starting point for working with spatial data in R.

- For Python, you need to activate the gds environment before use. Do this with from bash with: 

```
source activate gds_test # activate the environment
python
>>>
```

from there you will be in the Python shell. Test if the geographic packages work, e.g. with:

```
import geopandas
```

You can also use the IPython notebook, as described in [Python's documentation](http://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/execute.html
).

For more, see a tutorial, such as this one on [shapely from PySAL](https://pysal.readthedocs.io/en/latest/users/tutorials/shapely.html).

## Note

This is just a starter for 10. If you find it useful, please fork it and push any useful updates back to this repo or make and issue if anything goes wrong.

## Alternative projects

- [ubuntu-post-install](https://github.com/snwh/ubuntu-post-install)
- [install-tl-ubuntu](https://github.com/scottkosty/install-tl-ubuntu)

