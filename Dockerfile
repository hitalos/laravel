FROM php
MAINTAINER hitalos <hitalos@gmail.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install git libmcrypt-dev libmysqlclient-dev libpq-dev zlib1g-dev
RUN docker-php-ext-install mcrypt mbstring pdo_mysql pdo_pgsql zip

RUN echo 'precedence ::ffff:0:0/96  100' >> /etc/gai.conf

WORKDIR /var/www
CMD php ./artisan serve --port=80
EXPOSE 80
