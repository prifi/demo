FROM php-7.3-fpm:3

MAINTAINER Xiaopf <xiaopengfei@bestwo.com>

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtome && echo $TZ > /etc/timezone

# install extensions
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    libxml2-dev \
    libzip-dev \
    libwebp-dev libjpeg-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libvpx-dev libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install bcmath gettext mysqli pcntl pdo_mysql shmop sockets sysvmsg sysvsem sysvshm opcache soap zip calendar

# install GD
RUN docker-php-ext-configure gd \
    --with-png-dir \
    --with-jpeg-dir \
    --with-xpm-dir \
    --with-webp-dir \
    --with-freetype-dir \
    && docker-php-ext-install -j$(nproc) gd

# install pecl extension
RUN pecl install igbinary && \
    pecl install mongodb && \
    yes "" | pecl install msgpack && \
    yes "" | pecl install redis && \
    docker-php-ext-enable igbinary mongodb msgpack redis

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/sbin/composer \
    && chmod +x /usr/local/sbin/composer

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

WORKDIR /var/www/html
CMD ["php-fpm", "-F"]
