FROM hitalos/php:latest
LABEL maintainer="hitalos <hitalos@gmail.com>"

# Download and install NodeJS
ENV NODE_VERSION 10.4.1
ENV NODE_SASS_PLATFORM alpine 
ADD install-node.sh /usr/sbin/install-node.sh
RUN /usr/sbin/install-node.sh
RUN npm i -g yarn

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80
HEALTHCHECK --interval=1m CMD curl -f http://localhost/ || exit 1
