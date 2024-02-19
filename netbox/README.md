# netbox

To get NetBox up and running run the following commands. There is a more complete
[Getting Started guide on our wiki](https://github.com/netbox-community/netbox-docker/wiki/Getting-Started)
which explains every step.

```
cd example
docker compose pull
docker compose up
```

The whole application will be available after a few minutes. Open the URL `http://0.0.0.0:8000/`
in a web-browser. You should see the NetBox homepage.

To create the first admin user run this command:

```
docker compose exec netbox /opt/netbox/netbox/manage.py createsuperuser
```

If you need to restart Netbox from an empty database often, you can also set the `SUPERUSER_*`
variables in your `docker-compose.override.yml` as shown in the example.