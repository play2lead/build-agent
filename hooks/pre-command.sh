#!/bin/bash

# The `pre-command` hook will run just before your build command runs

set -e

if [[ ! -z "${BUILDKITE_DOCKER_COMPOSE_CONTAINER:-}" ]] && [[ "$BUILDKITE_DOCKER_COMPOSE_CONTAINER" != "" ]]; then
  # If user specified docker compose file we need to generate
  if [[ ! -f $BUILDKITE_DOCKER_COMPOSE_FILE ]]; then
    echo -e "$(eval "echo -e \"`<$BUILDKITE_DOCKER_COMPOSE_FILE.template`\"")" >> $BUILDKITE_DOCKER_COMPOSE_FILE
  fi
fi
