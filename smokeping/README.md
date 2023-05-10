# smokeping

SmokePing is a deluxe latency measurement tool. It can measure, store and display latency, latency distribution and packet loss. SmokePing uses RRDtool to maintain a longterm data-store and to draw pretty graphs, giving up to the minute information on the state of each network connection.

Smokeping supports measuring round trip times of ICMP pings, HTTP request latency, and DNS lookup latency. It can be customized to do other types of probes as well.

The smokeping daemon is in charge of polling, saving data to RRD files. There is a CGI script that provides the web UI at http://localhost/smokeping/smokeping.cgi

## Usage

Everything required runs in this image. Browse to http://localhost:8087 to
view latency data:

```
docker run \
  -d \
  --name=smokeping \
  -e TZ=Etc/UTC \
  -p 8087:80 \
  --restart unless-stopped \
  docker.io/polymathrobotics/smokeping
```

## Probes
This cookbook configures five standard probes, IPv4 ICMP ping
(FPing), IPv6 ICMP ping (FPing6), HTTP GET (EchoPingHttp), HTTPS GET
(EchoPingHttps), and DNS lookup (DNS).

By default the probe is ICMP ping (FPing).  This can be overridden at a
group level or individual host level.

Probes can also be added/removed by setting the appropriate attribute values
under `node['fb_smokeping']['probes']`

## How to read graphs
There's a few dimensions of data packed into Smokeping charts which make
them useful but confusing to interpret at first.

Smokeping will send X probes in a row every Y seconds. The colored bar
represents any probe loss (green/purple/red). The position of the
colored bar on the y-axis is the RTT average of the probe. The "smoke" is
the standard deviation of all the probes.

*TL;DR:*

Green line, little or tight band of smoke: no packet/probe loss, no variation
in probe RTT latency. Life is good.

Purple line, wide band of "smoke": packet/probe loss, lots of variability in
probe RTT latency. Things are not going well.

Red line: severe, if not total, packet/probe loss.

*Time units on y-axis:*
* `u` - Microseconds
* `m` - Miliseconds
* `s` - Seconds
