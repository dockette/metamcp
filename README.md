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

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

-----

## Motivation

This repository provides prebuild docker images for MetaMCP.

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

```
docker compose up
```

4. Open `http://localhost:12005` in your browser.

5. Login with `admin` and `metamcp`.

## MCP

### Atlassian

1. Start Docker services with `mcp` profile.

```
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

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
