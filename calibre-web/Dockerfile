FROM ubuntu:latest

# set version label
ARG BUILD_DATE
ARG VERSION
ENV CALIBREWEB_RELEASE=0.6.12

WORKDIR /app/calibre-web

## set timezone
RUN apt update && apt install tzdata -y
RUN echo "Europe/Warsaw" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

## update system packages
RUN apt update && \
    apt upgrade -y

## Install compile stuff
RUN apt install -y \
    g++ \
    gcc \
    git \
    libffi-dev \
    libjpeg-dev \
    libldap2-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev \
    python3-pip \
    zlib1g-dev

## install runtime packages
RUN apt install -y \
    imagemagick \
    libldap-2.4-2 \
    libnss3 \
    libsasl2-2 \
    libxcomposite1 \
    libxi6 \
    libxrandr2 \
    libxslt1.1 \
    python3-minimal \
    python3-pkg-resources \
    unrar \
    curl

## set python3 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

## add dedicated user
RUN adduser \
    --uid 1001 \
    --home /config \
    calibre

## Install calibre-web
RUN mkdir -p /app/calibre-web && \
    mkdir -p /books
RUN  curl --retry 8 -sL https://github.com/janeczku/calibre-web/archive/${CALIBREWEB_RELEASE}.tar.gz | tar -xz --strip-components=1
#RUN curl --retry 8 -sLhttps://codeload.github.com/janeczku/calibre-web/tar.gz/${CALIBREWEB_RELEASE} | tar -xz --strip-components=1

RUN pip3 install --no-cache-dir -U pip && \
    pip install --no-cache-dir -U --find-links https://wheel-index.linuxserver.io/ubuntu/ -r \
    requirements.txt -r \
    optional-requirements.txt

## install fast converter
RUN KEPUBIFY_RELEASE=$(curl -sX GET "https://api.github.com/repos/pgaskin/kepubify/releases/latest" \
      | awk '/tag_name/{print $4;exit}' FS='[""]'); \
    curl -o \
    /usr/bin/kepubify -L \
    https://github.com/pgaskin/kepubify/releases/download/${KEPUBIFY_RELEASE}/kepubify-linux-arm64 && \
    chmod +x /usr/bin/kepubify

## cleaunup
RUN apt -y purge \
    g++ \
    gcc \
    git \
    libffi-dev \
    libjpeg-dev \
    libldap2-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev \
    python3-pip \
    zlib1g-dev

RUN apt -y autoremove && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /root/.cache

## add local files
COPY defaults/client_secrets.json /config
COPY defaults/app.db /books

## fix perms
RUN chown calibre:calibre /config /books /app/calibre-web -R

## run as dedicated user
#USER calibre

## ports and volumes
EXPOSE 8083/tcp

VOLUME /config
VOLUME /books

CMD ["/app/calibre-web/cps.py", "-p", "/config/cw.db", "-i", "0.0.0.0"]
