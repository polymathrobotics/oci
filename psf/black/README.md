Running black:

```shell
docker run -it --rm \
  --mount type=bin,source="$(pwd)",target=/code \
  polymathrobotics/black .
```
