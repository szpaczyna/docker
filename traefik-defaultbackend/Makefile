VERSION ?= v0.1.0
HUB     ?= szpaczyn
HUB_IMAGE ?= defaultbackend-arm64

default: release

image: ## build docker image (linux/arm64)
	docker buildx build --label=built-by=shpaq --platform linux/arm64 \
	  -t ${HUB}/${HUB_IMAGE}:${VERSION} \
	  -t ${HUB}/${HUB_IMAGE}:latest .

run: ## smoke test locally on :8080
	docker run --rm -p 8080:8080 ${HUB}/${HUB_IMAGE}:${VERSION}

release: ## build & push docker image
	docker buildx build --label=built-by=shpaq --push --platform linux/arm64 \
	  -t ${HUB}/${HUB_IMAGE}:${VERSION} \
	  -t ${HUB}/${HUB_IMAGE}:latest .

.PHONY: default image run release
