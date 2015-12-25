#!/bin/bash
target="/var/www"
if test "$(ls -A "$target")"; then
    echo "Target folder is not empty!"
else
    composer create-project laravel/laravel $target --prefer-dist
fi
