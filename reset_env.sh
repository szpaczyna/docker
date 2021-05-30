#!/bin/bash
#docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker run --name arm64_buildkit --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --name multiarch --driver docker-container --use
docker buildx inspect --bootstrap
