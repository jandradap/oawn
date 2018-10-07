# oawn [![](https://images.microbadger.com/badges/version/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own commit badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/oawn:latest.svg)](https://microbadger.com/images/jorgeandrada/oawn:latest "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own commit badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/oawn:develop.svg)](https://microbadger.com/images/jorgeandrada/oawn:develop "Get your own image badge on microbadger.com")

**openvas-arachni-wapiti-nikto** <a href='https://ko-fi.com/A417UXC'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi2.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>

Fork from <a href=https://hub.docker.com/r/mikesplain/openvas/>mikesplain/openvas</a>

```
docker run -d --name openvas \
-p 443:443 \
-p 9390:9390 \
-e OV_PASSWORD=securepassword41 \
-v $(pwd)/openvas2/mgr:/var/lib/openvas/mgr/ \
-v $(pwd)/openvas2/scap-data:/var/lib/openvas/scap-data/ \
-v $(pwd)/openvas2/plugins:/var/lib/openvas/plugins/ \
-v $(pwd)/openvas2/redis:/var/lib/redis/ \
jorgeandrada/oawn
```

#### Update NVTs
Occasionally you'll need to update NVTs. We update the container about once a week but you can update your container by execing into the container and running a few commands:
```
docker exec -it openvas openvas-update
```
Or
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
check_omp -H localhost -p 9390 -u admin -w securepassword41 --status -T 'ScanWebserver' --last-report -v -t 30
```

## Console
**List config**
```
root@0c213d9ad348:/# omp -u admin -w securepassword41 -g
8715c877-47a0-438d-98a3-27c7a6ab2196  Discovery
085569ce-73ed-11df-83c3-002264764cea  empty
daba56c8-73ec-11df-a475-002264764cea  Full and fast
698f691e-7489-11df-9d8c-002264764cea  Full and fast ultimate
708f25c4-7489-11df-8094-002264764cea  Full and very deep
74db13d6-7489-11df-91b9-002264764cea  Full and very deep ultimate
2d3f051c-55ba-11e3-bf43-406186ea4fc5  Host Discovery
bbca7412-a950-11e3-9109-406186ea4fc5  System Discovery
```

**List targets**
```
root@0c213d9ad348:/# omp -u admin -w securepassword41 -T
263f660d-1769-4111-a9c8-6937da290238  Target for immediate scan of IP 192.168.1.2

```

**List task**
```
root@0c213d9ad348:/# omp -u admin -w securepassword41 -G
ebd048a5-602b-42e8-bc44-938ccef63b13  Stopped      Immediate scan of IP 192.168.1.2
b1a3db64-f75d-4037-bcea-496aa6024f0d  New          prueba_pve
```

**Create target**
```
omp -u admin -w securepassword41 --xml '
<create_target>
<name>host_prueba</name>
<hosts>192.168.1.2</hosts>
</create_target>'
```

**Create task for a target**
```
omp -u admin -w securepassword41 -C -n New_task -c 2d3f051c-55ba-11e3-bf43-406186ea4fc5 -t $(omp -u admin -w securepassword41 -T | grep host_prueba | awk -F " " '{print$1}')

omp -u admin -w securepassword41 -X '<create_task><name>ScanWebserver</name><config id="2d3f051c-55ba-11e3-bf43-406186ea4fc5"/><target id="ec6b1b7c-bd13-4a40-b6b4-5b04ee843394"/></create_task>'
```
