#!/bin/sh

# Install current LTS node version
apk add -U nodejs-current

# Install latest NPM
curl -s -L npmjs.org/install.sh | sh

# Install Yarn
npm i -g yarn

# Install build dependencies
apk add autoconf automake g++ gcc libpng-dev libtool make nasm python3
