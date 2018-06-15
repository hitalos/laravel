FROM php
LABEL maintainer="hitalos <hitalos@gmail.com>"

RUN apt-get update && apt-get -y full-upgrade && apt-get install -y bash git

# Install PHP extensions
ADD install-php.sh /usr/sbin/install-php.sh
RUN /usr/sbin/install-php.sh

# Download and install NodeJS
ENV NODE_VERSION 10.4.1
ADD install-node.sh /usr/sbin/install-node.sh
RUN /usr/sbin/install-node.sh
RUN npm i -g yarn

RUN mkdir -p /etc/ssl/certs && update-ca-certificates

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80
HEALTHCHECK --interval=1m CMD curl -f http://localhost/ || exit 1
