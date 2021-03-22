# docker-squid

Docker Squid container based on Alpine Linux.
 builds of the image are available on [Dockerhub](https://hub.docker.com/r/b4tman/squid).

# Configuration

## Environment variables:

- **SQUID_CONFIG_FILE**: Specify the configuration file for squid. Defaults to `/etc/squid/squid.conf`.

This will start a squid container with your config file `/srv/docker/squid/squid.conf`. 
