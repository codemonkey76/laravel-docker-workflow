docker run -t --rm \
    -v certs:/etc/letsencrypt \
    -v certs-data:/data/letsencrypt \
    deliverous/certbot \
    renew \
    --webroot --webroot-path=/data/letsencrypt

docker-compose kill -s HUP nginx