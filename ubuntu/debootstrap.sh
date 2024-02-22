#!/bin/bash
debootstrap --arch $ARCH $DEB_SUITE ./work $DEB_REPO
tar -C ./work -czf /build/ubuntu-$DEB_SUITE-$ARCH-$(date '+%Y%m%d').tar.gz .
