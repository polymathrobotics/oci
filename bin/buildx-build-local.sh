#!/bin/bash

set -eu

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
BASE_DIR=$(pwd)
CONTAINERFILE_DIR="${BASE_DIR}"
IMAGE_NAME="$(${BIN_DIR}/image-name.sh)"
CONTAINER_REGISTRY="docker.io/polymathrobotics"
DEFAULT_TAG="${CONTAINER_REGISTRY}/${IMAGE_NAME}"

echo "==> Building ${DEFAULT_TAG}"
docker buildx build \
  --load \
  --file Containerfile \
  --tag "${DEFAULT_TAG}" \
  .
