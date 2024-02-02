#!/bin/bash

cd ~/frontend || { echo "Failed to change directory to ~/frontend"; exit 1; }
echo "Changed directory to ~/frontend successfully"

git pull
if [ $? -ne 0 ]; then
    echo "Failed to pull latest changes from git"
    exit 1
fi
echo "Pulled latest changes from git successfully"

sudo cp -a ~/frontend/dist /var/www/html/frontend
if [ $? -ne 0 ]; then
    echo "Failed to copy frontend files to /var/www/html/frontend"
    exit 1
fi
echo "Copied frontend files to /var/www/html/frontend successfully"

sudo docker stop backend
sudo docker rm backend
sudo docker image rm healthylifestyle/backend:0.0.9-test
echo "Stopped and removed backend Docker container and related images successfully"

sudo docker stop postgres
sudo docker rm postgres
sudo docker volume rm postgres_postgres-data
echo "Stopped and removed postgres Docker container and related volumes successfully"

cd ~/config/postgres || { echo "Failed to change directory to ~/config/postgres"; exit 1; }
echo "Changed directory to ~/config/postgres successfully"

sudo docker compose up --force-recreate -d
if [ $? -ne 0 ]; then
    echo "Failed to start postgres container using docker-compose"
    exit 1
fi
echo "Started postgres container using docker-compose successfully"

cd ~/config/backend || { echo "Failed to change directory to ~/config/backend"; exit 1; }
echo "Changed directory to ~/config/backend successfully"

sudo docker compose up --force-recreate -d
if [ $? -ne 0 ]; then
    echo "Failed to start backend container using docker-compose"
    exit 1
fi
echo "Started backend container using docker-compose successfully"

sudo nginx -t
if [ $? -ne 0 ]; then
    echo "Nginx configuration test failed"
    exit 1
fi
echo "Nginx configuration test passed successfully"

sudo systemctl restart nginx
if [ $? -ne 0 ]; then
    echo "Failed to restart nginx service"
    exit 1
fi
echo "Restarted nginx service successfully"

sudo systemctl status nginx