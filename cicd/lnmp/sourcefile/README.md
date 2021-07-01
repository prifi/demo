## 基础镜像构建

### 相关阅读

```shell
# nginx
https://github.com/nginxinc/docker-nginx/blob/master/stable/debian/Dockerfile

# php
https://hub.docker.com/r/bitnami/php-fpm

# vue
https://github.com/freekingg/vue-docker-deloy
https://cli.vuejs.org/zh/guide/deployment.html#docker-nginx
```

### 构建镜像

```shell
# nginx
cd sourcefile/nginx-1.19.7
docker build -t harbor190.iteam-dress.com/base/nginx:1.19.7 .

# php
cd sourcefile/php-7.3-fpm
docker build -t php-7.3-fpm:3   # 修改官方镜像 Dockerfile 守护进程用户 www 为 nobody:nogroup

cd custom/
docker build -t harbor190.iteam-dress.com/base/php-fpm:7.3

# vue
cd sourcefile/node-14.17/app
docker-compose config \
&& docker-compose build --no-cache --build-arg APP_ENV=dev --build-arg BUILD_ID=v1.2 \
&& docker-compose push \
&& docker-compose up -d --no-build \
&& docker-compose ps
curl localhost:81
```


