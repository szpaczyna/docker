ARG ARCH="arm64"
ARG OS="linux"
FROM quay.io/prometheus/busybox-${OS}-${ARCH}:glibc
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

ARG ARCH="arm64"
ARG OS="linux"

COPY elasticsearch_exporter /bin/elasticsearch_exporter

EXPOSE      9114
USER        nobody
ENTRYPOINT  [ "/bin/elasticsearch_exporter" ]
