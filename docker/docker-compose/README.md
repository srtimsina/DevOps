# Docker Compose

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

Benefits
1. Tool to create / manage multiple containers.
2. Avoid lots of human errors.
3. Docker compose file will be part of the repository.
4. So developer can use this file to run container and it will be version controlled.
5. Infrastructure as a code.

Using Compose is basically a three-step process:

1. Defining the apps environment with `Dockerfile`.
2. Defining the services that make up app in `docker-compose.yml`.
3. Start and run application service with `docker-compose up`.

Details can be studied from docker official [documentation](https://docs.docker.com/compose/).

## Installation

Refer to docker official [documentation](https://docs.docker.com/compose/install/) for installation instructions 

## docker-compose command

```bash 
# bring up services
docker-compose up

# bring up services in background
docker-compose up -d

# terminate services
docker-compose down

# list running services
docker-compose ps

# list process and resource consumption
docker-compose top
```