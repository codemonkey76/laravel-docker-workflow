#!/bin/bash
#/bin/bash /root/app/deploy.sh
DOMAIN="api.bayareawebpro.com"

# Set HuePages
if grep -q "never" /sys/kernel/mm/transparent_hugepage/enabled; then
  echo "transparent_hugepages is already configured."
else
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  echo "Disabled transparent_hugepages..."
fi

# Set Host OverCommit Memory.
if grep -q "vm.overcommit_memory" /etc/sysctl.conf; then
  echo "vm.overcommit_memory is already configured."
else
  echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
  sysctl vm.overcommit_memory=1
  echo "Enabled vm.overcommit_memory..."
fi

# Add SelfSigned Certificate (will be overwritten by CertBot)
CERT_DIR=/root/app/data/certbot/conf/live/$DOMAIN
if [ ! -d "$CERT_DIR" ]; then
  openssl req -x509 -nodes -newkey rsa:1024 -days 365 -keyout $CERT_DIR/privkey.pem -out $CERT_DIR/fullchain.pem -subj '/CN=localhost'
fi

# Make App Directory
if [ ! -d "/root/app" ]; then
  echo "Installing Application..."
  mkdir /root/app
  cd /root/app || exit 1
  git init .
  git remote add origin https://github.com/bayareawebpro/laravel-docker-workflow.git
fi

# Make App Directory
if [ ! -f "/root/app/src/.env" ]; then
  echo "Installing Application Environment File..."
  cp /root/app/src/.env.example /root/app/src/.env
fi

# Pull Master Branch
echo "Pulling Master Branch..."
cd /root/app || exit 1
git pull origin master

# Set Permissions
chown -R www-data: /root/app/src/storage

# Install PHP Dependencies
echo "Installing Dependancies..."
docker-compose run --rm --name=php_composer --entrypoint "composer install
--no-ansi
--no-dev
--no-interaction
--no-plugins
--no-progress
--no-scripts
--no-suggest
--optimize-autoloader" php
docker-compose run --rm --name=php_composer --entrypoint "php artisan key:generate" php

echo "Starting Application..."
docker-compose up
