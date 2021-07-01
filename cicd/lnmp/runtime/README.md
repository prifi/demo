## 容器运行配置

所有服务 `mysql`  `nginx`  `php`  `redis` 启动数据、配置、日志均本地持久化

注意事项:

- `nginx/conf/server.conf`  域名对应修改
- `nginx/conf/upstream.php.conf` 后端PHP（按需），默认 `php-fpm-1:9000`
- `php/conf/php-fpm.d/www.conf` php-fpm 进程数调整（按需），默认 `10 - 50`

### 启动容器

```shell
cd runtime/
docker-compose up -d
docker-compose ps
```

手动运行调试：

```shell
sh docker_lnmp.sh nginx
sh docker_lnmp.sh php
sh docker_lnmp.sh redis
sh docker_lnmp.sh mysql
```


