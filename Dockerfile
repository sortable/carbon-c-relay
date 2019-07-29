FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils build-essential automake autoconf zlib1g-dev

RUN mkdir -p /opt/carbon-c-relay-build

COPY . /opt/carbon-c-relay-build

RUN \
  cd /opt/carbon-c-relay-build && \
  aclocal && \
  autoconf -i -f && \
  ./configure --with-gzip --without-ssl && \
  make && \
  cp relay /usr/bin/carbon-c-relay

EXPOSE 2003

ENTRYPOINT ["carbon-c-relay", "-f", "/etc/carbon-c-relay/carbon-c-relay.conf"]

