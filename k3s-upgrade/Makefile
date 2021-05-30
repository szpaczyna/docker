VERSION?=v1.20.5-rc1+k3s1
REGISTRY="registry.shpaq.org"
IMAGE=ks3-upgrade
HUB=szpaczyn
HUB_IMAGE=k3s-upgrade-arm64

default: build-push

reset-env:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx create --name multiarch --driver docker-container --use
	docker buildx inspect --bootstrap

build-push:
	docker buildx build --file Dockerfile --label=built-by=shpaq --push --platform linux/arm64 -t ${REGISTRY}/${IMAGE}:${VERSION} .

build-hub:
	docker buildx build --file Dockerfile --label=build-by=shpaq --push --platform linux/arm64 -t ${HUB}/${HUB_IMAGE}:${VERSION} .

build-local:
	docker buildx build --load --platform linux/arm64 -t ${IMAGE}:${VERSION} .
