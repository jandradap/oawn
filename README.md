# oawn [![](https://images.microbadger.com/badges/version/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own commit badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own commit badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own image badge on microbadger.com")

**openvas-arachni-wapiti-nikto**


```
sudo docker run --rm -it --name=oawn \
  -p 9390:9390 \
  -p 9392:9392 \
  --entrypoint=/bin/bash \
  -v /media/Datos/oawn/CA:/var/lib/openvas/CA \
  -v /media/Datos/oawn/cert-data:/var/lib/openvas/cert-data \
  -v /media/Datos/oawn/plugins:/var/lib/openvas/plugins \
  -v /media/Datos/oawn/private:/var/lib/openvas/private \
  -v /media/Datos/oawn/scap-data:/var/lib/openvas/scap-data \
  -v /etc/localtime:/etc/localtime \
  -v /var/run/openvassd.sock:/var/run/openvassd.sock:ro \
jorgeandrada/oawn:develop

ocker run --rm -it --name=oawn   -p 9392:9392   --entrypoint=/bin/bash   
  -v /media/Datos/oawn/CA:/var/lib/openvas/CA \
  -v /media/Datos/oawn/cert-data:/var/lib/openvas/cert-data \
  -v /media/Datos/oawn/plugins:/var/lib/openvas/plugins \
  -v /media/Datos/oawn/private:/var/lib/openvas/private \
  -v /media/Datos/oawn/scap-data:/var/lib/openvas/scap-data \

```

## Nagios monitoring

Install ```libopenvas-dev openvas-cli```and use the binary **check_omp**.
Example:

```
check_omp -H localhost -p 9390 -u admin -w Admin_12345 --status -T 'test_casa' --last-report -v -t 30
```

<a href='https://ko-fi.com/A417UXC' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi2.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>

https://linuxhint.com/openvas-ubuntu-installation-tutorial/
<!--
RUN echo "kb_location=/var/run/redis/redis.sock" > /etc/openvas/openvassd.conf \
  && echo "nasl_no_signature_check = no" >> /etc/openvas/openvassd.conf \
  && sed -i "s/bind 127.0.0.1 ::1/bind 127.0.0.1/g" /etc/redis/redis.conf \
  && echo "unixsocket /var/run/redis/redis.sock" >> /etc/redis/redis.conf \
  && echo "unixsocketperm 777" >> /etc/redis/redis.conf \
  && sed -i "s/\/tmp\/redis.sock/\/var\/run\/redis\/redis.sock/g" /etc/default/openvas-scanner \
  && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/default/openvas-manager \
  && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/default/greenbone-security-assistant \
  && chmod +x /usr/local/bin/killall

# ARACHNI #falla enlace
ENV ARACHNI_VERSION="1.5.1" ARACHNI_SUBVERSION="0.5.12"
ADD https://github.com/Arachni/arachni/releases/download/v"$ARACHNI_VERSION"/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION"-linux-x86_64.tar.gz /tmp
RUN tar -xf /tmp/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION"-linux-x86_64.tar.gz -C /opt \
  && ln -s /opt/arachni-"$ARACHNI_VERSION"-"$ARACHNI_SUBVERSION" /opt/arachni \
  && ln -s /opt/aranchi/bin/* /usr/local/bin/ \
  && rm -rf /tmp/*

# WAPITI
RUN apt-get install -y wapiti \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Nikto
ADD https://github.com/sullo/nikto/archive/2.1.6.tar.gz /tmp
RUN tar -xf /tmp/2.1.6.tar.gz -C /opt \
  && ln -s /opt/nikto-2.1.6/program/nikto.pl /usr/local/bin/nikto.pl

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"] -->
