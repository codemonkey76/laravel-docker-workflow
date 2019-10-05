#!/bin/bash
#/bin/bash /root/app/deploy.sh

# Set HuePages
echo never >/sys/kernel/mm/transparent_hugepage/enabled
cat /sys/kernel/mm/transparent_hugepage/enabled

# Set Host OverCommit Memory.
if grep -q "vm.overcommit_memory" /etc/sysctl.conf; then
  echo "vm.overcommit_memory is already configured."
else
  echo "Configured Host vm.overcommit_memory=1"
  echo "vm.overcommit_memory = 1" >>/etc/sysctl.conf
  sysctl vm.overcommit_memory=1
fi

# Make App Directory
if [ ! -d "/root/app" ]; then
  echo "Installing Application..."
  mkdir /root/app
  chown -R www-data: /root/app
  cd /root/app || exit 1
  git init .
  git remote add origin https://github.com/bayareawebpro/laravel-docker.git
fi

# Make App Directory
echo "Pulling Master Branch..."
cd /root/app || exit 1

git pull origin master

# Install PHP Dependencies
echo "Installing Dependancies..."
docker-compose run --detach --name=php_composer php
docker exec php_composer composer install
docker exec php_composer php artisan optimize
docker-compose down

echo "Starting Application..."
docker-compose up
