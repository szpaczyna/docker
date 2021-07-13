#!/bin/bash

set -e
umask 0002
declare -a es_opts

while IFS='=' read -r envvar_key envvar_value
do
    # Elasticsearch env vars need to have at least two dot separated lowercase words, e.g. `cluster.name`
    if [[ "$envvar_key" =~ ^[a-z0-9_]+\.[a-z0-9_]+ ]]; then
        if [[ ! -z $envvar_value ]]; then
          es_opt="-E${envvar_key}=${envvar_value}"
          es_opts+=("${es_opt}")
        fi
    fi
done < <(env)

export ES_JAVA_OPTS="-Des.cgroups.hierarchy.override=/ $ES_JAVA_OPTS"

## Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

## Drop root privileges if we are running elasticsearch and allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	## Change the ownership of userw-mutable directories to elasticsearch
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/{data,logs}
	set -- su-exec elasticsearch "$@" "${es_opts[@]}"
fi

ls -l /usr/share/elasticsearch/jdk/bin/java
/usr/share/elasticsearch/jdk/bin/java

exec "$@"
