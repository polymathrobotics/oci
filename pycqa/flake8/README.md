Running flake8:

```shell
docker run -it --rm \
  --mount type=bin,source="$(pwd)",target=/code \
  polymathrobotics/flake8 .
```
