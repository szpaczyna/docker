VERSION?=v7.5.1
#REGISTRY="registry.shpaq.org"
REGISTRY=szpaczyn
IMAGE=kibana-arm64

build-push:
	docker buildx build --push --platform linux/arm64 -t ${REGISTRY}/${IMAGE}:${VERSION} .

build-local:
	docker buildx build --load --platform linux/arm64 -t ${IMAGE}:${VERSION} .
