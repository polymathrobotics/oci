#!/bin/bash

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
CONTAINERFILE_DIR=$(pwd)
IMAGE_NAME="$(${BIN_DIR}/image-name.sh)"
CONTAINER_REGISTRY="docker.io\/polymathrobotics"
DEFAULT_TAG="${CONTAINER_REGISTRY}\/${IMAGE_NAME}"

tags="${DEFAULT_TAG}"
if [[ -f "${CONTAINERFILE_DIR}/TAGS" ]]; then
  tags=$(sed "s/#.*//" "${CONTAINERFILE_DIR}/TAGS" | sed '/^[[:space:]]*$/d' | sed "s/^/${DEFAULT_TAG}:/ ")
fi
for tag in ${tags}; do
  echo "${tag}"
done
