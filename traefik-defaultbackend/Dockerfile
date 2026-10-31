FROM nginxinc/nginx-unprivileged:1.30.4-alpine

LABEL org.opencontainers.image.title="traefik-defaultbackend-arm64" \
      org.opencontainers.image.description="Traefik default backend serving the shpaq.org page" \
      org.opencontainers.image.source="https://github.com/shpaq/docker" \
      maintainer="shpaq"

# Content mirrors shpaq.org (cluster/helm/shpaq-org configmap).
COPY site/ /usr/share/nginx/html/

# Base image runs as uid 101 (nginx) and listens on 8080 by design,
# so the hardened pod spec (non-root, drop ALL caps, read-only fs) applies as-is.
EXPOSE 8080

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
