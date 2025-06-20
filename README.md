<h1 align=center>Dockette / MetaMCP</h1>

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

## Development

See [how to contribute](https://contributte.org/contributing.html) to this package.

This package is currently maintaining by these authors.

<a href="https://github.com/f3l1x">
    <img width="80" height="80" src="https://avatars2.githubusercontent.com/u/538058?v=3&s=80">
</a>

-----

Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Also thank you for using this package.
