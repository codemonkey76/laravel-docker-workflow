


DOMAINS=(api.bayareawebpro.com)
mkdir -p "./data/certbot/conf/live/$DOMAINS"

DOMAIN_ARGS=""
for DOMAIN in "${DOMAINS[@]}"; do
  DOMAIN_ARGS="$DOMAIN_ARGS -d $DOMAIN"
done

docker-compose run --rm --entrypoint "certbot certonly
--webroot -w /var/www/certbot
--staging
$DOMAIN_ARGS
--rsa-key-size 4096
--agree-tos
--register-unsafely-without-email
--force-renewal" certbot