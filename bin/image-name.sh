#!/bin/bash

CONTAINERFILE_DIR=$(pwd)
IMAGE_NAME=$(basename $(pwd))
DASEL_CONTAINER_IMAGE=polymathrobotics/dasel-amd64
if [[ $(sysctl -n machdep.cpu.brand_string) =~ "Apple" ]]; then
  DASEL_CONTAINER_IMAGE=polymathrobotics/dasel-arm64
fi

if [[ -f "${CONTAINERFILE_DIR}/Polly.toml" ]]; then
  name=$(docker container run -t --rm \
    --mount type=bind,source="$(pwd)",target=/share,readonly \
    polymathrobotics/dasel-arm64 \
      -f Polly.toml --null "container_image.name")
  name=$(echo ${name} | tr -d '\r')

  if [ "${name}" != "null" ]; then
    IMAGE_NAME=${name} 
  fi
fi
echo ${IMAGE_NAME}
