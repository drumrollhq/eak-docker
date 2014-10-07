FROM phusion/baseimage
MAINTAINER Joe Dytrych <joe@drumrollhq.com>

# Dependencies have dependencies.
RUN apt-get update
RUN apt-get install -y python-software-properties curl build-essential

# Node:
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

# ffmpeg:
RUN add-apt-repository ppa:jon-severinsson/ffmpeg
RUN apt-get update
RUN apt-get install -y ffmpeg
