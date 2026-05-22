# Node.js Docker Patterns (NestJS/Express)

## Development Strategy
- **Layer Caching**: Copy `package*.json` and framework config (e.g., `nest-cli.json`, `tsconfig.json`) before `npm install`.
- **UID/GID Sync**: Use `ARG USER_ID` and `ARG GROUP_ID` to ensure file ownership matches the host.
- **Node 24 Alpine**: Use a modern, slim base image.
- **Non-Root**: Create and use a dedicated user.

## Production Strategy
- **Multi-Stage Build**:
  - `deps`: Install all dependencies + generate client.
  - `builder`: Build the app.
  - `prod-deps`: Install production-only dependencies.
  - `runner`: Final lean image with only necessary assets.
- **Security**: Remove source code, use `npm ci --only=production`.

## Framework Specifics
- **NestJS**: Ensure `dist/` is copied and `main.js` is the entry point.
- **Prisma**: Always include `prisma.config.ts` and `schema.prisma` in the generation stage.
- **Express**: Simple entry point usually `node dist/index.js`.
