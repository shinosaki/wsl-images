#!/bin/bash
echo "ARCH: ${ARCH}"
echo "DEB_SUITE: ${DEB_SUITE}"
echo "DEB_REPO: ${DEB_REPO}"
echo "PRE_CONF: ${PRE_CONF}"

OUTPUT_NAME="debian-${DEB_SUITE}-${ARCH}-$(date '+%Y%m%d')"
## https://yabutan.com/posts/201116_bash_how_to_join_array
INCLUDES="dbus,dbus-user-session,bash-completion,ca-certificates,curl,gnupg,locales,sudo,wget"

debootstrap \
  --arch ${ARCH} \
  --include=${INCLUDES} \
  ${DEB_SUITE} \
  /work ${DEB_REPO}

tar -C /work -czf /build/${OUTPUT_NAME}.tar.gz .
