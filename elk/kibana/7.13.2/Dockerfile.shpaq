FROM alpine:latest

## Setting the environment
ENV APP=kibana
ENV UID=1000
ENV GID=1000
ENV ELASTIC_CONTAINER true
ENV PATH /usr/share/kibana:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:\$PATH
ENV VERSION=7.13.2-linux-aarch64

WORKDIR /usr/share/kibana

## Update latest packges and install needed
RUN apk update && \
    apk add tar curl ca-certificates bash tzdata

## Create APP and group
RUN addgroup --gid "$GID" --system "$APP" && \
    adduser \
    --disabled-password \
    --gecos "" \
    --home "/usr/share/kibana" \
    --ingroup "$APP" \
    --no-create-home \
    --uid "$UID" \
    "$APP"

## Downloading and Installing Kibana (TAR)
RUN cd /opt && \
    curl --retry 8 -s -L -O https://artifacts.elastic.co/downloads/$APP/$APP-$VERSION.tar.gz && \
    cd -
RUN tar zxf /opt/$APP-$VERSION.tar.gz --strip-components=1

## Configuring Kibana
ADD config config
RUN chmod 0775 /usr/share/kibana && \
    chgrp 0 /usr/share/kibana && \
    chown kibana /usr/share/kibana -R

COPY --chown=1000:0 bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chgrp 0 /usr/local/bin/docker-entrypoint.sh && \
    chmod g=u /etc/passwd && \
    chmod 0775 /usr/local/bin/docker-entrypoint.sh

EXPOSE 5601/tcp

LABEL maintainer="shpaq@shpaq.org" \
  org.opencontainers.image.created="2021-07-04" \
  org.opencontainers.image.documentation="https://www.elastic.co/guide/en/kibana/reference/index.html" \
  org.opencontainers.image.licenses="Apache-2.0-License" \
  org.opencontainers.image.source="https://github.com/elastic/kibana" \
  org.opencontainers.image.title="Kibana" \
  org.opencontainers.image.url="https://www.elastic.co/products/kibana" \
  org.opencontainers.image.vendor="Elastic" \
  org.opencontainers.image.version="7.13.2"
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
