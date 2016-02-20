[![Docker Pulls](https://img.shields.io/docker/pulls/hitalos/laravel.svg)](https://hub.docker.com/r/hitalos/laravel/)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/hitalos/laravel/latest.svg)]()

# laravel
Docker container to run Laravel 5.2 projects. Support to Mysql, PostgreSQL and SQLite databases.

## Installing
    docker pull hitalos/laravel

## Using

    docker run --name <container_name> -d -v $PWD:/var/www -p 80:80 hitalos/laravel

$PWD it's the laravel installation folder.

## Dependencies
The commands `composer` and `npm`  are installed on the image.

To install dependencies from `composer`:

    docker exec -it <container_name> composer install

To install dependencies from `npm`:

    docker exec -it <container_name> npm install
