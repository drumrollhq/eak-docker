FROM phusion/baseimage
MAINTAINER Joe Dytrych <joe@drumrollhq.com>

# Dependencies have dependencies.
RUN apt-get update
RUN apt-get install -y python-software-properties curl build-essential git fontconfig

# Node:
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

# ffmpeg:
RUN add-apt-repository ppa:jon-severinsson/ffmpeg
RUN apt-get update
RUN apt-get install -y ffmpeg

# Build tools:
RUN npm install -g gulp bower

# Copy over files, etc.
ADD ./ /build_tmp

# Game
WORKDIR /build_tmp/game
RUN npm install

# Fix imagemin dep dodgyness
WORKDIR /build_tmp/game/node_modules/gulp-imagemin/node_modules/imagemin
RUN rm -rf node_modules
RUN npm install
WORKDIR /build_tmp/game

RUN bower --allow-root install
RUN gulp build -o
RUN mv /build_tmp/game/public /srv/game

# Website
WORKDIR /build_tmp/website
RUN npm install
RUN bower --allow-root install
RUN gulp optimize
RUN mv /build_tmp/website/public /srv/website
