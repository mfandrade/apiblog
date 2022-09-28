# https://www.honeybadger.io/blog/laravel-docker-php/
FROM composer:2 as build

WORKDIR /app/
COPY src/ .
RUN composer install \
        --prefer-dist \
        --no-dev \
        --optimize-autoloader \
        --no-interaction


FROM php:8-apache

RUN docker-php-ext-configure opcache --enable-opcache && \
    docker-php-ext-install pdo pdo_mysql && \
    apt-get update && apt-get install sqlite3 -y && rm -rf /var/lib/apt/lists/*

COPY files/opcache.ini /usr/local/etc/php/conf.d/
COPY files/laravel.conf /etc/apache2/sites-available/
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

WORKDIR /srv/laravel
COPY --from=build --chown=1000:www-data /app/ .

RUN a2enmod rewrite && \
    a2dissite 000-default && \
    a2ensite laravel && \
    service apache2 restart

EXPOSE 80
