#!/bin/bash

# https://stackoverflow.com/questions/61256824/how-to-pass-the-output-of-a-bash-command-to-github-action-parameter
# https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/
# https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#environment-files

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
CONTAINERFILE_DIR=$(pwd)
DEFAULT_PLATFORMS=linux/arm64,linux/amd64,linux/arm/v7

DASEL_CONTAINER_IMAGE=polymathrobotics/dasel:1.24.1
# No need to pull image on every build because we're using a specific tag

if [[ -f "${CONTAINERFILE_DIR}/Polly.toml" ]]; then
  # Check to see if the key exists and return default if error
  docker container run --rm \
    --mount type=bind,source="$(pwd)",target=/share,readonly \
    --entrypoint /bin/bash \
    ${DASEL_CONTAINER_IMAGE} \
      -c "dasel -f Polly.toml -w json | jq --exit-status --raw-output '.container_image.platforms'" &>/dev/null || { echo "${DEFAULT_PLATFORMS}"; exit 0; }

  # Now we know the key exists, return the value
  docker container run --rm \
    --mount type=bind,source="$(pwd)",target=/share,readonly \
    --entrypoint /bin/bash \
    ${DASEL_CONTAINER_IMAGE} \
      -c "dasel -f Polly.toml -w json | jq --raw-output '.container_image.platforms | @csv'"
else
  echo "${DEFAULT_PLATFORMS}"
fi
