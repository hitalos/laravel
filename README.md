# laravel
Docker container to run Laravel 5.2 projects

## Installing
    docker pull hitalos/laravel

## Using

    docker run -d -v $PWD:/var/www -p 8000:8000 hitalos/laravel

$PWD it's a path. You can use an empty folder or a folder with the Laravel already installed.
