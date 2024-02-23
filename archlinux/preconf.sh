#!/bin/bash
echo "ARCH: ${ARCH}"
echo "REPO: ${REPO}"

OUTPUT_NAME="archlinux-${ARCH}-$(date '+%Y%m%d')"

tar -C /mnt -xzf /build/${OUTPUT_NAME}.tar.gz

cat << 'EOF' >> /mnt/etc/skel/.bashrc


## User Settings
# Keep working directory when cloning terminal in WSL
if command -v wslpath &> /dev/null; then
  PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'
fi
# system32
export PATH="/mnt/c/Windows/system32:$PATH"
EOF

arch-chroot /mnt /bin/bash << 'EOF'
useradd -m -g wheel -s /bin/bash user
echo -e "pass" | passwd user

echo -e "[boot]\nsystemd=true\n[user]\ndefault=user" > /etc/wsl.conf

ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime
hwclock --systohc

## https://serverfault.com/a/801162
LANG=en_US.UTF-8
sed -i -e "s/#${LANG} UTF-8/${LANG} UTF-8/" /etc/locale.gen \
&& locale-gen \
&& echo "LANG=${LANG}" > /etc/locale.conf
EOF

tar -C /mnt -czf /build/${OUTPUT_NAME}-preconf.tar.gz .
