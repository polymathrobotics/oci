# Base on certbot/certbot
# https://github.com/certbot/certbot/blob/master/tools/docker/core/Dockerfile

```
docker run --rm --interactive --tty \
  --mount type=bind,source=/etc/letsencrypt,target=/etc/letsencrypt \
  --mount type=bind,source=/var/lib/letsencrypt,target=/var/lib/letsencrypt \
  polymathrobotics/certbot certonly
```
