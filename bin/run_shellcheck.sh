#!/bin/bash

docker container run --rm \
  --mount type=bind,source="$(pwd)",target=/share,readonly \
  docker.io/polymathrobotics/shellcheck ./*.sh
