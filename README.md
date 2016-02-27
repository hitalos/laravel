[![Docker Pulls](https://img.shields.io/docker/pulls/hitalos/laravel.svg)](https://hub.docker.com/r/hitalos/laravel/) [![ImageLayers Size](https://img.shields.io/imagelayers/image-size/hitalos/laravel/latest.svg)]()

# laravel
Docker image to run Laravel 5.x projects. Support to Mysql, PostgreSQL and SQLite databases.

## Tags disponíveis
* `latest` [(PHP 7.0.3)](https://github.com/hitalos/laravel/blob/master/Dockerfile)
* `alpine` [(PHP 5.6.17)](https://github.com/hitalos/laravel/blob/alpine/Dockerfile)

## Installing
    docker pull hitalos/laravel

## Using

    docker run --name <container_name> -d -v $PWD:/var/www -p 80:80 hitalos/laravel

$PWD it's the laravel installation folder.
