#!/bin/bash
target="/var/www"
if test "$(ls -A "$target")"; then
    echo "Target folder is not empty!"
    if [ -e "$target/artisan" ]; then
        php $target/artisan serve --host 0.0.0.0
    fi
else
    composer create-project laravel/laravel $target --prefer-dist
    php $target/artisan serve --host 0.0.0.0
fi
