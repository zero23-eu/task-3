APP := server
REGISTRY ?= quay.io/example
TAG ?= latest
IMAGE_TAG := $(REGISTRY)/$(APP):$(TAG)

HOST_OS := $(shell go env GOOS)
HOST_ARCH := $(shell go env GOARCH)

.PHONY: linux arm macos windows image clean test

test:
	go test ./...

linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/$(APP)-linux-amd64 .

arm:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o bin/$(APP)-linux-arm64 .

macos:
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -o bin/$(APP)-darwin-arm64 .

windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o bin/$(APP)-windows-amd64.exe .

image:
	docker build --build-arg TARGETOS=$(HOST_OS) --build-arg TARGETARCH=$(HOST_ARCH) -t $(IMAGE_TAG) .

clean:
	rm -rf bin
	docker rmi $(IMAGE_TAG)
