include make_env

# To change the version edit the version.txr file.
VERSION=$(shell cat version.txt) 

.PHONY: build build-nc push push-latest push-version test

# DOCKER TASKS

# Build the container
build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

# Build the container without caching
build-nc: 
	docker build --no-cache -t $(IMAGE_NAME) .
	
# Docker push, create one for snapshot and production, sergii gives the repo names
push: push-latest push-version ## push the `{version}` and `latest` tagged containers

push-latest:  ## push the `latest` taged container
	docker push $(IMAGE_NAME):latest

push-version:  ## push the `{version}` taged container
	docker push $(IMAGE_NAME):$(VERSION)

test:
	@echo 'version is $(VERSION)'

default: build

