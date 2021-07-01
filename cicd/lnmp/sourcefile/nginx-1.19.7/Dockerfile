FROM debian:buster-slim

MAINTAINER Xiaopf <xiaopengfei@bestwo.com>

ENV TZ=Asia/Shanghai
RUN rm -f /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

ARG MAKE_J=4
ARG NGINX_VERSION=1.19.7
ARG LIBPNG_VERSION=1.6.37

ENV MAKE_J=${MAKE_J} \
        NGINX_VERSION=${NGINX_VERSION} \
        LIBPNG_VERSION=${LIBPNG_VERSION}

RUN apt-get update -y && \
    apt-get install -y \
    apt-utils \
    git vim \
    g++ \
    gcc \
    curl \
    make \
    unzip \
    bzip2 \
    gperf \
    python \
    openssl \
    libuuid1 \
    apt-utils \
    pkg-config \
    icu-devtools \
    build-essential \
    ca-certificates \
    uuid-dev \
    zlib1g-dev \
    libicu-dev \
    libssl-dev \
    apache2-dev \
    libpcre3 \
    libpcre3-dev \
    libmaxminddb-dev \
    libpng-dev \
    libaprutil1-dev \
    linux-headers-amd64 \
    libjpeg62-turbo-dev \
    libcurl4-openssl-dev \
    && cd /tmp && \
        curl -L http://prdownloads.sourceforge.net/libpng/libpng-${LIBPNG_VERSION}.tar.gz | tar -zx && \
        cd /tmp/libpng-${LIBPNG_VERSION} && \
        ./configure --build=$CBUILD --host=$CHOST --prefix=/usr --enable-shared --with-libpng-compat && \
        make -j${MAKE_J} install V=0 \
    && cd /tmp && \
        git clone git://github.com/vozlt/nginx-module-vts.git && \
        git clone https://github.com/FRiCKLE/ngx_cache_purge.git && \
        git clone https://github.com/leev/ngx_http_geoip2_module.git && \
        git clone https://github.com/openresty/echo-nginx-module.git && \
        git clone https://github.com/openresty/headers-more-nginx-module.git \
    && cd /tmp && \
        curl -L http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar -zx && \
        cd /tmp/nginx-${NGINX_VERSION} && \
        LD_LIBRARY_PATH=/tmp/incubator-pagespeed-ngx-${PAGESPEED_VERSION}/usr/lib:/usr/lib ./configure --user=nobody --group=nogrpup \
        --sbin-path=/usr/sbin \
        --modules-path=/usr/lib/nginx \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --with-file-aio \
        --with-http_v2_module \
        --with-http_realip_module \
        --with-http_sub_module \
        --with-http_gunzip_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-threads \
        --with-stream \
        --with-stream_ssl_module \
        --without-http_autoindex_module \
        --without-http_browser_module \
        --without-http_userid_module \
        --without-http_split_clients_module \
        --without-http_uwsgi_module \
        --without-http_scgi_module \
        --without-http_upstream_ip_hash_module \
        --prefix=/etc/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --http-log-path=/var/log/nginx/access.log \
        --error-log-path=/var/log/nginx/error.log \
        --pid-path=/var/run/nginx.pid \
        --add-module=/tmp/ngx_cache_purge \
        --add-module=/tmp/nginx-module-vts \
        --add-module=/tmp/echo-nginx-module \
        --add-module=/tmp/ngx_http_geoip2_module \
        --add-module=/tmp/headers-more-nginx-module && \
        make install --silent \
        && apt-get remove -y git \
        && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* && \
            ln -sf /dev/stdout /var/log/nginx/access.log && \
            ln -sf /dev/stderr /var/log/nginx/error.log

# Inject Nginx configuration files
COPY ./config/conf.d              /etc/nginx/conf.d
COPY ./config/nginx.conf          /etc/nginx/nginx.conf

EXPOSE 80 8080
WORKDIR /etc/nginx

CMD ["nginx", "-g", "daemon off;"]
