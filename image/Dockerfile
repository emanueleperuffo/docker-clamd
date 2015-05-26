FROM emanueleperuffo/baseimage-debian:latest
MAINTAINER Emanuele Peruffo <info@emanueleperuffo.com>

ENV HOME /root
ADD . /build

ENV FRESHCLAM_CHECKS 12

RUN /build/prepare.sh && \
	/build/services.sh && \
	/build/cleanup.sh

EXPOSE 10025

CMD ["/sbin/my_init"]