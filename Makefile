# Include variables
include .env.dist
-include .env
export

up:
	docker compose up

up-mcp:
	docker compose --profile mcp up

enter:
	docker exec -it web bash

download:
	@if [ -d ".tmp/metatool" ]; then \
		cd .tmp/metatool && git pull; \
	else \
		git clone git@github.com:metatool-ai/metatool-app.git .tmp/metatool; \
	fi

build:
	$(MAKE) download
	docker buildx build --platform ${DOCKER_PLATFORM} -t ${DOCKER_WEB_IMAGE} --target runner -f .tmp/metatool/Dockerfile .tmp/metatool
	docker buildx build --platform ${DOCKER_PLATFORM} -t ${DOCKER_MIGRATOR_IMAGE} --target migrator -f .tmp/metatool/Dockerfile .tmp/metatool
	docker buildx build --platform ${DOCKER_PLATFORM} -t ${DOCKER_HOSTING_IMAGE} -f .tmp/metatool/remote-hosting/Dockerfile .tmp/metatool/remote-hosting

push:
	docker push ${DOCKER_WEB_IMAGE}
	docker push ${DOCKER_MIGRATOR_IMAGE}
	docker push ${DOCKER_HOSTING_IMAGE}
