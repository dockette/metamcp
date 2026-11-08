# Include variables
include .env.dist
-include .env
include VERSION
export

DOCKER_IMAGE?=dockette/metamcp
DOCKER_VARIANT?=web
DOCKER_TAG?=$(DOCKER_VARIANT)
VARIANTS=web migrator hosting

# Upstream source, a pinned release of metatool-ai/metatool-app
METAMCP_DIR=.tmp/metatool

# What to build per variant: web and migrator are targets of the upstream Dockerfile, hosting is its own Dockerfile
ifeq ($(DOCKER_VARIANT),web)
DOCKER_BUILD_ARGS=--target runner -f ${METAMCP_DIR}/Dockerfile ${METAMCP_DIR}
else ifeq ($(DOCKER_VARIANT),migrator)
DOCKER_BUILD_ARGS=--target migrator -f ${METAMCP_DIR}/Dockerfile ${METAMCP_DIR}
else ifeq ($(DOCKER_VARIANT),hosting)
DOCKER_BUILD_ARGS=-f ${METAMCP_DIR}/remote-hosting/Dockerfile ${METAMCP_DIR}/remote-hosting
endif

# One build, four tags per variant: <variant>, <variant>-<date>, <variant>-<metamcp> and <variant>-<metamcp>-<date>.
# There is no `latest`, because the repository holds several variants.
DOCKER_PUSH_TAGS=-t ${DOCKER_IMAGE}:${DOCKER_TAG} -t ${DOCKER_IMAGE}:${DOCKER_TAG}-${VERSION} -t ${DOCKER_IMAGE}:${DOCKER_TAG}-${METAMCP_VERSION} -t ${DOCKER_IMAGE}:${DOCKER_TAG}-${METAMCP_VERSION}-${VERSION}

.PHONY: up
up:
	docker compose up

.PHONY: up-mcp
up-mcp:
	docker compose --profile mcp up

.PHONY: enter
enter:
	docker exec -it web bash

# Clone the pinned tag, shallow. A checkout of another ref is replaced.
.PHONY: download
download:
	@if [ -d "${METAMCP_DIR}" ] && [ "$$(git -C ${METAMCP_DIR} describe --tags --exact-match 2>/dev/null)" != "v${METAMCP_VERSION}" ]; then \
		rm -rf "${METAMCP_DIR}"; \
	fi
	@if [ ! -d "${METAMCP_DIR}" ]; then \
		git clone --depth 1 --branch v${METAMCP_VERSION} https://github.com/metatool-ai/metatool-app.git ${METAMCP_DIR}; \
	fi

.PHONY: build
build:
	docker buildx build --platform ${DOCKER_PLATFORM} --load -t ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_BUILD_ARGS}

.PHONY: build-all
build-all: download
	for variant in ${VARIANTS}; do $(MAKE) build DOCKER_VARIANT=$$variant || exit 1; done

.PHONY: test
test:
	if [ "${DOCKER_VARIANT}" = migrator ]; then \
		docker run --rm --platform ${DOCKER_PLATFORM} --entrypoint pnpm ${DOCKER_IMAGE}:${DOCKER_TAG} --version; \
	else \
		docker run --rm --platform ${DOCKER_PLATFORM} --entrypoint node ${DOCKER_IMAGE}:${DOCKER_TAG} --version; \
	fi

.PHONY: test-all
test-all:
	for variant in ${VARIANTS}; do $(MAKE) test DOCKER_VARIANT=$$variant || exit 1; done

.PHONY: push
push:
	docker buildx build --platform ${DOCKER_PLATFORM} ${DOCKER_PUSH_TAGS} --push ${DOCKER_BUILD_ARGS}

.PHONY: push-all
push-all:
	for variant in ${VARIANTS}; do $(MAKE) push DOCKER_VARIANT=$$variant || exit 1; done

.PHONY: version
version:
	@echo ${VERSION}

.PHONY: release
release:
	@sed -i.bak "s/^VERSION=.*/VERSION=$$(date -u +%Y.%m.%d)/" VERSION && rm VERSION.bak
	@cat VERSION
