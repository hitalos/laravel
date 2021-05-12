![Docker Pulls](https://img.shields.io/docker/pulls/hitalos/laravel.svg)

# laravel

Docker image to run PHP (supporting Laravel) and Node projects.

This image it's for development. **Optimize to use in production!**

In the latest update, I changed the base image to `php:alpine` for size optimizing.

## Tags

* [**`latest`**:](https://github.com/hitalos/laravel/blob/master/Dockerfile)  
  * `php` 8.0.6
    * `composer` 2.0.13
    * `phpunit` 9.5.4
    * `xdebug` 3.0.4
  * `nodejs` 15.10.0
    * `npm` 7.12.1
    * `yarn` 1.22.10

## Supported Databases (**PDO**)

* `mssql` (via dblib)
* `mysql`
* `pgsql`
* `sqlite`

## Extra supported extensions

* `curl`
* `exif`
* `gd`
* `ldap`
* `mongodb`

## Installing

```shell
docker pull hitalos/laravel
```

## Using

### With `docker`

```shell
docker run --name <container_name> -d -v $PWD:/var/www -p 80:80 hitalos/laravel
```

Where $PWD is the laravel installation folder.

### With `docker-compose`

Create a `docker-compose.yml` file in the root folder of project using this as a template:

```yml
web:
    image: hitalos/laravel:latest
    ports:
        - 80:80
    volumes:
        - ./:/var/www
    # If you don't want to use default 'artisan serve' command, edit and uncomment the line below.
    # command: php -S 0.0.0.0:80 -t public public/index.php
```

Then run using this command:

```shell
docker-compose up
```

If you want to use a database, you can create your `docker-compose.yml` with two containers.

```yml
web:
    image: hitalos/laravel:latest
    ports:
        - 80:80
    volumes:
        - ./:/var/www
    links:
        - db
    environment:
        DB_HOST: db
        DB_DATABASE: dbname
        DB_USERNAME: username
        DB_PASSWORD: p455w0rd
        DB_CONNECTION: [pgsql or mysql]
db:
    image: [postgres or mysql]
    environment:
        # with mysql
        MYSQL_DATABASE: dbname
        MYSQL_USER: username
        MYSQL_PASSWORD: p455w0rd

        # with postgres
        POSTGRES_DB: dbname
        POSTGRES_USER: username
        POSTGRES_PASSWORD: p455w0rd
```

### Useful links (alternative projects)

- [Laravel with RoadRunner in docker](https://github.com/tarampampam/laravel-roadrunner-in-docker)
