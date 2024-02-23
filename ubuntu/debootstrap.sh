#!/bin/bash
echo "ARCH: ${ARCH}"
echo "DEB_SUITE: ${DEB_SUITE}"
echo "DEB_REPO: ${DEB_REPO}"
echo "PRE_CONF: ${PRE_CONF}"

OUTPUT_NAME="ubuntu-${DEB_SUITE}-${ARCH}-$(date '+%Y%m%d')"
INCLUDES="dbus,dbus-user-session,bash-completion,ca-certificates,curl,gnupg,locales,sudo,wget"

debootstrap \
  --arch ${ARCH} \
  --include=${INCLUDES} \
  ${DEB_SUITE} \
  /work ${DEB_REPO}

tar -C /work -czf /build/${OUTPUT_NAME}.tar.gz .
