docker run -it --rm \
  -v certs:/data/letsencrypt/certs \
  -v certs-data:/data/letsencrypt/certs-data \
  deliverous/certbot \
  certonly \
  --webroot --webroot-path=/data/letsencrypt \
  -d api.bayareawebpro.com