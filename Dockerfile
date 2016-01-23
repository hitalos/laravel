FROM php
MAINTAINER hitalos <hitalos@gmail.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install git libldap2-dev libmcrypt-dev libmysqlclient-dev libpq-dev zlib1g-dev
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install mcrypt mbstring pdo_mysql pdo_pgsql zip

RUN echo 'precedence ::ffff:0:0/96  100' >> /etc/gai.conf

RUN php -r "readfile('https://getcomposer.org/installer');" | php
RUN mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer
RUN curl https://nodejs.org/dist/v5.5.0/node-v5.5.0-linux-x64.tar.gz -o /tmp/node-latest.tar.gz
RUN tar -C /usr/local --strip-components 1 -xzf /tmp/node-latest.tar.gz

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80
