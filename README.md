# Install tools for geocomputation, research and fun on Ubuntu


- [Prerequisites](#prerequisites)
- [Install key packages](#install-key-packages)
  - [GitHub’s gh CLI](#githubs-gh-cli)
    - [Setting up Git](#setting-up-git)
    - [dra](#dra)
  - [R and RStudio](#r-and-rstudio)
    - [Rapid install of R packages](#rapid-install-of-r-packages)
  - [VS Code](#vs-code)
    - [Positron: a VS Code-compatible
      IDS](#positron-a-vs-code-compatible-ids)
    - [Executing bash commands in VS
      Code](#executing-bash-commands-in-vs-code)
    - [Installing key VS Code
      extensions](#installing-key-vs-code-extensions)
    - [Creating documents with Quarto](#creating-documents-with-quarto)
    - [LaTeX](#latex)
  - [Docker](#docker)
    - [Post installation steps for
      Docker](#post-installation-steps-for-docker)
    - [Running devcontainer with VS
      code](#running-devcontainer-with-vs-code)
    - [Running a docker container](#running-a-docker-container)
  - [QGIS](#qgis)
  - [Rust](#rust)
- [Getting started with tools for
  geocomputation](#getting-started-with-tools-for-geocomputation)
- [Other tools for boosting productivity and developer
  experience](#other-tools-for-boosting-productivity-and-developer-experience)
  - [Rust command-line utilities](#rust-command-line-utilities)
    - [ripgrep](#ripgrep)
    - [fd](#fd)
    - [sd](#sd)
    - [exa](#exa)
    - [dust](#dust)
    - [ripgrep_all](#ripgrep_all)
  - [CopyQ](#copyq)
  - [AppImage Launcher](#appimage-launcher)
  - [LogSeq](#logseq)
  - [Zotero](#zotero)
    - [Make Zotero available to the
      launcher](#make-zotero-available-to-the-launcher)
  - [guake](#guake)
  - [Deno](#deno)
  - [nvm](#nvm)
  - [Claude code](#claude-code)
  - [Signal](#signal)
- [1. Install our official public software signing
  key:](#1-install-our-official-public-software-signing-key)
- [2. Add our repository to your list of
  repositories:](#2-add-our-repository-to-your-list-of-repositories)
- [3. Update your package database and install
  Signal:](#3-update-your-package-database-and-install-signal)
  - [Chrome](#chrome)
  - [Edge](#edge)
  - [Flatpak](#flatpak)
  - [KmCaster](#kmcaster)
  - [Syncthing](#syncthing)
  - [Dropox](#dropox)
  - [Rclone](#rclone)
  - [Peak](#peak)
  - [Discord](#discord)
  - [Slack](#slack)
  - [OneDrive](#onedrive)
  - [OnlyOffice](#onlyoffice)
- [Positron](#positron)
  - [Move your home directory to a separate
    partition](#move-your-home-directory-to-a-separate-partition)
- [Alternative projects](#alternative-projects)

Inspired by a post on [installing commonly needed GIS software on
Ubuntu](https://medium.com/@ramiroaznar/how-to-install-the-most-common-open-source-gis-applications-on-ubuntu-dbe9d612347b)
and having recently got a new computer (an Entroware Proteus, a bit
faster than the second hand [Lenovo
laptop](http://www.ebay.co.uk/sch/PC-Laptops-Netbooks/177/i.html?_from=R40&_nkw=lenovo&_dcat=177&rt=nc&_mPrRngCbx=1&_udlo=0&_udhi=200)
I was running when I created this repo!) with Ubuntu freshly installed,
I decided to make the process of installing GIS software on it as
reproducible as possible. After installing this software your computer
may look a bit like this:

![](vscode-qgis-editing.png)

Clutter for demo purposes!

This is not intended to replace the excellent [OSGeo Live
distro](https://live.osgeo.org/en/index.html), which contains a ton of
amazing geo packages. Instead it’s for people who want lean, core GIS
functionality on their existing Ubuntu machine, with a focus on
geocomputation and data science.

Rather than providing automated scripts, it simply provides the bash
commands here in the README for you to copy, paste (or Ctrl+Shift+Enter
if in RStudio if you download this README, a great shortcut) Core
programs it shows how to install are:

- GitHub’s CLI tool for command-line collaboration and code sharing
- **R** with access to pre-compiled packages, a powerhouse for
  statistical computing
- R packages for working with spatial data
- **RStudio**, a space-aged editor for **R**
- VS Code with extensions for R, Python, C/C++, Rust, Docker, and more
- Docker, which gives ultimate power and flexibility to install and run
  software
- **QGIS**, probably the most popular GUI-driven GIS in the world
- Recent versions of **GDAL** and **GEOS** C/C++ libraries
- Python packages for Geographic Data Science
- Rust, an upcoming systems language with impressive geo libs

All this can be a pain to install manually. The commands below are
designed to make your life easier. Any comments/suggestions: welcome

## Prerequisites

- A working installation of Ubuntu 22.04, ‘Jammy Jellyfish’ on a
  computer you have access to

# Install key packages

Fire up a terminal, e.g. with `Ctl-Alt-T` after booting Ubuntu, then
enter the following. (You can also run this from inside an editor):

``` bash
ls
```

``` r
ls()
```

## GitHub’s gh CLI

GitHub has developed a command line interface (CLI) tool for enabling
fast and intuitive interaction with the world’s premier code hosting
platform. It’s a good place to start because it’s small, self-contained,
and can be used to clone code repos like this one. Install it with the
following cryptic commands from the project’s [GitHub
page](https://github.com/cli/cli/blob/trunk/docs/install_linux.md):

``` bash
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

Test to see if it works as follows:

``` sh
# Log-in to GitHub from the command line
gh auth login
gh repo clone Robinlovelace/install-geocomp-ubuntu
cd install-geocomp-ubuntu 
less README.md
```

You may also want to update your Git version, which is installed by
default on Ubuntu:

``` bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
```

Previously I was on Git 2.25.1, now I’m on 2.40.0:

``` bash
git --version
```

    git version 2.49.0

### Setting up Git

Setup git with the following commands

``` bash
git config --global user.email "test@test.org.uk"
git config --global user.name "trachelium"
# Set the default branch to main:
git config --global init.defaultBranch main
```

### dra

``` bash
wget $(curl -s https://api.github.com/repos/devmatteini/dra/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4) -O /tmp/dra.deb
sudo dpkg -i /tmp/dra.deb
```

That allows you to download assets with commands such as:

``` bash
# Automatically select and download an asset based on your operating system and architecture
# you can use -a or --automatic
dra download -a devmatteini/dra-tests
```

## R and RStudio

I have become a huge fan of VS Code and installing it plus some amazing
extensions is covered in the next section. VS Code is increasingly good
with decent support for visualisations and, as the screenshot below
shows, even now marks-up markdown outputs from Quarto documents.
However, if you want to do standard data science things and create
reproducible documents, R+RStudio is hard to beat, especially if you’re
just starting out with data science. Install them with the following
commands:

These instructions are from https://github.com/eddelbuettel/r2u

First add the repository key so that `apt` knows it (this is optional
but recommended)

``` sh
sudo -i
apt update -qq && apt install --yes --no-install-recommends wget \
    ca-certificates gnupg
wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc \
    | tee -a /etc/apt/trusted.gpg.d/cranapt_key.asc
echo "deb [arch=amd64] https://r2u.stat.illinois.edu/ubuntu jammy main" \
     > /etc/apt/sources.list.d/cranapt.list

apt update -qq

wget -q -O- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
    | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
echo "deb [arch=amd64] https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" \
    > /etc/apt/sources.list.d/cran_r.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
    67C2D66C4B1D4339 51716619E084DAB9
apt update -qq
DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends \
    r-base-core

echo "Package: *" > /etc/apt/preferences.d/99cranapt
echo "Pin: release o=CRAN-Apt Project" >> /etc/apt/preferences.d/99cranapt
echo "Pin: release l=CRAN-Apt Packages" >> /etc/apt/preferences.d/99cranapt
echo "Pin-Priority: 700"  >> /etc/apt/preferences.d/99cranapt

apt install --yes --no-install-recommends python3-{dbus,gi,apt}
## Then install bspm (as root) and enable it, and enable a speed optimization
# Rscript -e 'install.packages("bspm")'
# RHOME=$(R RHOME)
# echo "suppressMessages(bspm::enable())" >> ${RHOME}/etc/Rprofile.site
# echo "options(bspm.version.check=FALSE)" >> ${RHOME}/etc/Rprofile.site
# exit # back to default user
```

### Rapid install of R packages

A difference between R packages on Windows and Ubuntu is that by default
Windows always installs binary versions of packages, meaning no
compilation time. To speed-up installation of R packages you can add an
Ubuntu repo that will allow you to install pre-compiled packages from
the system command line. Although there are projects like
[r2u](https://github.com/eddelbuettel/r2u) that give you binary packages
with `install.packages()` I prefer the control of using the system
command line for binaries and the R console for installing packages that
want to be compiled, to avoid issues like this:
https://github.com/rocker-org/rocker-versioned2/issues/631

Get a load of great R packages with the following commands:

``` bash
# System deps for cartography
sudo apt install -y libgdal-dev libproj-dev libgeos-dev libudunits2-dev libv8-dev libnode-dev libcairo2-dev libnetcdf-dev
sudo apt install -y libglu1-mesa-dev freeglut3-dev mesa-common-dev
sudo apt install libharfbuzz-dev libfribidi-dev 
# Extra packages for image manipulation
sudo apt install -y libmagick++-dev libjq-dev libv8-dev libprotobuf-dev protobuf-compiler libsodium-dev imagemagick libgit2-dev
# rspatial
sudo apt install r-cran-sf r-cran-terra r-cran-mapedit r-cran-tmap r-cran-mapdeck r-cran-shinyjs 
Rscript -e 'install.packages("languageserver")'
```

RStudio:

``` bash
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.03.0-386-amd64.deb
sudo dpkg -i rstudio*
rm -v rstudio*
```

After installing RStudio you can open it by pressing the ‘Windows
button’ and they typing RStudio. You should also be able to open it with
the following command in the terminal:

``` bash
rstudio
```

After opening RStudio you can open the folder containing these
instructions, or any folder, with the following command typed into the R
console.

``` r
rstudioapi::openProject("~/Download/install-geocomp-ubuntu/")
```

Also in RStudio you can commit and push changes to this or any repo as
follows, starting by opening a terminal by clicking on the Terminal
button or by typing the shortcut: `Alt+Shift+M`. You can also execute
lines of code from the source editor in RStudio in the terminal by
typing `Ctrl+Alt+Enter`, which will send the current line of code to the
terminal.

``` bash
git status
git commit -am 'Update instructions with info on using RStudio'
```

## VS Code

VS Code is a versatile and future-proof IDE.

``` bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
rm packages.microsoft.gpg
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt-get install code
code --install-extension ms-vscode-remote.remote-containers
# Install the Python extension:
code --install-extension ms-python.python
# Remote containers:
code --install-extension ms-vscode-remote.remote-containers
# Install ritwickdey.LiveServer:
code --install-extension ritwickdey.LiveServer
```

### Positron: a VS Code-compatible IDS

Get the latest pre-release with:

``` bash
# Manually:
# wget https://github.com/posit-dev/positron/releases/download/2025.01.0-39/Positron-2025.01.0-39.deb -O /tmp/positron.deb
# sudo dpkg -i /tmp/positron.deb
# Automatically:
# Find latest release:
curl https://github.com/posit-dev/positron/releases | grep "positron/releases/tag" | grep -oP '(?<=tag/)[^"]+' | head -n 1 | xargs -I {} wget https://github.com/posit-dev/positron/releases/download/{}/Positron-2025.01.0-39.deb -O /tmp/positron.deb
sudo dpkg -i /tmp/positron.deb
```

### Executing bash commands in VS Code

A great feature of VS Code is that you can execute bash commands in the
integrated terminal. Open the integrated terminal by typing the
shortcut: `Ctrl+J`. Open a new terminal in VS code by typing the
shortcut: `Ctrl+backtick`(\`).

Executing code is made even easier by the Quarto extension for VS Code,
which can be installed as follows from bash:

``` bash
code --install-extension quarto.quarto
```

After that extension has been installed you should be able to execute
code in the integrated terminal by typing `Ctrl+Enter` in the source
editor, as shown in the following screenshot:

![](run-cells.png)

### Installing key VS Code extensions

``` bash
code --install-extension reditorsupport.r
code --install-extension github.copilot
```

### Creating documents with Quarto

Install the Quarto command line tool:

``` bash
wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.27/quarto-1.7.27-linux-amd64.deb -O /tmp/quarto.deb
sudo dpkg -i /tmp/quarto.deb
```

Install the Quarto R package:

``` bash
Rscript -e "remotes::install_github('quarto-dev/quarto-r')"
```

VS Code has a nice feature that enables you to develop inside a
‘devcontainer’. Devcontainers rely on Docker, which can be installed as
follows:

### LaTeX

``` bash
# make sure perl is properly installed (e.g., apt install -y perl)
perl -mFile::Find /dev/null
# then install TinyTeX
wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh
```

## Docker

Docker is a system platform that allows you to run applications in
isolated environments called containers. Containers are similar to
virtual machines, but they are more lightweight and efficient.

Docker allows you to run applications in a sandboxed environment, which
is useful for reproducibility and security. In essence: run anything,
anywhere.

Following instructions from
https://docs.docker.com/engine/install/ubuntu/, first install the
dependencies:

``` bash
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

Then follow these commands:

``` bash
curl -fsSL https://test.docker.com -o test-docker.sh
sudo sh test-docker.sh
```

### Post installation steps for Docker

The following steps enable you to run docker without `sudo`. As outlined
at https://docs.docker.com/engine/install/linux-postinstall/ this does
have security implications so it may be unwise to run these commands on
important production servers or critical infrastructure. For a personal
laptop that does not contain sensitive information the risks are low.

``` bash
sudo groupadd docker
# Add your user to the docker group:
sudo usermod -aG docker $USER

# Log out and log back in so that your group membership is re-evaluated.
# If you’re running Linux in a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.
# You can also run the following command to activate the changes to groups:
newgrp docker

# Verify that you can run docker commands without sudo.
docker run hello-world

# If you initially ran Docker CLI commands using sudo before adding your user to the docker group, you may see the following error:
# WARNING: Error loading config file: /home/user/.docker/config.json -
# stat /home/user/.docker/config.json: permission denied

# This error indicates that the permission settings for the ~/.docker/ directory are incorrect, due to having used the sudo command earlier.

# To fix this problem, either remove the ~/.docker/ directory (it’s recreated automatically, but any custom settings are lost), or change its ownership and permissions using the following commands:

sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
```

### Running devcontainer with VS code

To check your `code` and `docker` installations worked you can try to
reproduce Geocomputation with Python:

``` bash
gh repo clone geocompx/geocompy
code geocompy
```

If you installed the `remote-containers` extension successfully, you
should see a button with “Reopen in Container” in the bottom right of VS
Code.

Click that button and you’ll see the devcontainer launch. If it works,
you can try reproducing the entirety of the book from the command line
with the following inside VS Code (you can launch the terminal by
pressing Ctrl+J\`):

``` bash
quarto preview
```

If you see something like this, congratulations, you can develop almost
anything in reproducible and easy-to-use devcontainers!

![](vscode-devcontainer.png)

### Running a docker container

The following launches a docker container with JupyterLab:

``` bash
docker run -it --rm \
  -p 8888:8888 \
  -u root \
  -v "${PWD}/jupyterlab-jovyan":/home/jovyan \
  -e NB_UID=$(id -u) \
  -e NB_GID=$(id -g) \
  -e CHOWN_HOME=yes \
  -e CHOWN_HOME_OPTS='-R' \
  glcr.b-data.ch/jupyterlab/r/geospatial
```

## QGIS

From: https://github.com/geocompx/docker/blob/master/qgis/Dockerfile

``` bash
# To use the qgis archive you have to first add the archive’s repository public key:
wget https://download.qgis.org/downloads/qgis-archive-keyring.gpg
gpg --no-default-keyring --keyring ./qgis-archive-keyring.gpg --list-keys

# After you have verified the output you can install the key with:
sudo mkdir -m755 -p /etc/apt/keyrings  # not needed since apt version 2.4.0 like Debian 12 and Ubuntu 22 or newer
sudo cp qgis-archive-keyring.gpg /etc/apt/keyrings/qgis-archive-keyring.gpg

# Alternatively you can download the key directly without manual verification:

# Types: deb deb-src
# URIs: *repository*
# Suites: *codename*
# Architectures: amd64
# Components: main
# Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg

# With the keyring in place you can add the repository as /etc/apt/sources.list.d/qgis.sources with following content:

# Types: deb deb-src
# URIs: https://qgis.org/ubuntu-ltr
# Suites: jammy
# Architectures: amd64
# Components: main
# Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg

sudo vim /etc/apt/sources.list.d/qgis.sources

# After that type the commands below to install QGIS:

sudo apt update
sudo apt install qgis qgis-plugin-grass

# In case you would like to install QGIS Server, type:
sudo apt install qgis-server --no-install-recommends --no-install-suggests
# if you want to install server Python plugins
sudo apt install python3-qgis




sudo apt-get update
sudo apt-get -y --with-new-pkgs upgrade && \
  sudo apt-get -y autoremove && \
  sudo apt-get -y install qgis qgis-plugin-grass saga

# for how to use the qgis-plugin-manager, see https://github.com/3liz/qgis-plugin-manager
pip3 install qgis-plugin-manager
# to enable the qgis-plugin-manager, add the corresponding path to PATH
# ENV PATH="/home/rstudio/.local/bin:$PATH"
echo "export PATH=\"/home/rstudio/.local/bin:\$PATH\"" >> /etc/profile
# from the next line onwards we have trouble with the rstudio server, therefore we switch to the rstudio user
mkdir -p /home/rstudio/.local/share/QGIS/QGIS3/profiles/default/python/plugins
ENV QGIS_PLUGINPATH=/home/rstudio/.local/share/QGIS/QGIS3/profiles/default/python/plugins
echo 'export QGIS_PLUGINPATH=/home/rstudio/.local/share/QGIS/QGIS3/profiles/default/python/plugins' >> /etc/profile
less /etc/profile
exit
qgis-plugin-manager init
qgis-plugin-manager update
# install SAGA next generation plugin
qgis-plugin-manager install 'Processing Saga NextGen Provider'
Rscript -e "install.packages('remotes')" 
Rscript -e "remotes::install_github('r-spatial/qgisprocess')" 
```

## Rust

``` bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Make Rust available:
source "$HOME/.cargo/env"
# Try installing a crate:
cargo install geo
cargo install geozero
cargo install zonebuilder
```

# Getting started with tools for geocomputation

Once you have the software installed, you can run it as follows:

- For QGIS, you can launch it with the usual launcher or from the
  command line

<!-- -->

    qgis # run QGIS

See the [QGIS manual](https://docs.qgis.org/latest/en/docs/index.html)

- For R, you can run R from the bash shell by entering `R`. For
  beginners, RStudio is recommended, which can be opened from the Ubuntu
  Dash launcher or from bash with:

<!-- -->

    rstudio

# Other tools for boosting productivity and developer experience

## Rust command-line utilities

These are some fast and versatile command-line utilities that provide an
alternitive to standard Unix tools.

### ripgrep

ripgrep is a line-oriented search tool that recursively searches your
current directory for a regex pattern. It is similar to other popular
search tools like The Silver Searcher, ack, and grep.

``` bash
sudo apt install ripgrep
rg --help
```

### fd

fd is a simple, fast and user-friendly alternative to find.

``` bash
sudo apt install fd-find
fdfind --help
```

### sd

[sd](https://github.com/chmln/sd) is a find & replace CLI (command-line
interface) tool that allows you to perform simple find & replace
operations on files.

``` bash
cargo install sd
sd --help
```

### exa

exa is a modern replacement for ls. It supports colors, file icons, git
integration, and more.

``` bash
cargo install exa
exa .
```

### dust

dust is a more intuitive version of du in rust. It provides a better way
to navigate through your system and view disk usage.

``` bash
cargo install du-dust
dust --help
```

### ripgrep_all

ripgrep_all is a tool that combines the power of ripgrep for all file
formats.

``` bash
sudo apt install build-essential pandoc poppler-utils ffmpeg ripgrep cargo
cargo install --locked ripgrep_all
```

## CopyQ

``` bash
sudo add-apt-repository ppa:hluk/copyq
```

Install CopyQ by running the following command:

``` bash
sudo apt install copyq
```

This command installs the latest version of CopyQ and its dependencies
on your system.

Once the installation is complete, you can launch CopyQ by typing copyq
in the terminal or by searching for it in the Applications menu.

## AppImage Launcher

Intuitive and time-saving management of AppImages.

``` bash
snap install logseq
```

## LogSeq

LogSeq is an application for storing notes, todo lists, and more. To
install it just click on the latest ‘.AppImage’ file in the latest
releases, download it, and it should be integrated by AppImage Launcher:
https://github.com/logseq/logseq/releases

## Zotero

``` bash
wget -O zotero.tar.bz2 'https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64'
tar -xjf zotero.tar.bz2 -C ~/Downloads/
sudo mv ~/Downloads/Zotero_linux-x86_64 /opt/Zotero
sudo ln -s /opt/Zotero/zotero /usr/local/bin/
sudo apt-get install libdbus-glib-1-2 libgtk-3-0 libxt6 libxrender1 libx11-xcb1
```

Run Zotero with:

``` bash
zotero
```

### Make Zotero available to the launcher

``` bash
cd /usr/share/applications
sudo bash -c 'echo "[Desktop Entry]
Version=1.0
Name=Zotero
GenericName=Reference Manager
Comment=Zotero Reference Manager
Exec=/opt/Zotero/zotero %U
Terminal=false
Type=Application
Icon=/opt/Zotero/chrome/icons/default/default256.png
Categories=Office;" > zotero.desktop'
sudo chmod +x zotero.desktop
cd -
```

## guake

``` bash
sudo apt install guake
```

See instructions here to get it working on Wayland:
https://github.com/Guake/guake/issues/2127

## Deno

``` bash
curl -fsSL https://deno.land/x/install/install.sh | sh
```

## nvm

``` bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
```

## Claude code

``` bash
npm install -g @anthropic-ai/claude-code
```

## Signal

Signal is an app for messaging and more.

\`\`\`jjoako# NOTE: These instructions only work for 64-bit Debian-based
\# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key:

wget -O- https://updates.signal.org/desktop/apt/keys.asc \| gpg –dearmor
\> signal-desktop-keyring.gpg cat signal-desktop-keyring.gpg \| sudo tee
/usr/share/keyrings/signal-desktop-keyring.gpg \> /dev/null

# 2. Add our repository to your list of repositories:

echo ‘deb \[arch=amd64
signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg\]
https://updates.signal.org/desktop/apt xenial main’ \|  
sudo tee /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install Signal:

sudo apt update && sudo apt install signal-desktop


    ## Flameshot

    Flameshot is a powerful yet simple to use screenshot software.



    ::: {.cell}

    ```{.bash .cell-code}
    sudo apt install flameshot

:::

## Chrome

``` bash
# Add the Google Chrome repository to your system
echo "Adding Google Chrome repository..."
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Update your package list
echo "Updating package list..."
sudo apt-get update

# Install Google Chrome
echo "Installing Google Chrome..."
sudo apt-get install google-chrome-stable -y

echo "Google Chrome installation complete."
```

## Edge

``` bash
# Add the Microsoft Edge repository to your system
echo "Adding Microsoft Edge repository..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
sudo install -o root -g root -m 644 microsoft.asc.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
rm microsoft.asc.gpg

# Update your package list
echo "Updating package list..."
sudo apt-get update

# Install Microsoft Edge
echo "Installing Microsoft Edge..."
sudo apt-get install microsoft-edge-dev -y

echo "Microsoft Edge installation complete."
```

## Flatpak

``` bash
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## KmCaster

``` bash
# Enable repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Install dependencies
flatpak-builder build-dir com.whitemagicsoftware.kmcaster.yaml --force-clean --install-deps-only --install-deps-from flathub
# Build and install
flatpak-builder build-dir com.whitemagicsoftware.kmcaster.yaml --install --user --force-clean
# Run it
flatpak run --user com.whitemagicsoftware.kmcaster
```

## Syncthing

Syncthing is a great way to synchronize laptops, phones and other
devices. I use it for syncing photos onto my laptop and into family
photo albums, as shown below.

![](syncthing.png)

``` bash
sudo apt install syncthing
```

## Dropox

See
https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2024.04.17_amd64.deb

``` bash
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2024.04.17_amd64.deb -O /tmp/dropbox.deb
sudo dpkg -i /tmp/dropbox.deb

# gpg signature support:
sudo apt install python3-gpg
```

## Rclone

`rclone` is a tool for copying and syncing files between computers. It
offers several advantages over rsync, including:

1.  Support for more cloud storage providers: Rclone supports a wide
    range of cloud storage providers, including Dropbox, Google Drive,
    Amazon S3, Microsoft OneDrive, Box, among others. In contrast, rsync
    only supports local, networked, or remote file transfer.

2.  Encryption and compression: Rclone supports several encryption
    methods and compression algorithms to secure and reduce the size of
    data during transfer. Rsynd doesn’t have native support for
    encryption and compression.

3.  Synchronization: Rclone has a built-in synchronization tool that
    allows you to keep your files and directories in sync across
    different storage locations. While rsync can be used for
    synchronization, it requires a bit more setup and configuration.

4.  Multi-threaded transfers: Rclone can upload and download files using
    multiple threads simultaneously, which can significantly speed up
    the transfer process. Rsynce is limited to single-threaded
    transfers.

5.  Cross-platform compatibility: Rclone is a cross-platform tool that
    can be run on Windows, Linux, macOS, and other operating systems.
    Rsync, on the other hand, is primarily a Unix-based tool and may
    require additional setup on non-Unix systems.

Install it with:

``` bash
sudo apt install rclone
```

## Peak

Install the screenshare-to-GIF tool Peak with the following commands on
Ubuntu:

``` bash
# Install simple screen recorder on ubuntu:
sudo apt install simplescreenrecorder
```

## Discord

Download discord from https://discord.com/download and install it with:

``` bash
sudo apt install libgconf-2-4 libc++1
sudo dpkg -i discord.deb
```

## Slack

``` bash
sudo snap install slack --classic
```

## OneDrive

https://github.com/abraunegg/onedrive/blob/master/docs/ubuntu-package-install.md

``` bash
rm -rf /var/lib/dpkg/lock-frontend
rm -rf /var/lib/dpkg/lock
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean -y
```

https://github.com/abraunegg/onedrive/blob/master/docs/ubuntu-package-install.md#distribution-ubuntu-2204

``` bash
wget -qO - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_24.04/Release.key | gpg --dearmor | sudo tee /usr/share/keyrings/obs-onedrive.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/obs-onedrive.gpg] https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_24.04/ ./" | sudo tee /etc/apt/sources.list.d/onedrive.list
sudo apt-get update
sudo apt install --no-install-recommends --no-install-suggests onedrive
```

## OnlyOffice

``` bash
sudo apt install gdebi
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
sudo dpkg -i onlyoffice-desktopeditors_amd64.deb
```

# Positron

Positron is an IDE for data science.

Get the latest release for your system from
https://github.com/posit-dev/positron/

``` bash
wget https://cdn.posit.co/positron/dailies/deb/x86_64/Positron-2025.04.0-64-x64.deb -O /tmp/positron.deb
sudo dpkg -i /tmp/positron.deb
```

## Move your home directory to a separate partition

It’s good practice to keep your home directory on a separate partition.

See
[here](https://www.howtogeek.com/442101/how-to-move-your-linux-home-directory-to-another-hard-drive/)
for instructions on how to do that.

# Alternative projects

- [ubuntu-post-install](https://github.com/snwh/ubuntu-post-install)
- [install-tl-ubuntu](https://github.com/scottkosty/install-tl-ubuntu)
