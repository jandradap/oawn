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
  sed -i "s/4000/9392/g" /etc/default/openvas-gsa

COPY openvas-check-setup /usr/local/bin/

# WAPITI
RUN apt-get install -y wapiti \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Nikto
ADD https://github.com/sullo/nikto/archive/2.1.6.tar.gz /tmp
RUN tar -xf /tmp/2.1.6.tar.gz -C /opt \
  && ln -s /opt/nikto-2.1.6/program/nikto.pl /usr/local/bin/nikto.pl \
  && cp /opt/nikto-2.1.6/program/nikto.conf /etc/

# ARACHNI
ENV ARACHNI_VERSION="1.5.1" ARACHNI_SUBVERSION="0.5.12"
ADD https://github.com/Arachni/arachni/releases/download/v"$ARACHNI_VERSION"/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION"-linux-x86_64.tar.gz /tmp
RUN tar -xf /tmp/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION"-linux-x86_64.tar.gz -C /opt \
  && ln -s /opt/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION" /opt/arachni \
  && cd /opt/arachni/bin/ && for i in ls *; do ln -s /opt/arachni/bin/$i /usr/local/bin/$i; done \
  && rm -rf /tmp/*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
