#!/bin/bash

OPENCV_VERSION=3.4.1

export WS_DIR=`pwd`
mkdir opencv
cd opencv

# download OpenCV and opencv_contrib
wget -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
unzip opencv.zip
rm -rf opencv.zip

wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip
unzip opencv_contrib.zip
rm -rf opencv_contrib.zip

OPENCV_SRC_DIR=`pwd`/opencv-$OPENCV_VERSION
OPENCV_CONTRIB_MODULES_SRC_DIR=`pwd`/opencv_contrib-$OPENCV_VERSION/modules
#patch
patch -u -b $OPENCV_SRC_DIR/modules/python/src2/cv2.cpp cv2.patch

# build and install
cd $OPENCV_SRC_DIR
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D OPENCV_EXTRA_MODULES_PATH=$OPENCV_CONTRIB_MODULES_SRC_DIR \
  ..


make -j4			

make install
ldconfig

