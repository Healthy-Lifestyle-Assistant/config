#!/bin/bash
git clone https://github.com/Healthy-Lifestyle-Assistant/client.git

cp -a ~/client/dist /var/www/html
# cp -a ~/client/dist /usr/share/nginx/html

rm -rf ~/client

cp ~/config/nginx.config /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/

systemclt restart nginx