#!/bin/bash

if [ -z ${GITHUB_RUNNER_TOKEN+x} ]; then
  echo "GITHUB_RUNNER_TOKEN environment variable is not set"
  exit 1
fi

if [ -z ${GITHUB_ACTION_REPOSITORY+x} ]; then
  echo "GITHUB_ACTION_REPOSITORY environment variable is not set."
  exit 1
fi

/opt/github-actions-runner/config.sh --url $GITHUB_ACTION_REPOSITORY --token $GITHUB_RUNNER_TOKEN
/opt/github-actions-runner/run.sh
