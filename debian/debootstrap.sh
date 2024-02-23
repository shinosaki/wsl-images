#!/bin/bash
echo "ARCH: ${ARCH}"
echo "DEB_SUITE: ${DEB_SUITE}"
echo "DEB_REPO: ${DEB_REPO}"
echo "PRE_CONF: ${PRE_CONF}"

OUTPUT_NAME="debian-${DEB_SUITE}-${ARCH}-$(date '+%Y%m%d')"
INCLUDES="dbus,dbus-user-session"

if [[ ${PRE_CONF} == "enable" ]]; then
  OUTPUT_NAME="${OUTPUT_NAME}-preconf"

  ## https://yabutan.com/posts/201116_bash_how_to_join_array
  INCLUDES=(
    dbus
    dbus-user-session
    bash-completion
    ca-certificates
    curl
    gnupg
    locales
    sudo
    wget
  )
  INCLUDES=$(printf ",%s" "${INCLUDES[@]}")
  INCLUDES=${INCLUDES:1}
fi

debootstrap \
  --arch ${ARCH} \
  --include=${INCLUDES} \
  ${DEB_SUITE} \
  /work ${DEB_REPO}

if [[ ${PRE_CONF} == "enable" ]]; then
  ## https://stackoverflow.com/a/27921346
  cat << 'EOF' >> /work/etc/skel/.bashrc


## User Settings
# Keep working directory when cloning terminal in WSL
if command -v wslpath &> /dev/null; then
  PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'
fi
# system32
export PATH="/mnt/c/Windows/system32:$PATH"
EOF

    chroot /work /bin/bash << 'EOF'
    adduser --disabled-password --gecos "" user
    adduser user sudo

    echo -e "[boot]\nsystemd=true\n[user]\ndefault=user" > /etc/wsl.conf

    echo "Etc/UTC" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

    ## https://serverfault.com/a/801162
    LANG=en_US.UTF-8
    sed -i -e "s/# ${LANG} UTF-8/${LANG} UTF-8/" /etc/locale.gen \
    && dpkg-reconfigure -f noninteractive locales \
    && update-locale LANG=${LANG}
EOF
fi

tar -C /work -czf /build/${OUTPUT_NAME}.tar.gz .
