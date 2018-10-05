FROM ubuntu:18.04

COPY Dockerfile /

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="oawn" \
      org.label-schema.description="openvas-arachni-wapiti-nikto" \
      org.label-schema.url="http://andradaprieto.es" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/jandradap/oawn" \
      org.label-schema.vendor="Jorge Andrada Prieto" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      maintainer="Jorge Andrada Prieto <jandradap@gmail.com>" \
      org.label-schema.docker.cmd="docker run -d --name=oawn -p 9392:9392 jorgeandrada/oawn"

ENV DEBIAN_FRONTEND=noninteractive \
  OV_PASSWORD=admin \
  PUBLIC_HOSTNAME=openvas

# OPENVAS --no-install-recommends
RUN apt-get update && apt-get install software-properties-common -y \
  && add-apt-repository ppa:mrazavi/openvas -y \
  && apt-get update \
  && apt-get install -y \
  openvas9 \
  libopenvas9-dev \
  sqlite3 \
  rsync \
  wget \
  curl \
  xsltproc \
  texlive-fonts-recommended \
  openssh-client \
  rpm \
  alien \
  nsis \
  snmp \
  net-tools \
  apt-utils \
  && apt-get install --no-install-recommends -y \
  texlive-latex-extra \
  texlive-fonts-recommended

RUN sed -i "s/bind 127.0.0.1 ::1/bind 127.0.0.1/g" /etc/redis/redis.conf \
  && echo "unixsocket /var/run/redis/redis.sock" >> /etc/redis/redis.conf \
  && echo "unixsocketperm 777" >> /etc/redis/redis.conf \
  && echo "nasl_no_signature_check = no" >> /etc/openvas/openvassd.conf \
  && mkdir /root/backup_gnupg \
  && cp -avr /var/lib/openvas/openvasmd/gnupg/* /root/backup_gnupg/

COPY openvas-gsa /etc/default/

COPY openvas-check-setup /usr/local/bin/

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
