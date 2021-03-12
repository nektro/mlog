---
title: "Auto Domain Reverse Proxy and TLS with Nginx in Docker-Compose"
date: 2021-03-11T22:01:30-08:00
---

```yml
services:
  nginx-proxy:
    image: jwilder/nginx-proxy:alpine
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
      - ./data/nginx/etc/certs:/etc/nginx/certs
      - ./data/nginx/etc/vhost.d:/etc/nginx/vhost.d
      - ./data/nginx/usrshare/html:/usr/share/nginx/html
    ports:
      - "80:80"
      - "443:443"

  nginx-letsencrypt:
    image: jrcs/letsencrypt-nginx-proxy-companion
    volumes_from:
      - nginx-proxy
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./data/nginx-le/acme.sh:/etc/acme.sh
    environment:
      DEFAULT_EMAIL: "${DEFAULT_EMAIL}"
```

Local data that you would potentially want to backup in a prod environment is saved at `./data/nginx/`.

This configuration will automatically setup an nginx reverse proxy config for hosting a container at a specific domain and with TLS using Let's Encrypt. Any certificate notifications will be sent to `DEFAULT_EMAIL`.

The `nginx-proxy` container will look for any containers that have the `VIRTUAL_HOST` environment variable.

So to enable this on another container (that for example uses port `8000`) in the same docker network, add this:

```yml
services:
  app:
    # ...
    ports:
      - "8000"
    environment:
      VIRTUAL_PORT: "8000"
      VIRTUAL_HOST: example.com
      LETSENCRYPT_HOST: example.com
```
