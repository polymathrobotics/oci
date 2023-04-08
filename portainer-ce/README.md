# portainer

This image repackages Portainer Community Edition (CE) releases from https://github.com/portainer/portainer/releases

To set up a new deployment, first create a volume that Portainer Server
will use to store its database:

```
docker volume create portainer_data
```

Then, download and install the Portainer Server container:

```
docker run \
  -d \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  --restart=always \
  --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
  --mount type=volume,source=portainer_data,target=/data,volume-driver=local \
  docker.io/polymathrobotics/portainer-ce
```

By default, Portainer generates and uses a self-signed SSL certificate to secure port 9443. Alternatively you can provide your own SSL certificate during installation or via the Portainer UI after installation is complete.

Once the installation is complete, you can log into your Portainer Server instance by opening a web browser and going to https://localhost:9443

You will be presented with the initial setup page for Portainer Server.

For more information, refer to the Portainer documentation at https://docs.portainer.io/
