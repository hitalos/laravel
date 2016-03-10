FROM php
MAINTAINER hitalos <hitalos@gmail.com>

# Installing dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install \
    freetds-dev \
    git \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libldap2-dev \
    libmcrypt-dev \
    libmysqlclient-dev \
    libpng12-dev \
    libpq-dev \
    libwebp-dev \
    libxml2-dev \
    zlib1g-dev

# Configuring extensions to compile
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-configure pdo_dblib --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-configure gd \
    --with-jpeg-dir=lib/x86_64-linux-gnu \
    --with-freetype-dir=lib/x86_64-linux-gnu \
    --with-webp-dir=lib/x86_64-linux-gnu/

# Compiling and installing extensions
RUN docker-php-ext-install \
    gd \
    exif \
    gettext \
    intl \
    ldap \
    mcrypt \
    mbstring \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    xmlrpc \
    zip

# General Configurations
RUN echo 'precedence ::ffff:0:0/96  100' >> /etc/gai.conf

# Adding pt_BR locale
RUN echo "locales locales/locales_to_be_generated multiselect pt_BR.UTF-8 UTF-8" | debconf-set-selections && \
	echo "locales locales/default_environment_locale select pt_BR.UTF-8" | debconf-set-selections
RUN apt-get install -y locales
ENV LC_ALL pt_BR.UTF-8

# Download and install NodeJS
RUN curl https://nodejs.org/dist/v5.8.0/node-v5.8.0-linux-x64.tar.gz -o /tmp/node-latest.tar.gz &&\
    tar -C /usr/local --strip-components 1 -xzf /tmp/node-latest.tar.gz &&\
    rm /tmp/node-latest.tar.gz

# Download and install Composer
# Instructions from: https://getcomposer.org/download/
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === 'fd26ce67e3b237fffd5e5544b45b0d92c41a4afe3e3f778e942e43ce6be197b9cdc7c251dcde6e2a52297ea269370680') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); }" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer

# Set timezone
# RUN echo America/Maceio > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80
