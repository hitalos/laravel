#!/bin/sh

mkdir -p /usr/local/lib/nodejs

# Install latest LTS node version
echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
apk add -U nodejs@edge libuv@edge

# Install latest NPM
curl -s -0 -L npmjs.org/install.sh | sh

# Install Yarn
npm i -g yarn

# Install build dependencies
apk add autoconf automake g++ gcc libpng-dev libtool make nasm python
