#!/bin/bash

set -eu
set -o pipefail

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
BASE_DIR=$(pwd)
HADOLINT_CONTAINER_IMAGE=polymathrobotics/hadolint-amd64

lints_to_ignore=$(sed "s/#.*//" "${BIN_DIR}/hadolint-ignore" | sed '/^[[:space:]]*$/d' | sed 's/^/--ignore / ' | tr '\n' ' ')
docker container run --rm -i ${HADOLINT_CONTAINER_IMAGE} hadolint ${lints_to_ignore} - < "Containerfile"
