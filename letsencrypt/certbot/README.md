# Base on certbot/certbot
# https://github.com/certbot/certbot/blob/master/tools/docker/core/Dockerfile

Used for utility functions. Likely you'll want to use one of the 
`certbot-dns-*` images to obtain certificates.

```
docker run --rm --interactive --tty \
  --mount type=bind,source=/etc/letsencrypt,target=/etc/letsencrypt \
  --mount type=bind,source=/var/lib/letsencrypt,target=/var/lib/letsencrypt \
  polymathrobotics/certbot
```
