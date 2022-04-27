#!/bin/bash

set -eu
set -o pipefail

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
BASE_DIR=$(pwd)

if [ "$*" == "" ]; then
  TEST_CONTAINER_IMAGE="$(${BIN_DIR}/full-image-name.sh)"
else
  TEST_CONTAINER_IMAGE=$1
fi

ENTRYPOINT_COMMAND="/bin/bash"
if [ "$#" -gt 1 ]; then
  ENTRYPOINT_COMMAND="$2"
fi

CINC_AUDITOR_CONTAINER_IMAGE=polymathrobotics/cinc-auditor:5.14.0
# No need to pull on every build because we're referring to a speicifc tag
PROFILE_DIR="${BASE_DIR}/../test"

CONTAINER_ID=$(docker container run --interactive --entrypoint "${ENTRYPOINT_COMMAND}" --detach $TEST_CONTAINER_IMAGE )

function cleanup()
{
  echo "==> stopping ${CONTAINER_ID}"
  docker container stop ${CONTAINER_ID}
  echo "==> removing ${CONTAINER_ID}"
  docker container rm ${CONTAINER_ID}
}

trap cleanup EXIT

echo ${CONTAINER_ID}
docker ps

# run cinc-auditor
echo "==> running cinc-auditor against ${TEST_CONTAINER_IMAGE}"
echo "==> with command: '${ENTRYPOINT_COMMAND}'"
docker container run -t --rm -v "${PROFILE_DIR}:/share" -v /var/run/docker.sock:/var/run/docker.sock ${CINC_AUDITOR_CONTAINER_IMAGE} exec . --no-create-lockfile -t docker://${CONTAINER_ID}
