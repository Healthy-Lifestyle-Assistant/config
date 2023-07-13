# Run container, or create and run if not created yet
docker compose [-f <path/to/docker-compose.yml>] up [<container_name>] [--force-recreate] [-d]

# Stop container
docker compose down [<container_name>]

# List all running containers
docker ps

# List all containers
docker ps -a

# Logs
docker compose logs <container_name_or_id>

# Run bash inside docker container
docker exec -it <container_name_or_id> bash

# Run container from image, expose ports
docker run [-d] [-p <host_port>:<container_port>] <image_name>
