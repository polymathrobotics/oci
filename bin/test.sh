#!/bin/bash

if [ "$*" == "" ]; then
  echo "ERROR: Please provide a container name to test!"
  exit 1
fi

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
BASE_DIR=$(pwd)
TEST_CONTAINER_IMAGE=$1
CINC_AUDITOR_CONTAINER_IMAGE=polymathrobotics/cinc-auditor-amd64
if [[ $(sysctl -n machdep.cpu.brand_string) =~ "Apple" ]]; then
  CINC_AUDITOR_CONTAINER_IMAGE=polymathrobotics/cinc-auditor-arm64
fi
PROFILE_DIR="${BASE_DIR}/test"

CONTAINER_ID=$(docker container run --interactive --entrypoint /bin/bash --detach $TEST_CONTAINER_IMAGE )

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
docker container run -it --rm -v "$(pwd):/share" -v /var/run/docker.sock:/var/run/docker.sock ${CINC_AUDITOR_CONTAINER_IMAGE} exec ./test --no-create-lockfile -t docker://${CONTAINER_ID}
