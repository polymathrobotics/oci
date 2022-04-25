#!/bin/bash

# https://stackoverflow.com/questions/61256824/how-to-pass-the-output-of-a-bash-command-to-github-action-parameter
# https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/
# https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#environment-files

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
CONTAINERFILE_DIR=$(pwd)
IMAGE_NAME="$(${BIN_DIR}/image-name.sh)"
CONTAINER_REGISTRY="docker.io/polymathrobotics"
DEFAULT_TAG="${CONTAINER_REGISTRY}/${IMAGE_NAME}"
DASEL_CONTAINER_IMAGE=polymathrobotics/dasel-amd64:1.24.1
if [ "$(uname -s)" = Darwin ] && [ "$(uname -m)" = arm64 ]; then
  DASEL_CONTAINER_IMAGE=polymathrobotics/dasel-arm64:1.24.1
fi
# No need to pull image on every build because we're using a specific tag

if [[ -f "${CONTAINERFILE_DIR}/Polly.toml" ]]; then
  TOML_TAGS=$(docker container run --rm \
    --mount type=bind,source="$(pwd)",target=/share,readonly \
    --entrypoint /bin/bash \
    ${DASEL_CONTAINER_IMAGE} \
      -c "dasel -f Polly.toml -w json | jq -r '[ .container_image.tags | \"${DEFAULT_TAG}:\" + .[] ] | @csv'")
  echo "tags=${TOML_TAGS}" >> $GITHUB_ENV
else
  # echo "${DEFAULT_TAG}"
  echo "tags=${DEFAULT_TAG}" >> $GITHUB_ENV
fi
