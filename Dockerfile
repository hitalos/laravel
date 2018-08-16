FROM hitalos/php:debian
LABEL maintainer="hitalos <hitalos@gmail.com>"

RUN apt-get install -y gnupg libpng-dev

# Download and install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm i -g yarn npm

# Add build dependencies
RUN apt-get install -y autoconf automake g++ gcc libpng-dev libtool make nasm python

CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80
HEALTHCHECK --interval=1m CMD curl -f http://localhost/ || exit 1
