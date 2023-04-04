wget https://github.com/Unidata/UDUNITS-2/archive/master.zip
unzip master.zip
cd UDUNITS-2-master
autoreconf -fi
./configure
make
sudo make install
cd ..
echo 'export UDUNITS2_XML_PATH=/usr/local/share/udunits/udunits2.xml' >> ~/.bashrc
rm -rf UDUNITS-2-master
rm master.zip
udunits2 # test it works
