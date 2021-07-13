BINDIR ?= $(CURDIR)/bin
ARCH   ?= arm64
VERSION?= 0.2.1
HUB=szpaczyn
HUB_IMAGE=version-checker-arm64

default: all

test: ## test version-checker
	go test ./...

build: ## build version-checker
	mkdir -p $(BINDIR)
	CGO_ENABLED=0 go build -o ./bin/version-checker ./cmd/.

verify: test build ## tests and builds version-checker

image: ## build docker image
	GOARCH=$(ARCH) GOOS=linux CGO_ENABLED=0 go build -o ./bin/version-checker-linux ./cmd/.
	docker buildx build --file Dockerfile --label=built-by=shpaq --push --platform linux/arm64 -t registry.shpaq.org/version-checker:$(VERSION) .

release:
	GOARCH=$(ARCH) GOOS=linux CGO_ENABLED=0 go build -o ./bin/version-checker-linux ./cmd/.
	docker buildx build --file Dockerfile --label=build-by=shpaq --push --platform linux/arm64 -t ${HUB}/${HUB_IMAGE}:${VERSION} .


clean: ## clean up created files
	rm -rf \
		$(BINDIR)

all: test build image release clean
