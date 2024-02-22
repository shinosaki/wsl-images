#!/bin/bash
debootstrap --arch $ARCH $DEB_SUITE ./work $DEB_REPO
tar -C ./work -czf /build/$OUTPUT_NAME.tar.gz .