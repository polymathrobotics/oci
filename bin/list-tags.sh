#!/bin/bash

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
CONTAINERFILE_DIR=$(pwd)
IMAGE_NAME="$(${BIN_DIR}/image-name.sh)"
CONTAINER_REGISTRY="docker.io/polymathrobotics"
DEFAULT_TAG="${CONTAINER_REGISTRY}/${IMAGE_NAME}"
DASEL_CONTAINER_IMAGE=polymathrobotics/dasel:1.24.1
# No need to pull image on every build because we're using a specific tag

if [[ -f "${CONTAINERFILE_DIR}/Polly.toml" ]]; then
  docker container run --rm \
    --mount type=bind,source="$(pwd)",target=/share,readonly \
    --entrypoint /bin/bash \
    ${DASEL_CONTAINER_IMAGE} \
      -c "dasel -f Polly.toml -w json | jq -r '.container_image.tags | \"${DEFAULT_TAG}:\" + .[]'"
else
  echo "${DEFAULT_TAG}"
fi
