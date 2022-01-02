#!/bin/bash

if [ ! -f /etc/nginx/ssl/localhost.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/localhost.key" 2048
    openssl req -new -key "/etc/nginx/ssl/localhost.key" -out "/etc/nginx/ssl/localhost.csr" -subj "/CN=localhost/O=localhost/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/localhost.csr" -signkey "/etc/nginx/ssl/localhost.key" -out "/etc/nginx/ssl/localhost.crt"
    chmod 644 /etc/nginx/ssl/localhost.key
fi

# Start crond in background
crond -l 2 -b

# Start nginx in foreground
nginx