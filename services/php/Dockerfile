#FROM bayareawebpro/laravel-docker:latest

# ======= Begin PHP Installer... =======
FROM php:8.0.5-fpm
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y apt-utils
RUN apt-get install -y pkg-config
RUN apt-get install -y curl
RUN apt-get install -y git

##=== Install Extensions ===============================================================#
# https://gist.github.com/hoandang/88bfb1e30805df6d1539640fc1719d12

## Zip, UnZip
RUN apt-get update && apt-get install -y libzip-dev zip unzip
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip

## Cryptography (Encrypter)
#RUN apt-get update && apt-get install -y libmcrypt-dev
#RUN pecl install mcrypt-1.0.2
#RUN docker-php-ext-enable mcrypt

## MySql
RUN apt-get update && apt-get install -y mysql-client-*
RUN docker-php-ext-install pdo pdo_mysql

## Sqlite
#RUN apt-get update && apt-get install -y libsqlite3-dev
#RUN docker-php-ext-install pdo pdo_sqlite

## Math (Telescope)
RUN docker-php-ext-install bcmath

## Imagick
# RUN apt-get update && apt-get install --no-install-recommends -y libmagickwand-dev
# RUN pecl install imagick
# RUN docker-php-ext-enable imagick

## Pcntl (Horizon)
RUN pecl channel-update pecl.php.net
RUN docker-php-ext-install pcntl

## Redis
RUN pecl install redis
RUN docker-php-ext-enable redis

## OpCache
RUN docker-php-ext-install opcache

## Memcached
RUN apt-get install -y libmemcached-dev
RUN pecl install memcached
RUN docker-php-ext-enable memcached

## Install xDebug
#RUN pecl install xdebug && docker-php-ext-enable xdebug

##=== Composer ================================================================#
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin
RUN cd /usr/local/bin/ && curl -sS https://getcomposer.org/installer | php
RUN mv /usr/local/bin/composer.phar /usr/local/bin/composer

##=== Supervisor ==============================================================#
RUN apt-get install -y supervisor
RUN apt-get install -y procps
RUN mkdir -p /var/log/supervisor

##=== NodeJs ==================================================================#
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

## CleanUp
RUN apt-get autoremove

## Setup working directory
RUN chown -R www-data:www-data /var/www
WORKDIR /var/www
