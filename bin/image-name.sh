#!/bin/bash

CONTAINERFILE_DIR=$(pwd)
IMAGE_NAME=$(basename $(pwd))

if [[ -f "${CONTAINERFILE_DIR}/IMAGE_NAME" ]]; then
  IMAGE_NAME=$(head -n 1 "${CONTAINERFILE_DIR}/IMAGE_NAME")
fi
echo ${IMAGE_NAME}
