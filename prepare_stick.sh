#!/bin/bash
echo "This script compiles jamulus for the first time and downloads all dependencies,..."
apt install git build-essential qtdeclarative5-dev qt5-default qttools5-dev-tools libjack-jackd2-dev
# get script dir
dir="$(dirname "$(readlink -f "$0")")"
cd /tmp
git clone https://github.com/corrados/jamulus.git
cd jamulus
# compile jamulus
qmake Jamulus.pro
make clean
make

mkdir "${dir}/copyToStick/files/Jamulus/"
cp Jamulus "${dir}/copyToStick/files/Jamulus/"
