DOMAINS=(api.bayareawebpro.com)
mkdir -p "./data/certbot/conf/live/${DOMAINS[*]}"

DOMAIN_ARGS=""
for DOMAIN in "${DOMAINS[@]}"; do
  DOMAIN_ARGS="$DOMAIN_ARGS -d $DOMAIN"
done

COMMAND="certbot certonly
--rsa-key-size 4096
--webroot -w /var/www/certbot
--register-unsafely-without-email
--force-renewal
--agree-tos
--staging
$DOMAIN_ARGS"

docker-compose run --rm --entrypoint "$COMMAND" certbot