#!/bin/bash
echo "ARCH: ${ARCH}"
echo "REPO: ${REPO}"

OUTPUT_NAME="archlinux-${ARCH}-$(date '+%Y%m%d')"
INCLUDES="bash-completion ca-certificates curl gnupg sudo wget vim"

pacstrap /mnt base ${INCLUDES}

tar -C /mnt -czf /build/${OUTPUT_NAME}.tar.gz .
