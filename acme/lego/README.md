# lego

Let's Encrypt/ACME client and library written in Go.

## Staging Environment

If you'd like to test against the Let's Encrypt staging environment before
using the production environment, use the `--server` parameter. You can
get the ACME URL for the staging environment in the docs:
https://letsencrypt.org/docs/staging-environment/

The current URL is:
`https://acme-staging-v02.api.letsencrypt.org/directory`

## Cloudflare DNS Provider

Go to the [Cloudflare dashboard](https://dash.cloudflare.com/?to=/:account/profile/api-tokens) and obtain an API Token restricted to the domain and operations
needed. Do not use the Global API Key! Certbot requires `Zone::DNS::Edit`
permissions only for the zones for which you need certificates. It is also
recommended to always set an end date on the token no longer than 90 days
from when it is issued.

Set the environment variable `CF_DNS_API_TOKEN` with the value of the token.

Or you can create a file whose contents are use the token and use the `CF_DNS_API_TOKEN_FILE`
environment variable to provide the file location.

For more information, refer to the plugin docs at https://go-acme.github.io/lego/dns/cloudflare/

## Examples

Acquire a test certificate from a staging server for example.com:
```
export CF_DNS_API_TOKEN=<your_cloudflare_api_token>
docker run --rm \
  --env CF_DNS_API_TOKEN \
  docker.io/polymathrobotics/lego \
    --accept-tos \
    --dns cloudflare \
    --server https://acme-staging-v02.api.letsencrypt.org/directory \
    --email=letsencrypt@polymathrobotics.com \
    --domains testy.polymathrobotics.dev \
    run
```

To acquire a certificate for example.com:
```
export CF_DNS_API_TOKEN=<your_cloudflare_api_token>
docker run --rm \
  --env CF_DNS_API_TOKEN \
  --mount type=bind,source=$(pwd)/etc/lego,target=/etc/lego \
  docker.io/polymathrobotics/lego \
    --accept-tos \
    --dns cloudflare \
    --email=letsencrypt@polymathrobotics.com \
    --domains testy.polymathrobotics.dev \
    --path=/etc/lego \
    run
```

To renew a certificate for example.com:
```
export CF_DNS_API_TOKEN=<your_cloudflare_api_token>
docker run --rm \
  --env CF_DNS_API_TOKEN \
  --mount type=bind,source=$(pwd)/etc/lego,target=/etc/lego \
  docker.io/polymathrobotics/lego \
    --accept-tos \
    --dns cloudflare \
    --email=letsencrypt@polymathrobotics.com \
    --domains testy.polymathrobotics.dev \
    --path=/etc/lego \
    renew
```