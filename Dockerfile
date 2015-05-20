FROM buildkite/agent:ubuntu
RUN apt-get update && \
    apt-get install perl
RUN curl -sSL https://get.docker.com/ubuntu/ | sudo sh
# Cleanup
RUN apt-get clean autoclean apt-get autoremove -y
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/
# Install sti
RUN curl -LO https://github.com/openshift/source-to-image/releases/download/v0.5.1/source-to-image-v0.5.1-f2a6728-linux-amd64.tar.gz
RUN tar xfv source-to-image-v0.5.1-f2a6728-linux-amd64.tar.gz
RUN mv sti /usr/local/bin/
RUN chmod +x /usr/local/bin/sti
