VERSION?=v7.5.1
REGISTRY="registry.shpaq.org"
IMAGE=elasticsearch

build-push:
	docker buildx build --push --platform linux/arm64/v8 -t ${REGISTRY}/${IMAGE}:${VERSION} .

build-local:
	docker buildx build --load --platform linux/arm64/v8 -t ${IMAGE}:${VERSION} .
