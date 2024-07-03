FROM php:8.0-apache

RUN apt update &&  apt install -y \
    curl \
    unzip \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    libxml2-dev \
    libicu-dev \
    libxslt1-dev \
    zlib1g-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd>

RUN a2enmod rewrite

RUN curl -o moodle.tgz -L https://download.moodle.org/download.php/direct/stable402/mood>    && tar -zxvf moodle.tgz -C /var/www/html \
    && chown -R www-data:www-data /var/www/html/moodle

RUN mkdir /var/moodledata \
    && chown -R www-data:www-data /var/moodledata \
    && chmod -R 0770 /var/moodledata

# Uncomment if you have a config file to import:
# COPY config.php /var/www/html/moodle/config.php

EXPOSE 8080

WORKDIR /var/www/html/moodle
