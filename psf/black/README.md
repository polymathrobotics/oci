Running black:

```shell
docker run -it --rm \
  --mount type=bind,source="$(pwd)",target=/code \
  polymathrobotics/black .
```
