#!/bin/bash

# install non-gis specific tools
sudo apt-get install guake # guake for retro bash shell dropdown
sudo apt-get install software-properties-common # to ease adding new ppas

# from:  https://medium.com/@ramiroaznar/how-to-install-the-most-common-open-source-gis-applications-on-ubuntu-dbe9d612347b
# add repos
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib
sudo apt-get install qgis python-qgis qgis-plugin-grass
echo deb https://josm.openstreetmap.de/apt alldist universe | sudo tee /etc/apt/sources.list.d/josm.list > /dev/null
wget -q https://josm.openstreetmap.de/josm-apt.key -O- | sudo apt-key add -
sudo apt-get update
sudo apt install josm
sudo apt-get install -y gdal-bin libgdal-dev libgdal1-dev libproj-dev libgeos++-dev

# install R/RStudio - see
# http://stackoverflow.com/questions/29667330
echo "install a few dependancies for our workflow"
sudo apt-get update  -y
# sudo apt-get upgrade  -y
sudo apt-get install libgstreamer0.10-0 -y
sudo apt-get install libgstreamer-plugins-base0.10-dev -y
sudo apt-get install libcurl4-openssl-dev -y
sudo apt-get install libssl-dev -y
sudo apt-get install libopenblas-base -y
sudo apt-get install libxml2-dev -y
sudo apt-get install make -y
sudo apt-get install gcc -y
sudo apt-get install git -y
sudo apt-get install pandoc -y
sudo apt-get install libjpeg62 -y
sudo apt-get install unzip -y
sudo apt-get install curl -y
sudo apt-get install littler -y
sudo apt-get install openjdk-7-* -y
sudo apt-get install gedit -y
sudo apt-get install jags -y
sudo apt-get install imagemagick -y
sudo apt-get install docker-engine -y


echo "edit the sources file to prepare to install R"
# see http://cran.r-project.org/bin/linux/ubuntu/README
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list' # I'm using Lubuntu

echo "get keys to install R"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 # # I'm using Lubuntu

echo "install R and some helpers"
sudo apt-get update
sudo apt-get install r-base  -y
sudo apt-get install r-base-dev -y
sudo apt-get install r-cran-xml  -y
sudo apt-get install r-cran-rjava -y
sudo R CMD javareconf # for rJava

echo "install RStudio from the web"
# use daily build to get rmarkdown & latest goodies
# http://stackoverflow.com/a/15046782/1036500
# check if 32 or 64 bit and install appropriate version... 
# http://stackoverflow.com/a/106416/1036500

MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here

URL=$(wget -q -O -  http://www.rstudio.org/download/daily/desktop/ubuntu64 | grep -o -m 1 "https[^\']*" )

FILE=`mktemp`; sudo wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE

else
  # 32-bit stuff here

URL=$(wget -q -O -  http://www.rstudio.org/download/daily/desktop/ubuntu32 | grep -o -m 1 "https[^\']*" )

FILE=`mktemp`; sudo wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE
fi

echo "start R and install commonly used packages"
# http://stackoverflow.com/q/4090169/1036500
# Make an R script file to use in a moment...
LOADSTUFF="options(repos=structure(c(CRAN='http://cran.rstudio.com/')))
update.packages(checkBuilt = TRUE, ask = FALSE)
packages <- c('Rcpp', 'devtools', 'knitr', 'ggplot2', 'tidyverse') 
install.packages(packages)
# and some from github

# put that R code into an R script file
FILENAME1="loadstuff.r"
sudo echo "$LOADSTUFF" > /tmp/$FILENAME1

# Make a shell file that contains instructions in bash for running that R script file
# from the command line. There may be a simpler way, but nothing I tried worked.
NEWBASH='#!/usr/bin/env 
sudo Rscript /tmp/loadstuff.r'
FILENAME2="loadstuff.sh"

# put that bash code into a shell script file
sudo echo "$NEWBASH" > /tmp/$FILENAME2

# run the bash file to exectute the R code and install the packages
sh /tmp/loadstuff.sh
# clean up by deleting the temp file
rm /tmp/loadstuff.sh 

# more non GIS but programming stuff
sudo add-apt-repository ppa:neovim-ppa/unstable # nvim: new version of vim
sudo apt-get update # see https://github.com/neovim/neovim/wiki/Installing-Neovim
sudo apt-get install neovim
sudo apt-get install zsh # nice evolution of bash
sudo apt-get install git-core # from https://www.thinkingmedia.ca/2014/10/how-to-install-oh-my-zsh-on-ubuntu-14/
Now you can install Oh My Zsh.
sudo curl -L http://install.ohmyz.sh | sh

# done.
echo "all done"
echo "type 'sudo rstudio' in the terminal to start RStudio"

