#!/bin/sh
#
source ./env.sh

function nginx() {
    #sed -i "s%{domain}%${domain}%g" `pwd`/nginx/conf/server.conf
    #sed -i "s%{root}%${root}%g" `pwd`/nginx/conf/server.conf
    #sed -i "s%{fastcgi_pass}%${fastcgi_pass}%g" `pwd`/nginx/conf/server.conf

    docker run -it -d --name nginx \
    --restart always \
    --link php:php-fpm-1 \
    --link redis:redis \
    --link mysql:mysql \
    -p 80:80 -p 8080:8080 \
    -v `pwd`/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
    -v `pwd`/nginx/conf/server.conf:/etc/nginx/conf.d/server.conf \
    -v `pwd`/nginx/conf/upstream.php.conf:/etc/nginx/conf.d/upstream.php.conf \
    -v `pwd`/nginx/log/:/var/log/nginx/ \
    -v /data/www-data/:/data/www-data/ \
    nginx-1.19.7:2
}

function php() { 
    docker run -it -d --name php \
    --restart=always \
    -v `pwd`/php/conf/php.ini:/usr/local/etc/php/php.ini \
    -v `pwd`/php/conf/php-fpm.d/:/usr/local/etc/php-fpm.d/ \
    -v `pwd`/php/log/:/usr/local/log/ \
    -v /data/www-data/:/data/www-data/ \
    php-7.3-fpm:5
}

function redis() {
    docker run -d --restart=always -p 6380:6380 --name redis \
    -v `pwd`/redis/conf/redis.conf:/etc/redis/redis.conf:ro \
    -v `pwd`/redis/data:/data \
    redis:5.0.8 redis-server /etc/redis/redis.conf
}

function mysql() {
    docker run -d --restart=always -p 3306:3306 --name mysql \
    -e MYSQL_ROOT_PASSWORD=${ROOT_PASSWORD} \
    -e MYSQL_DATABASE=${DB} \
    -e MYSQL_USER=s${USER} \
    -e MYSQL_PASSWORD=${USER_PASSWORD} \
    -v `pwd`/mysql/conf/my.cnf:/etc/mysql/conf.d/my.cnf \
    -v `pwd`/mysql/data:/var/lib/mysql \
    -v `pwd`/mysql/log:/var/log/mysql \
    mysql:5.7.32
}

$1
