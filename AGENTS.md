# AGENTS.md

## Project

Dockette MetaMCP is a compose wrapper and upstream image build helper for [MetaMCP](https://github.com/metatool-ai/metatool-app). It builds three Docker image tags from the upstream repository and runs them with Postgres through `docker-compose.yml`.

## Images

- Web image: `dockette/metamcp:web`.
- Migrator image: `dockette/metamcp:migrator`.
- Hosting image: `dockette/metamcp:hosting`.
- Upstream source is cloned into `.tmp/metatool` from `https://github.com/metatool-ai/metatool-app.git`.
- Build platform defaults to `linux/amd64` through `DOCKER_PLATFORM` in `.env.dist`.

## Commands

- `make build` clones or updates the upstream source and builds the three MetaMCP images.
- `make test` validates the compose stack with `docker compose --env-file .env.dist config`.
- `make run` starts the default compose stack.
- `make up-mcp` starts the stack with the optional `mcp` profile.
- `make push` pushes all three image tags.

## Testing Notes

- Prefer `make test` after changes to `.env.dist`, `docker-compose.yml`, or Makefile wiring.
- Use `make -n build test run` to dry-run target wiring without building images.
- Full image builds require Docker Buildx and network access to clone the upstream MetaMCP repository.

## Guidelines

- Keep `.env.dist`, `docker-compose.yml`, Makefile targets, README usage, and `.github/workflows/docker.yml` aligned.
- Use HTTPS for upstream clones so CI does not require SSH credentials.
- Keep compose validation safe and non-invasive; do not start long-running services in CI unless the test is explicitly updated.
- Prefer clear `DOCKER_*` names for Docker image variables and direct compose variable names for stack configuration.
- Place `.PHONY: <target>` directly above each Makefile target.
- Do not add Slack or chat badges; README badges should match the Dockette Copybara badge style.
- Avoid unrelated formatting or structural changes.
