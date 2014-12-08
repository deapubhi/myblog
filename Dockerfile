FROM dockerfile/nodejs
MAINTAINER Aman Prakash Mohla <aman@tablehero.com>

WORKDIR /home/myblog

RUN npm install -g grunt-cli
RUN npm install -g bower
RUN npm install -g forever

# Install packages
#ADD package.json /home/myblog/package.json


# Make everything available for start
ADD . /home/myblog

RUN npm install --production

ENV NODE_ENV production
EXPOSE 2368

CMD ["forever", "-o", "start", "index.js"]