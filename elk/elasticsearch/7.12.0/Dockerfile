FROM alpine:latest

## Setting the environment
ENV APP=elasticsearch
ENV UID=1000
ENV GID=1000
ENV ELASTIC_CONTAINER true
ENV PATH /usr/share/elasticsearch:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:\$PATH
ENV VERSION=7.12.0-linux-aarch64

WORKDIR /usr/share/elasticsearch

## Update latest packges and install needed
RUN apk update && \
    apk add tar curl ca-certificates bash tzdata

## Create APP and group
RUN addgroup --gid "$GID" --system "$APP" && \
    adduser \
    --disabled-password \
    --gecos "" \
    --home "/usr/share/logstash" \
    --ingroup "$APP" \
    --no-create-home \
    --uid "$UID" \
    "$APP"

## Downloading and Installing Elasticsearch (TAR)
RUN cd /opt && \
    curl --retry 8 -s -L -O https://artifacts.elastic.co/downloads/"$APP"/"$APP"-"$VERSION".tar.gz && \
    cd -
RUN tar zxf /opt/"$APP"-"$VERSION".tar.gz --strip-components=1
RUN grep ES_DISTRIBUTION_TYPE=tar /usr/share/elasticsearch/bin/elasticsearch-env \
    && sed -i -e 's/ES_DISTRIBUTION_TYPE=tar/ES_DISTRIBUTION_TYPE=docker/' /usr/share/elasticsearch/bin/elasticsearch-env

## Configuring Elastisearch
RUN mkdir -p -m775 data logs nodes
ADD config config
RUN chmod 0775 /usr/share/elasticsearch && \
    chgrp 0 /usr/share/elasticsearch && \
    chown elasticsearch /usr/share/elasticsearch -R

COPY --chown=1000:0 bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENV ELASTIC_CONTAINER true
RUN chgrp 0 /usr/local/bin/docker-entrypoint.sh && \
    chmod g=u /etc/passwd && \
    chmod 0775 /usr/local/bin/docker-entrypoint.sh

EXPOSE 9200/tcp
EXPOSE 9300/tcp

LABEL maintainer="shpaq@shpaq.org" \
  org.opencontainers.image.created="2021-04-05" \
  org.opencontainers.image.documentation="https://www.elastic.co/guide/en/elasticsearch/reference/index.html" \
  org.opencontainers.image.licenses="Apache-2.0-License" \
  org.opencontainers.image.source="https://github.com/elastic/elasticsearch" \
  org.opencontainers.image.title="Elasticsearch" \
  org.opencontainers.image.url="https://www.elastic.co/products/elasticsearch" \
  org.opencontainers.image.vendor="Elastic" \
  org.opencontainers.image.version="7.12.0"

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["eswrapper"]
