# oawn [![](https://images.microbadger.com/badges/version/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own commit badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own commit badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own image badge on microbadger.com")

**openvas-arachni-wapiti-nikto**


```
sudo docker run --rm -it --name=oawn \
  -p 9390:9390 \
  -p 9392:9392 \
  --entrypoint=/bin/bash \
  -v /media/Datos/oawn:/var/lib/openvas \
  -v /etc/localtime:/etc/localtime \
  -v /var/run/openvassd.sock:/var/run/openvassd.sock
jorgeandrada/oawn
```

## Nagios monitoring

Install ```libopenvas-dev openvas-cli```and use the binary **check_omp**.
Example:

```
check_omp -H localhost -p 9390 -u admin -w Admin_12345 --status -T 'test_casa' --last-report -v -t 30
```

<a href='https://ko-fi.com/A417UXC' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi2.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
