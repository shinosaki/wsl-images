FROM debian:stable-slim

RUN apt update
RUN apt install -y debootstrap

COPY --chmod=755 ./debootstrap.sh /

CMD ["/debootstrap.sh"]