node_exporter
-------------
This image repackages Prometheus node_exporter releases from
https://github.com/prometheus/node_exporter/releases

The image is based on
https://github.com/prometheus/node_exporter/blob/master/Dockerfile

Image source: https://github.com/polymathrobotics/oci/tree/main/prometheus/node_exporter

Using node_exporter
-------------------
The `node_exporter` listens on HTTP port 9100 by default. See the `--help`
output for more options.

The `node_exporter` is designed to monitor the host system of a Linux
operating system setup. node_exporter requires access to the `/proc`
and `/sys` filesystems on the host. You'll need to provide extra parameters
to ensure that information is scraped from the host instead of within
the container environment.

```
docker container run -it --rm \
  --name node_exporter \
  --network host \
  --pid host \
  --cap-add=SYS_TIME \
  --mount type=bind,source=/,target=/host/root,readonly \
  --mount type=bind,source=/sys,target=/host/sys,readonly \
  --mount type=bind,source=/proc,target=/host/proc,readonly \
  polymathrobotics/node_exporter \
    --path.rootfs=/host
```
