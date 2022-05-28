# Based on certbot/certbot
# https://github.com/certbot/certbot/blob/master/tools/docker/core/Dockerfile

Go to the [Cloudflare dashboard](https://dash.cloudflare.com/?to=/:account/profile/api-tokens) and obtain an API Token restricted to the domain and operations
needed. Do not use the Global API Key! Certbot requires `Zone::DNS::Edit`
permissions only for the zones for which you need certificates. It is also
recommended to always set an end date on the token no longer than 90 days
from when it is issued.

Save the credentials in an ini file, such as `~/.secrets/certbot/cloudflare.ini` with `chmod 0600` permissions:
```
# ~/.secrets/certbot/cloudflare.ini
# Secret the secrets file with:
#    sudo chmod 0700 $HOME/.secrets
#    sudo chmod 0400 $HOME/.secrets/cloudflare.ini
# Cloudflare API token used by Certbot
dns_cloudflare_api_token = 0123456789abcdef0123456789abcdef0123456
```

The path to this file is provided to certbot via the `--dns-cloudflare-credentials` command-line argument. Certbot records the path to this file for use during renewal, but does not store the file's contents.

For more information, refer to the plugin docs at https://certbot-dns-cloudflare.readthedocs.io/en/stable/#credentials

## Examples

Acquire a test certificate from a staging server for example.com:
```
docker run --rm --interactive --tty \
  --mount type=bind,source=$(pwd)/etc/letsencrypt,target=/etc/letsencrypt \
  --mount type=bind,source=$(pwd)/var/lib/letsencrypt,target=/var/lib/letsencrypt \
  --mount type=bind,source=$HOME/.secrets/certbot/cloudflare.ini,target=/root/.secrets/certbot/cloudflare.ini,readonly \
  polymathrobotics/certbot-dns-cloudflare certonly \
    --test-cert \
    --dns-cloudflare \
    --dns-cloudflare-credentials /root/.secrets/certbot/cloudflare.ini \
    --email=infrastructure@polymathrobotics.com \
    --agree-tos \
    --no-eff-email \
    -d example.com
```


To acquire a certificate for example.com:
```
docker run --rm --interactive --tty \
  --mount type=bind,source=$(pwd)/etc/letsencrypt,target=/etc/letsencrypt \
  --mount type=bind,source=$(pwd)/var/lib/letsencrypt,target=/var/lib/letsencrypt \
  --mount type=bind,source=$HOME/.secrets/certbot/cloudflare.ini,target=/root/.secrets/certbot/cloudflare.ini,readonly \
  polymathrobotics/certbot-dns-cloudflare certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials /root/.secrets/certbot/cloudflare.ini \
    --email=infrastructure@polymathrobotics.com \
    --agree-tos \
    --no-eff-email \
    -d example.com
```
