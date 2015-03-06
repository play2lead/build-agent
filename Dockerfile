FROM buildkite/agent
RUN apt-get update && \
    apt-get install perl
RUN curl -sSL https://get.docker.com/ubuntu/ | sudo sh
# Cleanup
RUN apt-get clean autoclean apt-get autoremove -y
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/
