#!/bin/bash
debootstrap \
  --arch $ARCH $DEB_SUITE \
  --include=dbus-user-session \
  ./work $DEB_REPO

tar -C ./work -czf /build/debian-$DEB_SUITE-$ARCH-$(date '+%Y%m%d').tar.gz .
