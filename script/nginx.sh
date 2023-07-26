#!/bin/bash
git clone https://github.com/Healthy-Lifestyle-Assistant/client.git

sudo cp -a ~/client/dist /var/www/html
# sudo cp -a ~/client/dist /usr/share/nginx/html

sed -i 's/domain_or_IP/replacement_text' ~/config/nginx/nginx.config

sudo cp ~/config/nginx/nginx.config /etc/nginx/sites-available/

sudo ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/

sudo nginx -t

sudo systemclt restart nginx
