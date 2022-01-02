FROM php:8.0-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd sockets

###########################################################################
# ImageMagick:
###########################################################################

USER root

RUN if [ ${INSTALL_IMAGEMAGICK} = true ]; then \
    apt-get install -yqq libmagickwand-dev imagemagick && \
    if [ $(php -r "echo PHP_MAJOR_VERSION;") = "8" ]; then \
    cd /tmp && \
    if [ ${IMAGEMAGICK_VERSION} = "latest" ]; then \
    git clone https://github.com/Imagick/imagick; \
    else \
    git clone --branch ${IMAGEMAGICK_VERSION} https://github.com/Imagick/imagick; \
    fi && \
    cd imagick && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    rm -r /tmp/imagick; \
    else \
    pecl install imagick; \
    fi && \
    docker-php-ext-enable imagick; \
    php -m | grep -q 'imagick' \
    ;fi

# Get latest Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install xdebug-3.0.4 \
    && docker-php-ext-enable xdebug

RUN echo 'date.timezone="America/Sao_Paulo"' >> /usr/local/etc/php/conf.d/date.ini \
    && echo 'opcache.enable=1' >> /usr/local/etc/php/conf.d/opcache.conf \
    && echo 'opcache.validate_timestamps=1' >> /usr/local/etc/php/conf.d/opcache.conf \
    && echo 'opcache.fast_shutdown=1' >> /usr/local/etc/php/conf.d/opcache

# Install redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

RUN chown -R www-data:www-data /var/www

# Set working directory
WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000