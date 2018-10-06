FROM mikesplain/openvas

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


# OPENVAS
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
