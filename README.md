# Laravel Docker 2021
- http://localhost
- http://localhost/horizon/dashboard
- http://localhost/telescope/requests

```dotenv
DB_HOST=mysql
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
REDIS_CLIENT=predis
REDIS_HOST=redis
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

### Environment
- MySQL 8.0.24
- PHP-FPM 8.0.5
- NPM (latest):
- NGINX 1.19.10
- Redis 6.2.3
- Laravel (latest)
- Horizon (latest)
- OpCache (latest)
- xDebug (optional)
- Memcached (latest)
- Supervisor (latest)

### Instructions
1. Clone laravel-docker repo
```shell script
git clone git@github.com:codemonkey76/laravel-docker.git
```
2. Clone laravel app project (replace github link with link to project)
```shell script
git clone {githublink} app
```

3. Configure nginx conf file to your project
Open services/nginx/conf.d/default.conf in your editor and replace example.com on
line 3 and 10 with your domain.

4. open the scripts/init-letsencrypt.sh file in your editor and replace the example.com with your own domain in the line
```shell script
domains=(example.com www.example.com)
```

5. Run the lets-encrypt script to obtain SSL certificate.
```shell script
scripts/init-letsencrypt.sh
```
This will build the containers, create dummy certificate bring up the containers and get the certificates and then replace the dummy certs and bring the containers back up.

### Extensions
```shell script
docker-compose exec php bash
composer check-platform-reqs
```

### Build Images
- `docker-compose build`

### Mange Services
- `docker-compose up` (listen)
- `docker-compose up -d` (detach)
- `docker-compose down` 

### Bash Shell
- `docker-compose exec php bash`
- `docker-compose exec mysql bash`
- `docker-compose exec nginx bash`
- `docker-compose exec redis bash`
- `docker-compose exec worker bash`
- `exit`

### Copy Files
- `docker ps` (list container IDs)
- `docker cp <containerId>:/file/path/within/container /my/path`
- `docker cp ae732473905f:/usr/local/etc ~/Desktop`
- `docker rm --force <containerId>`

### Nginx
- `docker-compose exec nginx nginx -s reload`
- `docker-compose exec nginx bash`
- `service nginx status`
- `service nginx restart`

### PHP-FPM
- `docker-compose exec php bash`
- `kill -USR2 1`

### Database
The database host `DB_HOST=mysql` references the docker service IP.

- `docker-compose exec mysql bash`
- `mysql -u root -plaravel`

### Redis Cache
The database host `REDIS_HOST=redis` references the docker service IP.

- `docker-compose exec redis bash`

Configure as Auto-Expiring Cache
```shell script
redis-cli
config set maxmemory 256mb
config set maxmemory-policy allkeys-lru
config rewrite
```

# DigitalOcean Image
```shell script
git init .
git remote add origin <repository-url>
git pull origin master
```
