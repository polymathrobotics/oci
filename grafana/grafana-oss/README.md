grafana-oss
-----------
This image repackages grafana_OSS releases from 
https://github.com/grafana/grafana/releases

This images is based on
https://github.com/grafana/grafana/blob/main/Dockerfile.ubuntu

# Run the Grafana Docker container

Start the Docker container by binding Grafana to external port `3000`.

```bash
docker run -d --name=grafana -p 3000:3000 grafana/grafana
```

Try it out, default admin user credentials are admin/admin.

Further documentation can be found at http://docs.grafana.org/installation/docker/.

