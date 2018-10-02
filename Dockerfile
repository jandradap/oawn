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
RUN apt-get update
  && apt-get install software-properties-common -y \
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
  snmp

RUN apt-get update --no-install-recommends \
  texlive-latex-extra \
  texlive-fonts-recommended
