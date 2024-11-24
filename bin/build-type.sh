#!/bin/bash

set -eu -o pipefail

json_data="$(docker buildx bake --print 2>/dev/null)"
first_build_target=$(echo "$json_data" | jq -r '.target | to_entries[0].value')
if echo "$first_build_target" | jq -e '.labels."dev.polymathrobotics.container-build-publish-action.build-type"' > /dev/null; then
  build_type=$(echo "$first_build_target" | jq -r '.labels."dev.polymathrobotics.container-build-publish-action.build-type"')
  echo "$build_type"
else
  echo "hosted"
fi
