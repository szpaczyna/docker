FROM alpine:latest

## Setting the environment
ENV APP=logstash
ENV UID=1000
ENV GID=1000
ENV ELASTIC_CONTAINER true
ENV PATH /usr/share/logstash:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:\$PATH
ENV VERSION=7.12.0-linux-aarch64

WORKDIR /usr/share/logstash

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

## Downloading and Installing Logstash (TAR)
RUN cd /opt && \
    curl --retry 8 -s -L -O https://artifacts.elastic.co/downloads/$APP/$APP-$VERSION.tar.gz && \
    cd -
RUN tar zxf /opt/$APP-$VERSION.tar.gz --strip-components=1

## Configuring Logstash
RUN mkdir -p {config,data}
RUN mkdir -p /etc/logstash/{conf.d,patterns,logs}
RUN chmod 0775 config data && \
    chmod 0775 /etc/logstash -R

COPY config/log4j2.properties config/jvm.options config/logstash.yml /etc/logstash/
RUN chmod 0660 config/log4j2.properties \
    config/jvm.options

RUN chmod 0775 /usr/share/logstash && \
    chgrp 0 /usr/share/logstash && \
    chown logstash /usr/share/logstash -R

COPY --chown=1000:0 bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chgrp 0 /usr/local/bin/docker-entrypoint.sh && \
    chmod g=u /etc/passwd && \
    chmod 0775 /usr/local/bin/docker-entrypoint.sh

EXPOSE 5044/tcp
EXPOSE 5045/tcp
EXPOSE 9600/tcp

LABEL maintainer="shpaq@shpaq.org" \
  org.opencontainers.image.created="2021-04-05" \
  org.opencontainers.image.documentation="https://www.elastic.co/guide/en/logstash/reference/index.html" \
  org.opencontainers.image.licenses="Apache-2.0-License" \
  org.opencontainers.image.source="https://github.com/elastic/logstash" \
  org.opencontainers.image.title="Logstash" \
  org.opencontainers.image.url="https://www.elastic.co/products/logstash" \
  org.opencontainers.image.vendor="Elastic" \
  org.opencontainers.image.version="7.12.0"
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
