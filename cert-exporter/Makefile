VERSION?=v2.4.0
REGISTRY="registry.shpaq.org"
IMAGE=cert-exporter
HUB=szpaczyn
HUB_IMAGE=cert-exporter-arm64



GOPATH := $(shell go env GOPATH)
GORELEASER := $(GOPATH)/bin/goreleaser

all: build

$(GORELEASER):
	curl -sfL https://install.goreleaser.com/github.com/goreleaser/goreleaser.sh | BINDIR=$(GOPATH)/bin sh

build: $(GORELEASER)
	$(GORELEASER) build --skip-validate --rm-dist

release-snapshot: $(GORELEASER)
	$(GORELEASER) release --snapshot --skip-publish --rm-dist

release: $(GORELEASER)
	$(GORELEASER) release --rm-dist

clean:
	rm -rf dist

.PHONY: all build release-snapshot release clean

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
