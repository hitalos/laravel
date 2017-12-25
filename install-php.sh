#!/bin/sh

apk add freetds freetype icu libintl libldap libjpeg libmcrypt libpng libpq libwebp

TMP="curl-dev \
    freetds-dev \
    freetype-dev \
    gettext-dev \
    icu-dev \
    jpeg-dev \
    libmcrypt-dev \
    libpng-dev \
    libwebp-dev \
    libxml2-dev \
    openldap-dev \
    postgresql-dev"
apk add $TMP

# Configure extensions
docker-php-ext-configure gd --with-jpeg-dir=usr/ --with-freetype-dir=usr/ --with-webp-dir=usr/
docker-php-ext-configure ldap --with-libdir=lib/
docker-php-ext-configure pdo_dblib --with-libdir=lib/

# Download mongo extension
/usr/local/bin/pecl download mongodb && \
    tar -C /usr/src/php/ext -xf mongo*.tgz && \
    rm mongo*.tgz && \
    mv /usr/src/php/ext/mongo* /usr/src/php/ext/mongodb

docker-php-ext-install \
    curl \
    exif \
    gd \
    gettext \
    intl \
    ldap \
    mongodb \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    xmlrpc \
    zip

# Download trusted certs 
mkdir -p /etc/ssl/certs && update-ca-certificates

# Install composer
php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

apk del $TMP

# Set timezone
# RUN echo America/Maceio > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
