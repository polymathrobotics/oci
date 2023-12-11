#  terraform

```
docker run -it --rm \
  --env PAPERSPACE_API_KEY \
  --mount type=bind,source="$(pwd)",target=/terraform \
  --entrypoint /bin/bash \
  docker.io/polymathrobotics/terraform
```
