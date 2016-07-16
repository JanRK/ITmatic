FROM debian:jessie

RUN apt-get update && apt-get install --no-install-recommends -y curl wget apt-transport-https ca-certificates

RUN wget https://deb.nodesource.com/gpgkey/nodesource.gpg.key
RUN apt-key add nodesource.gpg.key
RUN echo 'deb https://deb.nodesource.com/node_0.12 jessie main' > /etc/apt/sources.list.d/nodesource.list
RUN echo 'deb-src https://deb.nodesource.com/node_0.12 jessie main' >> /etc/apt/sources.list.d/nodesource.list


RUN apt-get update && apt-get install -y git-core nodejs


RUN git clone https://github.com/crosbymichael/not-dockers-ui.git
RUN cd not-dockers-ui && npm install
RUN cd not-dockers-ui && npm install -g grunt-cli
# Make sure your Docker daemon is running
RUN cd not-dockers-ui && grunt run     # Takes a while, will build the image locally as dockerui:latest and run it
