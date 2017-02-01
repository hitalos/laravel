FROM php:alpine
MAINTAINER hitalos <hitalos@gmail.com>

RUN apk update && apk upgrade && apk add git

# Install PHP extensions
ADD install-php.sh /usr/sbin/install-php.sh
RUN /usr/sbin/install-php.sh

# Download and install NodeJS
ENV NODE_VERSION 7.5.0
ADD install-node.sh /usr/sbin/install-node.sh
RUN /usr/sbin/install-node.sh
RUN npm i -g yarn

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80
