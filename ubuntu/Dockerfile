FROM ubuntu:latest

RUN apt update
RUN apt install -y debootstrap

COPY --chmod=755 ./debootstrap.sh /

CMD ["/debootstrap.sh"]