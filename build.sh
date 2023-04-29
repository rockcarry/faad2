#!/bin/sh

set -e

case "$1" in
"")
    if [ ! -e $PWD/Makefile ]; then
        ./configure \
        --host=$BUILD_HOST \
        --prefix=$PROJ_INSTALL_DIR \
        --without-xmms \
        --without-drm \
        --without-mpeg4ip
    fi
    make -j8
    make install
    ;;
clean)
    make clean || true
    ;;
distclean)
    make distclean || true
    rm -rf $PWD/Makefile
    ;;
esac
