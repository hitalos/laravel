FROM hitalos/php:latest
LABEL maintainer="hitalos <hitalos@gmail.com>"

# Download and install NodeJS
ENV NODE_VERSION 10.6.0
RUN apk add --update nodejs nodejs-npm
RUN npm i -g yarn

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80
HEALTHCHECK --interval=1m CMD curl -f http://localhost/ || exit 1
