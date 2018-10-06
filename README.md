# oawn [![](https://images.microbadger.com/badges/version/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own commit badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own commit badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own image badge on microbadger.com")

**openvas-arachni-wapiti-nikto**


```
docker run -d --name openvas \
-p 443:443 \
-p 9390:9390 \
-e OV_PASSWORD=securepassword41 \
-v $(pwd)/openvas:/var/lib/openvas/mgr/
jorgeandrada/oawn:develop
```

#### Update NVTs
Occasionally you'll need to update NVTs. We update the container about once a week but you can update your container by execing into the container and running a few commands:
```
docker exec -it openvas bash
## inside container
greenbone-nvt-sync
openvasmd --rebuild --progress
greenbone-certdata-sync
greenbone-scapdata-sync
openvasmd --update --verbose --progress

/etc/init.d/openvas-manager restart
/etc/init.d/openvas-scanner restart
```

## Nagios monitoring

Install ```libopenvas-dev openvas-cli```and use the binary **check_omp**.
Example:

```
check_omp -H localhost -p 9390 -u admin -w Admin_12345 --status -T 'scan_casa' --last-report -v -t 30
```

<a href='https://ko-fi.com/A417UXC' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi2.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
