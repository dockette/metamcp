<h1 align=center>Dockette / MetaMCP</h1>

<p align=center>
   <a href="https://github.com/dockette/metamcp/actions"><img src="https://github.com/dockette/metamcp/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/metamcp"><img src="https://img.shields.io/docker/pulls/dockette/metamcp.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   🐳 <a href="https://github.com/metatool-ai/metatool-app">MetaMCP</a> is a unified middleware MCP to manage all your MCPs
</p>

-----

Prebuilt Docker images for MetaMCP, built for `linux/amd64` from the [metatool-ai/metatool-app](https://github.com/metatool-ai/metatool-app) release pinned in `VERSION`.

- `dockette/metamcp:web` - Web interface for MetaMCP
- `dockette/metamcp:migrator` - Migrator for MetaMCP
- `dockette/metamcp:hosting` - Hosting for MetaMCP

## Usage

1. Create `.env` file.

```env
# Docker images
DOCKER_WEB_IMAGE=dockette/metamcp:web
DOCKER_MIGRATOR_IMAGE=dockette/metamcp:migrator
DOCKER_HOSTING_IMAGE=dockette/metamcp:hosting

# Docker: metamcp
NODE_ENV=production
DATABASE_URL=postgresql://metamcp:metamcp@postgres:5432/metamcp
USE_DOCKER_HOST=true
BASIC_AUTH_USERNAME=admin
BASIC_AUTH_PASSWORD=metamcp

# Docker: postgres
POSTGRES_DB=metamcp
POSTGRES_USER=metamcp
POSTGRES_PASSWORD=metamcp
```

2. Create `docker-compose.yml` file.

Copy [`docker-compose.yml`](./docker-compose.yml) file.

3. Start Docker services.

```sh
docker compose up
```

4. Open `http://localhost:12005` in your browser.

5. Login with `admin` and `metamcp`.

## MCP

### Atlassian

1. Start Docker services with `mcp` profile.

```sh
docker compose --profile mcp up
```

2. Add the MCP to MetaMCP.

URL: `http://host.docker.internal:20001/sse`
Type: `SSE`

3. Add the MCP to your app (Cursor / Claude).

```json
{
  "mcpServers": {
    "metamcp": {
      "url": "http://localhost:12007/api-key/{api-key}/sse"
    }
  }
}
```

> [!TIP]
> For more detailed configuration options, please refer to the [MetaMCP official documentation](https://github.com/metatool-ai/metatool-app).

## Versions

Every image is published as `dockette/metamcp:<variant>`, where `<variant>` is `web`, `migrator` or `hosting`.
`YYYY.MM.DD` is the release date from `VERSION`.

| Tag                                                 | Description                                                    |
|-----------------------------------------------------|----------------------------------------------------------------|
| `dockette/metamcp:<variant>`                        | latest build of `master`                                       |
| `dockette/metamcp:<variant>-YYYY.MM.DD`             | `<variant>` image of release `YYYY.MM.DD`                      |
| `dockette/metamcp:<variant>-0.6.0`                  | `<variant>` image with metatool-app `0.6.0`                    |
| `dockette/metamcp:<variant>-0.6.0-YYYY.MM.DD`       | `<variant>` image with metatool-app `0.6.0`, release `YYYY.MM.DD` |

There is no `latest` tag; pick a variant. All versions build metatool-app `0.6.0`, pinned by `METAMCP_VERSION` in `VERSION`.
Releases are listed on [GitHub](https://github.com/dockette/metamcp/releases).

## Development

```sh
make download                   # clone the pinned metatool-app release into .tmp/metatool
make build-all                  # download and build all variants for linux/amd64
make test-all                   # node/pnpm version in every image
make build DOCKER_VARIANT=web   # build one variant (run make download first)
make push-all                   # build and push all variants with all tags
make version                    # print VERSION
make release                    # set today's date in VERSION
make up                         # docker compose up
make up-mcp                     # docker compose up with the mcp profile
```

See [how to contribute](https://contributte.org/contributing.html) to this package.

This package is currently maintaining by these authors.

<a href="https://github.com/f3l1x">
    <img width="80" height="80" src="https://avatars2.githubusercontent.com/u/538058?v=3&s=80">
</a>

-----

Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Also thank you for using this package.
