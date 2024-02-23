FROM ubuntu:latest

RUN apt update
RUN apt install -y debootstrap

COPY --chmod=755 ./debootstrap.sh /
COPY --chmod=755 ./preconf.sh /

CMD ["/debootstrap.sh"]