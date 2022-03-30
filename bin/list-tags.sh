#!/bin/bash

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
CONTAINERFILE_DIR=$(pwd)
IMAGE_NAME="$(${BIN_DIR}/image-name.sh)"
CONTAINER_REGISTRY="docker.io/polymathrobotics"
DEFAULT_TAG="${CONTAINER_REGISTRY}/${IMAGE_NAME}"
DASEL_CONTAINER_IMAGE=polymathrobotics/dasel-amd64
if [ "$(uname -s)" = Darwin ] && [ "$(uname -m)" = arm64 ]; then
  DASEL_CONTAINER_IMAGE=polymathrobotics/dasel-arm64
fi

docker container run -t --rm \
  --mount type=bind,source="$(pwd)",target=/share,readonly \
  polymathrobotics/dasel-arm64 \
    -f Polly.toml -w json | jq -r '.container_image.tags | .[]'
