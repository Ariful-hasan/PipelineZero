# Docker Compose Patterns

## Service Health Checks
- **Postgres**: `pg_isready -U ${DB_USER} -d ${DB_NAME}`
- **Redis**: `redis-cli ping`
- **MySQL**: `mysqladmin ping -h localhost`

## Development Configuration
- **Volumes**: Mount current directory to `/app`.
- **Node Modules**: Use an anonymous volume (`/app/node_modules`) to prevent host-container conflicts.
- **Environment**: Load from `.env` file.

## Network Strategy
- Use a dedicated bridge network for service isolation.

## Production Configuration
- **Restart Policy**: `unless-stopped` or `always`.
- **Volumes**: Keep volumes minimal, usually only for persistent data (DB, Redis, Logs).
- **Security**: Don't expose database ports to the host unless necessary.
