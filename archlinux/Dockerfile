FROM archlinux:latest

RUN pacman -Sy --noconfirm arch-install-scripts

COPY --chmod=755 ./pacstrap.sh /
COPY --chmod=755 ./preconf.sh /

CMD ["/pacstrap.sh"]