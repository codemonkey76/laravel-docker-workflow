# Laravel Docker 2019
- http://localhost
- http://localhost/horizon/dashboard
- http://localhost/telescope/requests

`git clone git@github.com:bayareawebpro/laravel-docker.git`

### Environment
- MySQL 5.7
- PHP-FPM 7.3
- NPM (latest)
- NGINX (latest)
- Laravel (latest)
- Horizon (latest)
- OpCache (latest)
- xDebug (optional)
- Memcached (latest)
- Supervisor (latest)

### Extensions
```
docker-compose exec php bash
composer check-platform-reqs
```

```
ext-bcmath     7.3.10      success  
ext-dom        20031129    success  
ext-fileinfo   7.3.10      success  
ext-json       1.7.0       success  
ext-libxml     7.3.10      success  
ext-mbstring   7.3.10      success  
ext-openssl    7.3.10      success  
ext-pcntl      7.3.10      success  
ext-Phar       7.3.10      success  
ext-posix      7.3.10      success  
ext-tokenizer  7.3.10      success  
ext-xml        7.3.10      success  
ext-xmlwriter  7.3.10      success  
lib-pcre       10.32       success  
php            7.3.10      success  
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
```
redis-cli
config set maxmemory 256mb
config set maxmemory-policy allkeys-lru
config rewrite
```

# DigitalOcean Image
```
git init .
git remote add origin <repository-url>
git pull origin master


# CertBot
```
docker-compose run --rm --entrypoint "openssl req -x509 -nodes -newkey rsa:1024 -days 1 -keyout '/etc/letsencrypt/live/api.bayareawebpro.com/privkey.pem' -out '/etc/letsencrypt/live/api.bayareawebpro.com/fullchain.pem' -subj '/CN=localhost'" certbot
docker-compose run certbot certonly --standalone --preferred-challenges http -d api.bayareawebpro.com
```