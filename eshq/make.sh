#!/bin/bash
#docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --name multiarch --driver docker-container --use
docker buildx inspect --bootstrap

docker buildx build --load --platform linux/arm64 -t registry.shpaq.org/esqh:3.5.12 .
