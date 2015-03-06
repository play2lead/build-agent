# Play2lead build agent
Our build agent is based on [buildkite-agent](https://github.com/buildkite/docker-buildkite-agent)

## Notable changes
- Added perl for magic git-timestamp-trick
- Install docker so that we can user docker inside docker
- Add SSH keys as volume to the container
- Fig instead of docker-compose
- Add proxy of docker-login to build agent container
- Mount /builds directory to avoid [the issue with docker inside docker](https://github.com/buildkite/docker-buildkite-agent/issues/3)

# Usage:
## Preparing host
This machine has been tested on CoreOS. Using other hosts might require extra magic.

- Copy CI agent ssh key onto the machine to ~/.ssh/id_rsa
- Login to docker on container with CI credentials so that it can push
- Login to the host and run container in background(`-d`) as many times as you want.

### Attached
```
bash -c "`curl -sL https://raw.githubusercontent.com/play2lead/build-agent/master/scripts/run_attached.sh`"
```

### Daemonized
```
bash -c "`curl -sL https://raw.githubusercontent.com/play2lead/build-agent/master/scripts/run_daemon.sh`"
```

## Hints
To run it as a background daemon, add -d

To set agent meta-data `set -e BUILDKITE_AGENT_META_DATA=key1=val1,key2=val2`

To enable debug output `set -e BUILDKITE_AGENT_DEBUG=true`

To name the docker container (for easier management) use `--name my-agent`

To see all the env vars and options run: `docker run play2lead/build-agent buildkite-agent start --help`

And don't forget: because it's Docker, you can run as many parallel agents as your machine can handle.

## Customization
To add hooks simply copy them into /hooks:
The base image includes Ubuntu, git, the agent, and little else. If you want to add hooks, ssh keys, etc. you can easily extend the base image.

```
FROM buildkite/agent

ADD hooks/* /hooks
```
