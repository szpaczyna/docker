FROM ghcr.io/linuxserver/baseimage-alpine:arm64v8-3.13

ENV UBOOQUITY_VERSION=2.1.2

RUN \
  apk --no-cache --update add tzdata curl unzip bash shadow openjdk8-jre-base

WORKDIR /app/ubooquity

RUN \
  mkdir -p /app/ubooquity && \
  curl --retry 8 -s -L -O http://vaemendis.net/ubooquity/downloads/Ubooquity-${UBOOQUITY_VERSION}.zip && \
  unzip Ubooquity-${UBOOQUITY_VERSION}.zip -d /app/ubooquity

RUN \
  mkdir -p /config && \
  mkdir -p /comics && \
  mkdir -p /files

RUN  mkdir -p /config/themes
COPY keystore.jks /config/
COPY root/ /
COPY themes/plextheme-reading /config/themes/

RUN \
  chown 1000:911 -R /config && \
  chown 1000:911 -R /comics && \
  chown 1000:911 -R /files && \
  chown 1000:911 /app/ubooquity -R

EXPOSE 2202 2203
VOLUME /books /comics /config /files
