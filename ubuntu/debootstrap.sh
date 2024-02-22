#!/bin/bash
echo "ARCH: $ARCH"
echo "DEB_SUITE: $DEB_SUITE"
echo "DEB_REPO: $DEB_REPO"

debootstrap \
  --arch $ARCH $DEB_SUITE \
  --include=dbus-user-session \
  ./work $DEB_REPO

tar -C ./work -czf /build/ubuntu-$DEB_SUITE-$ARCH-$(date '+%Y%m%d').tar.gz .
