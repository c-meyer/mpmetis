#!/bin/bash

mkdir lib
cd metis-5.1.0
make config prefix=$PWD/../lib
make
make install
