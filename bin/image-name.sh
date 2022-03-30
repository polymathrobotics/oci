#!/bin/bash

CONTAINERFILE_DIR=$(pwd)
IMAGE_NAME=$(basename $(pwd))

DASEL_CONTAINER_IMAGE=polymathrobotics/dasel-amd64
if [ "$(uname -s)" = Darwin ] && [ "$(uname -m)" = arm64 ]; then
  DASEL_CONTAINER_IMAGE=polymathrobotics/dasel-arm64
fi

if [[ -f "${CONTAINERFILE_DIR}/Polly.toml" ]]; then
  docker image pull ${DASEL_CONTAINER_IMAGE} > /dev/null 2>&1
  _name=$(docker container run --rm \
    --mount type=bind,source="$(pwd)",target=/share,readonly \
    ${DASEL_CONTAINER_IMAGE} \
      -f Polly.toml --null "container_image.name")

  if [ "${_name}" != "null" ]; then
    IMAGE_NAME=${_name} 
  fi
fi
echo ${IMAGE_NAME}
