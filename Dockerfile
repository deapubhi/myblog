FROM ubuntu:14.04

MAINTAINER Aman Prakash Mohla <aman@tablehero.com>

# =========> SETUP DEPENDENCIES <===========
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install build-essential --fix-missing
RUN apt-get -y install software-properties-common
RUN apt-get -y install python-software-properties 
RUN apt-get -y install git git-core

RUN apt-get -y install byobu
RUN apt-get -y install curl 
RUN apt-get -y install htop
RUN apt-get -y install man unzip vim

RUN apt-get -y install wget
RUN apt-get -y install make

# =========> SETUP NODEJS <===========
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y install nodejs

RUN npm install -g grunt-cli
RUN npm install -g bower
RUN npm install -g pm2

WORKDIR /home/blog
ADD package.json /home/blog/package.json
ADD .bowerrc /home/blog/.bowerrc
ADD bower.json /home/blog/bower.json


RUN npm install
RUN bower install --config.interactive=false --allow-root

ADD . /home/blog

ENV NODE_ENV production
EXPOSE 2368
CMD[pm2 node index.js]