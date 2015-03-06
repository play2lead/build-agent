#!/bin/bash
docker run -e BUILDKITE_AGENT_TOKEN=xxx \
           -v /var/lib/docker:/var/lib/docker \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $HOME/.ssh:/root/.ssh \
           -v $HOME/.dockercfg:/root/.dockercfg \
           play2lead/build-agent
