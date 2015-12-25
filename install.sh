#!/bin/bash
target="/var/www"
if test "$(ls -A "$target")"; then
    echo "Target folder is not empty!"
    if [ -e "$target/artisan" ]; then
        php $target/artisan serve --host 0.0.0.0
    fi
else
    composer create-project laravel/laravel $target --prefer-dist

    # Configs for debugBar
    composer require barryvdh/laravel-debugbar
    sed -i '158i	Barryvdh\\Debugbar\\ServiceProvider::class,' config/app.php
    sed -i "205i	'Debugbar' => Barryvdh\\Debugbar\\Facade::class," config/app.php

    php $target/artisan serve --host 0.0.0.0
fi
