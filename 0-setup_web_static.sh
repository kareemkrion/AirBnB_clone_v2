#!/usr/bin/env bash
# Set up a nginx web server for AirBnB project.

apt-get update
apt-get install -y nginx

# Creating the necessary directory, if not already existing
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Hello World" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current
# Changing Ownership and group of the directory
chown -R ubuntu /data/
chgrp -R ubuntu /data/

# Confuration of the html file
printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;
    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }
    location /redirect_me {
        return 301 http://cuberule.com/;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
