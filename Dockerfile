FROM php
MAINTAINER hitalos <hitalos@gmail.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install git libmcrypt-dev zlib1g-dev
RUN docker-php-ext-install mcrypt mbstring zip

RUN php -r "readfile('https://getcomposer.org/installer');" | php
RUN mv composer.phar /usr/local/bin/composer

ADD ./install.sh /
RUN /install.sh

WORKDIR /var/www
