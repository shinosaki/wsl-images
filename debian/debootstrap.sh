#!/bin/bash
echo "ARCH: $ARCH"
echo "DEB_SUITE: $DEB_SUITE"
echo "DEB_REPO: $DEB_REPO"

debootstrap \
  --arch $ARCH \
  --include=dbus-user-session \
  $DEB_SUITE \
  ./work $DEB_REPO

tar -C ./work -czf /build/debian-$DEB_SUITE-$ARCH-$(date '+%Y%m%d').tar.gz .
