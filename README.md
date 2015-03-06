# Play2lead build agent
Our build agent is based on [buildkite-agent](https://github.com/buildkite/docker-buildkite-agent)

## Notable changes
- Added perl for magic git-timestamp-trick
- Install docker so that we can user docker inside docker
- Updated README with --privileged mode run
- Add SSH keys as volume to the container
- Fig instead of docker-compose

# Usage:
## Preparing host
This machine has been tested on CoreOS. Using other hosts might require extra magic.

- Copy CI agent ssh key onto the machine to ~/.ssh/id_rsa
- Login to docker on container with CI credentials so that it can push
- Login to the host and run container in background(`-d`) as many times as you want.
```
docker run -e BUILDKITE_AGENT_TOKEN=xxx \
           -v /var/lib/docker:/var/lib/docker \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $HOME/.ssh:/root/.ssh \
           play2lead/build-agent
```
boot2docker is a bit trickier, because it uses TCP and TLS:


```
docker run -e BUILDKITE_AGENT_TOKEN=xxx \
           -e DOCKER_HOST="$DOCKER_HOST" \
           -e DOCKER_CERT_PATH=/certs \
           -e DOCKER_TLS_VERIFY=1 \
           -v /var/lib/docker:/var/lib/docker \
           -v ~/.boot2docker/certs/boot2docker-vm:/certs \
           -v $HOME/.ssh:/root/.ssh \
           --net=host \
           play2lead/build-agent
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
