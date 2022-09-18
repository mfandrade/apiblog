# https://www.honeybadger.io/blog/laravel-docker-php/
FROM composer:2 as build

WORKDIR /app/
COPY . .
RUN composer install \
        --prefer-dist \
        --no-dev \
        --optimize-autoloader \
        --no-interaction


FROM php:8-apache

RUN docker-php-ext-configure opcache --enable-opcache && \
    docker-php-ext-install pdo pdo_mysql

COPY .infra/opcache.ini /usr/local/etc/php/conf.d/
COPY .infra/laravel.conf /etc/apache2/sites-available/
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

WORKDIR /srv/laravel
COPY --from=build /app/ .

RUN chgrp -R www-data . && \
    chmod -R g+w storage/cache/ && \
    a2enmod rewrite

RUN php artisan config:cache && \
    php artisan route:cache

