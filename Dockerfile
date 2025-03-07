FROM php:8.3-fpm-alpine AS builder

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# set workdir
WORKDIR /app

# install laravel
RUN composer create-project laravel/laravel="10.*.*" .

FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
    zip unzip libpng-dev libzip-dev freetype-dev libjpeg-turbo-dev libpq-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo_mysql zip pdo_pgsql pgsql \
    && rm -rf /var/cache/apk/*

COPY --from=builder /app /laravel

WORKDIR /laravel

# set volume
VOLUME [ "/laravel" ]