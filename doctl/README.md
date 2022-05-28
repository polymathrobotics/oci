Based on https://github.com/digitalocean/doctl#use-with-docker
https://hub.docker.com/r/digitalocean/doctl

It's probably a good idea to set up two environment variables:
- DIGITALOCEAN_ACCESS_TOKEN
- DIGITALOCEAN_SSH_KEY_IDS
- DIGITALOCEAN_REGION

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

Creating a Droplet
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  --env=DIGITALOCEAN_SSH_KEY_IDS \
  --env=DIGITALOCEAN_REGION \
  polymathrobotics/doctl compute droplet create ubuntu20-04 \
    --ssh-keys $DIGITALOCEAN_SSH_KEY_IDS \
    --size s-1vcpu-1gb \
    --image ubuntu-20-04-x64 \
    --region $DIGITALOCEAN_REGION \
    --enable-ipv6 \
    --enable-monitoring
```

SSH into a running instance
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  -v $HOME/.ssh/id_ed25519:/root/.ssh/id_ed25519 \
  polymathrobotics/doctl compute ssh <DROPLET_ID>
```

Listing current droplets
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  polymathrobotics/doctl compute droplet list
```

Deleting a Droplet
```
docker run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN \
  polymathrobotics/doctl compute droplet delete --force <DROPLET_ID>
```
