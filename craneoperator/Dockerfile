# This docker file sets up the rails app container
#
# https://docs.docker.com/reference/builder/

FROM ruby:2.6-alpine

# Add env variables
ENV PORT=80 \
    REGISTRY_HOST=registry.shpaq.org \
    REGISTRY_PORT=5000 \
    REGISTRY_PROTOCOL=https \
    REGISTRY_SSL_VERIFY=true \
    REGISTRY_ALLOW_DELETE=true \
    APP_HOME=/webapp

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY . $APP_HOME

RUN apk add --update nodejs g++ musl-dev make linux-headers yarn && \
    yarn install && \
    node_modules/.bin/webpack && \
    rm -rf node_modules && \
    gem install bundler:1.17.2 && \
    bundle install --deployment && \
    apk del nodejs g++ musl-dev make linux-headers

# Run the app
CMD ["bundle", "exec", "foreman", "start"]
