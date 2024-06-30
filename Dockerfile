# FROM php:8.1-fpm-alpine
FROM php:8.3-fpm-alpine

# install latest composer version
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apk update 
RUN apk add zip
RUN apk add unzip
RUN apk add libpng-dev
RUN apk add libzip-dev

# install php extension pdo_mysql
RUN docker-php-ext-install pdo_mysql

# install php extensions gd and zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip

# install and configure php extension postgres (pdo_pgsql, pgsql)
RUN apk add libpq-dev
# RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pgsql
