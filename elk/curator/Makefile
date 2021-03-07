VERSION?=5.8.3
REGISTRY="registry.shpaq.org"
IMAGE=elk-curator

build-push:
	docker buildx build --push --platform linux/arm64 -t ${REGISTRY}/${IMAGE}:${VERSION} .

build-local:
	docker buildx build --load --platform linux/arm64 -t ${IMAGE}:${VERSION} .
