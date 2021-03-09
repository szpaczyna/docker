VERSION?=v20.2.5
#REGISTRY="registry.shpaq.org"
REGISTRY=szpaczyn
IMAGE=cockroachdb

build-push:
	docker buildx build --push --platform linux/arm64 -t ${REGISTRY}/${IMAGE}:${VERSION} .

build-local:
	docker buildx build --load --platform linux/arm64 -t ${IMAGE}:${VERSION} .
