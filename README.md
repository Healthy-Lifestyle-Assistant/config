# Configuration

[Setup Nginx](#setup-nginx)  
[Create Docker Networks](#create-docker-networks)    
[Run Docker Containers](#run-docker-containers)  
[Configure Grafana](#configure-grafana)  
[Useful Docker Commands](#useful-docker-commands)  

## Setup Nginx

### Configure Nginx

```sh
cd ~
git clone https://github.com/Healthy-Lifestyle-App/config.git
sudo cp ~/config/nginx/nginx.config /etc/nginx/sites-available/
sed -i 's/domain_or_IP/<you_domain_or_IP>' /etc/nginx/sites-available/nginx.config
sudo ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/
```

### Copy static files (html, css, js)

```sh
cd ~
git clone https://github.com/Healthy-Lifestyle-Assistant/client.git
sudo cp -a ~/client/dist /var/www/html
# alternative
# sudo cp -a ~/client/dist /usr/share/nginx/html
```

### Restart

```sh
sudo nginx -t
sudo systemctl restart nginx
```

[Top](#configuration)


## Create Docker Networks

```sh
# Create networks
docker network create common
docker network create metrics

# List networks to verify
docker network ls
```

[Top](#configuration)


## Run Docker Containers

### Run PostgreSQL Container

```sh
cd ~/config/postgres
cp .env_template .env
# add your env variables to .env
vim .
docker-compose up [--force-recreate] -d
```

Note, that PostgreSQL container will automatically create a database with username and password,
provided in your .env file.

### Run Application Container

```sh
cd ~/config/app
cp .env_template .env
# add your env variables to .env
vim .
docker-compose up [--force-recreate] -d
```

### Run Prometheus Container

```sh
cd ~/config/prometheus
docker-compose up [--force-recreate] -d
```

### Run Grafana Container

```sh
cd ~/config/grafana
docker-compose up [--force-recreate] -d
```

[Top](#configuration)


### Configure Grafana

Actuator is available at http://localhost:8085/actuator/prometheus

Grafana's default port is 3000. So, it is available at http://localhost:3000/
with default login: `admin` and default password: `admin`. As you logged, add data source > Prometheus > http://prometheus:9090.
Then, Import dashboard > by id > 4701.

References: 

https://grafana.com/grafana/dashboards/4701-jvm-micrometer/

https://grafana.com/docs/grafana/latest/dashboards/manage-dashboards/#import-a-dashboard

[Top](#configuration)


## Useful Docker Commands

```sh
# Run container, or create and run if not created yet
docker-compose [-f <path/to/docker-compose.yml>] up [<container_name>] [--force-recreate] [-d]

# Stop container
docker-compose down [<container_name>]

# List all running containers
docker ps

# List all containers
docker ps -a

# Logs
docker-compose logs <container_name_or_id>

# Run bash inside docker container
docker exec -it <container_name_or_id> bash

# Run container from image, expose ports
docker run [-d] [-p <host_port>:<container_port>] <image_name>

# Create networks
docker network create common
docker network create metrics

# List networks
docker network ls
```

[Top](#configuration)
