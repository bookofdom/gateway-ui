FROM node:0.12.7

# install sudo
# required by ember-cli-ramdisk
# but kind of pointless since it runs as root
RUN apt-get update && apt-get install -y --no-install-recommends sudo

# install node stuff
RUN npm install -g npm@1.4.28
RUN npm install -g ember-cli@1.13.8
RUN npm install -g bower@1.5.2
RUN npm install -g phantomjs@1.9.18

# expose ports, establish entrypoint
EXPOSE 4200 35729 49152
WORKDIR /src
ENTRYPOINT ["/usr/local/bin/ember"]
CMD ["server"]
