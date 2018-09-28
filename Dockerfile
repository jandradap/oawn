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
      org.label-schema.docker.cmd=""

ENV DEBIAN_FRONTEND=noninteractive \
    OV_PASSWORD=admin \
    PUBLIC_HOSTNAME=openvas

# OPENVAS
RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  openvas \
  openvas-cli \
  openvas-manager \
  openvas-nasl \
  openvas-scanner

ADD config/redis.conf /etc/redis/
RUN sed -i "s/127.0.0.1/0.0.0.0/g" /etc/default/openvas-manager \
  && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/default/greenbone-security-assistant \
  && ln -s /sbin/killall5 /sbin/killall

# ARACHNI
ENV ARACHNI_VERSION="1.5.1" ARACHNI_SUBVERSION="0.5.12"
ADD https://github.com/Arachni/arachni/releases/download/v"$ARACHNI_VERSION"/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION"-linux-x86_64.tar.gz /tmp
RUN tar -xf /tmp/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION"-linux-x86_64.tar.gz -C /opt \
  && ln -s /opt/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION" /opt/arachni \
  && ln -s /opt/aranchi/bin/* /usr/local/bin/ \
  && rm -rf /tmp/*

# WAPITI
RUN apt-get install -y wapiti

# Nikto
ADD https://github.com/sullo/nikto/archive/2.1.6.tar.gz /tmp
RUN tar -xf 2.1.6.zip -C /opt \
  && ln -s /opt/nikto-2.1.6/program/nikto.pl /usr/local/bin/nikto.pl

COPY entrypoint.sh /
