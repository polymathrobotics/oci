Based on https://github.com/digitalocean/doctl#use-with-docker
https://hub.docker.com/r/digitalocean/doctl

It's probably a good idea to set up two environment variables:
- DIGITALOCEAN_ACCESS_TOKEN
- DIGITALOCEAN_SSH_KEY_IDS

You can generate a new token via https://cloud.digitalocean.com/account/api/tokens

SSH_KEY_IDS is the Digital Ocean API numeric identifier for each ssh key, not 
the friendly string name. You can get the numeric identifier with the following
API call. It's the `id` field:
```
curl -X GET https://api.digitalocean.com/v2/account/keys -H "Authorization: Bearer $DIGITALOCEAN_ACCESS_TOKEN"
```

Many commands require user input, so it is recommend to pass the 
`--interactive` and `--tty` flags as well:

```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN \
  polymathrobotics/doctl account get
```

Listing public images
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  polymathrobotics/doctl compute image list-distribution --public
```

Listing regions
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  polymathrobotics/doctl compute region list
```

Listing image sizes/pricing
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  polymathrobotics/doctl compute size list
```

Listing current droplets
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  polymathrobotics/doctl compute droplet list
```

SSH into a running instance
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  -v $HOME/.ssh/id_ed25519:/app/.ssh/id_ed25519 \
  polymathrobotics/doctl compute ssh <DROPLET_ID>
```
```
