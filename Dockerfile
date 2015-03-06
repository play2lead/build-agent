FROM buildkite/agent
RUN apt-get update && \
    apt-get install perl
RUN curl -sSL https://get.docker.com/ubuntu/ | sudo sh
# Cleanup
RUN apt-get clean autoclean apt-get autoremove -y
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/
# Replace fig with docker-compose
RUN sed -i.bak s/fig/docker-compose/g /etc/buildkite-agent/bootstrap.sh
