VERSION?=3.5.12
#REGISTRY="registry.shpaq.org"
REGISTRY=szpaczyn
IMAGE=elastic-hq

build-push:
	docker buildx build --push --platform linux/arm64 -t ${REGISTRY}/${IMAGE}:${VERSION} .

build-local:
	docker buildx build --load --platform linux/arm64 -t ${IMAGE}:${VERSION} .

