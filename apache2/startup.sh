#!/bin/bash

mkdir /etc/apache2/ssl 2> /dev/null

# Change localhost to the URL to be used
if [ ${APACHE_HTTP2} = true ]; then
  if [ ! -f /etc/apache2/ssl/localhost.crt ]; then
    openssl genrsa -out "/etc/apache2/ssl/localhost.key" 2048
    openssl rand -out /root/.rnd -hex 256
    openssl req -new -key "/etc/apache2/ssl/localhost.key" -out "/etc/apache2/ssl/localhost.csr" -subj "/CN=localhost/O=Laradock/C=BR"
    openssl x509 -req -days 365 -extfile <(printf "subjectAltName=DNS:localhost,DNS:*.localhost") -in "/etc/apache2/ssl/localhost.csr" -signkey "/etc/apache2/ssl/localhost.key" -out "/etc/apache2/ssl/localhost.crt"
  fi

  a2enmod rewrite
  a2enmod headers
  a2enmod proxy proxy_html proxy_http xml2enc ssl http2
  service apache2 restart
fi

# Start apache in foreground
/usr/sbin/apache2ctl -D FOREGROUND