#!/bin/bash

# The `pre-command` hook will run just before your build command runs

set -e

if [[ ! -z "${BUILDKITE_DOCKER_COMPOSE_CONTAINER:-}" ]] && [[ "$BUILDKITE_DOCKER_COMPOSE_CONTAINER" != "" ]]; then
  # If user specified docker compose file we need to generate
  if [[ ! -f $BUILDKITE_DOCKER_COMPOSE_FILE ]]; then
    TEMPLATE_FILE="$BUILDKITE_DOCKER_COMPOSE_FILE.template"
    if [[ -f $TEMPLATE_FILE ]]; then
      echo -e "$(eval "echo -e \"`<$TEMPLATE_FILE`\"")" >> $BUILDKITE_DOCKER_COMPOSE_FILE
      exit 0
    else
      echo "template file $TEMPLATE_FILE not found"
      exit 1
    fi
  fi
fi
