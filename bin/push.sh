#!/bin/bash

set -eu
set -o pipefail

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
BASE_DIR=$(pwd)
CONTAINERFILE_DIR="${BASE_DIR}"

if [[ -z ${CONTAINER_REGISTRY_USERNAME} ]] || [[ -z ${CONTAINER_REGISTRY_PASSWORD} ]]; then
  echo "CONTAINER_REGISTRY_USERNAME and CONTAINER_REGISTRY_PASSWORD must be set in order to push"
  exit 1
fi

echo "${CONTAINER_REGISTRY_PASSWORD}" | docker login -u ${CONTAINER_REGISTRY_USERNAME} --password-stdin

tags="$(${BIN_DIR}/list-tags.sh)"
while read -r tag; do
  echo "Deploying ${tag} to dockerhub"
  docker push ${tag} | tee -a "${CONTAINERFILE_DIR}/docker_image_BUILD.log"
done <<< "${tags}"
