# Include variables
include .env.dist
-include .env
export

.PHONY: run
run:
	docker compose up

.PHONY: up
up: run

.PHONY: up-mcp
up-mcp:
	docker compose --profile mcp up

.PHONY: enter
enter:
	docker exec -it web bash

.PHONY: download
download:
	@if [ -d ".tmp/metatool" ]; then \
		cd .tmp/metatool && git pull; \
	else \
		git clone https://github.com/metatool-ai/metatool-app.git .tmp/metatool; \
	fi

.PHONY: build
build: download
	docker buildx build --platform ${DOCKER_PLATFORM} -t ${DOCKER_WEB_IMAGE} --target runner -f .tmp/metatool/Dockerfile .tmp/metatool
	docker buildx build --platform ${DOCKER_PLATFORM} -t ${DOCKER_MIGRATOR_IMAGE} --target migrator -f .tmp/metatool/Dockerfile .tmp/metatool
	docker buildx build --platform ${DOCKER_PLATFORM} -t ${DOCKER_HOSTING_IMAGE} -f .tmp/metatool/remote-hosting/Dockerfile .tmp/metatool/remote-hosting

.PHONY: test
test:
	docker compose --env-file .env.dist config

.PHONY: push
push:
	docker push ${DOCKER_WEB_IMAGE}
	docker push ${DOCKER_MIGRATOR_IMAGE}
	docker push ${DOCKER_HOSTING_IMAGE}
