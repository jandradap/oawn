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

ENV ARACHNI_VERSION="1.5.1" ARACHNI_SUBVERSION="0.5.12"

# OPENVAS
RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  openvas \
  openvas-cli \
  openvas-manager \
  openvas-nasl \
  openvas-scanner

# ARACHNI
ADD https://github.com/Arachni/arachni/releases/download/v"$ARACHNI_VERSION"/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION"-linux-x86_64.tar.gz /tmp
RUN tar -xf /tmp/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION"-linux-x86_64.tar.gz -C /opt \
  && ln -s /opt/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION" /opt/arachni \
  && ln -s /opt/aranchi/bin/* /usr/local/bin/ \
  && rm -rf /tmp/*

# WAPITI
RUN apt-get install -y wapiti
