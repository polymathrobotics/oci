#!/bin/bash

set -eu
set -o pipefail

HADOLINT_CONTAINER_IMAGE=docker.io/polymathrobotics/hadolint:2.12.0

docker container run --rm -i \
  "${HADOLINT_CONTAINER_IMAGE}" hadolint - < "Containerfile"
