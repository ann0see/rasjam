#!/bin/bash
echo "This script compiles jamulus for the first time and downloads all dependencies,..."
apt install git build-essential qtdeclarative5-dev qt5-default qttools5-dev-tools libjack-jackd2-dev
startdir=$(pwd)
cd /tmp
git clone https://github.com/corrados/jamulus.git
cd jamulus
qmake Jamulus.pro
make clean
make
cd $startdir
mkdir copyToStick/files/Jamulus/
cp Jamulus copyToStick/files/Jamulus/
