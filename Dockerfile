# https://www.honeybadger.io/blog/laravel-docker-php/
FROM composer:2 as build

WORKDIR /app
COPY . .
RUN composer install \
        --prefer-dist \
        --no-dev \
        --optimize-autoloader \
        --no-interaction


FROM php:8-apache

ENV APP_ENV=production
ENV APP_DEBUG=false

RUN docker-php-ext-configure opcache --enable-opcache && \
    docker-php-ext-install pdo pdo_mysql

COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

COPY --from=build /app /var/www/html
COPY .env.production /var/www/html/.env

RUN php artisan config:cache && \
    php artisan route:cache && \
    chown -R www-data:www-data . && \
    chmod +w -R storage && \
    a2enmod rewrite
