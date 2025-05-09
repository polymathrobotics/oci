#!/bin/bash

set -eu -o pipefail

BIN_DIR="$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")"

matrix_test() {
  tags="$(docker buildx bake local --print 2>/dev/null | jq -r '.target[] | .tags[0]')"

  # Initialize an array to store the exit codes
  exit_codes=()

  while read -r tag; do
    echo "==> Testing ${tag}"
    if [[ -n "$2" ]]; then
      "${BIN_DIR}/test.sh" "${tag}" "$2" &
    else
      "${BIN_DIR}/test.sh" "${tag}" &
    fi
    pids+=($!)
  done <<< "${tags}"

  # Wait for all processes to finish and capture their exit codes
  for pid in "${pids[@]}"; do
    wait "$pid"
    exit_codes+=($?)
  done

  # Print the collated exit codes
  # shellcheck disable=SC2145
  echo "Exit Codes: ${exit_codes[@]}"

  # Calculate the overall exit code (e.g., 0 if all succeeded, non-zero if any failed)
  overall_exit_code=0
  for code in "${exit_codes[@]}"; do
    if [ "$code" -ne 0 ]; then
      overall_exit_code=$code
      break
    fi
  done

  # Exit with the overall exit code
  exit "$overall_exit_code"
}

matrix_build=$(docker buildx bake --print 2>/dev/null | jq 'has("group")')
if [ "${matrix_build}" = 'true' ];  then
  echo "==> Matrix build detected"
  matrix_test "$@"
else
  echo "==> Non-matrix build detected"
  "${BIN_DIR}/test.sh" "$@"
fi
