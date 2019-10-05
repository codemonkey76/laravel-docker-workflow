#docker-compose run --rm --entrypoint "openssl req -x509 -nodes -newkey rsa:1024 -days 1 -keyout /var/www/certbot/privkey.pem -out /var/www/certbot/fullchain.pem -subj '/CN=localhost'" certbot

DOMAINS=(api.bayareawebpro.com)
mkdir -p "./data/certbot/conf/live/$DOMAINS"

DOMAIN_ARGS=""
for DOMAIN in "${DOMAINS[@]}"; do
  DOMAIN_ARGS="$DOMAIN_ARGS -d $DOMAIN"
done

docker-compose run --rm --entrypoint "certbot certonly
--webroot -w /var/www/certbot
--staging
-d api.bayareawebpro.com
--rsa-key-size 4096
--agree-tos
--register-unsafely-without-email
--force-renewal" certbot