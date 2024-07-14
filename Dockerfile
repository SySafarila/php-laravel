# FROM php:8.1-fpm-alpine
FROM php:8.3-fpm-alpine

# install latest composer version
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apk update 
RUN apk add zip
RUN apk add unzip
RUN apk add libpng-dev
RUN apk add libzip-dev

# install package for freetype
RUN apk add freetype-dev
RUN apk add libjpeg-turbo-dev
RUN apk add libpng-dev

# install package for postgres
RUN apk add libpq-dev

# install php extension pdo_mysql
RUN docker-php-ext-install pdo_mysql

# configure & install php extensions gd
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# install php extensions zip
RUN docker-php-ext-install zip

# install php extension postgres (pdo_pgsql, pgsql)
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pgsql
