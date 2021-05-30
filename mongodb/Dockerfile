FROM alpine:latest

MAINTAINER Michal 'shpaq' Laszuk

WORKDIR /root

ENV CRON_ENABLED true
ENV USER=mongodb
ENV UID=1000
ENV GID=1000
ENV DIR=/var/lib/mongodb

RUN mkdir -p "$DIR"

RUN addgroup \
  --gid "$GID" \
  --system \
  "$USER"

RUN adduser \
  --disabled-password \
  --shell /bin/bash \
  --home "$DIR" \
  --ingroup "$USER" \
  --no-create-home \
  --uid "$UID" \
  "$USER"

RUN \
  echo 'http://dl-cdn.alpinelinux.org/alpine/v3.9/main' >> /etc/apk/repositories && \
  echo 'http://dl-cdn.alpinelinux.org/alpine/v3.9/community' >> /etc/apk/repositories

RUN \
  apk update && \
  apk add \
    tzdata \
    ca-certificates \
    bash \
    s6 \
    curl \
    ncurses \
    tar \
    vim \
    rsync \
    shadow \
    su-exec \
    tini \
    mongodb \
    mongodb-tools \
    jq \
    yaml-cpp=0.6.2-r2

RUN \
  cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && \
  echo "Europe/Warsaw" >  /etc/timezone

RUN \
  rm -rf \
    /var/cache/apk/* \
    /var/lib/mongodb/*

COPY root/ /

EXPOSE 27017
EXPOSE 27018
EXPOSE 27019

VOLUME ["/var/lib/mongodb", "/var/lib/backup"]
CMD ["/bin/s6-svscan", "/etc/s6"]
