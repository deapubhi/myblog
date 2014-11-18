#FROM dockerfile/nodejs
#MAINTAINER Aman Prakash Mohla <aman@tablehero.com>


FROM ubuntu:14.04

MAINTAINER Aman Prakash Mohla <aman@tablehero.com>

#Install Dependencies

RUN apt-get update -y 
RUN apt-get install -y python-software-properties g++ make software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list
RUN apt-get update -y

#Install nodejs and unzip
RUN apt-get install -y nodejs

WORKDIR /home/myblog

RUN npm install -g grunt-cli
RUN npm install -g bower

# Install packages
ADD package.json /home/myblog/package.json
RUN npm install


# Make everything available for start
ADD . /home/myblog

ENV NODE_ENV production
EXPOSE 2368

RUN pwd

# =========> SETUP SUPERVISOR CONFIGURATION <===========
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /home/myblog/logs/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/usr/bin/supervisord"]