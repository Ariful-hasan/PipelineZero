# PipelineZero Project Instructions

## Engineering Standards
- **Version Awareness**: ALWAYS audit `package.json` before implementing or fixing issues related to third-party libraries (Prisma, NestJS, etc.). Do not assume standard patterns apply without verifying version-specific breaking changes.
- **Prisma 7 Protocol**: 
    - NEVER use `url` in `prisma/schema.prisma`. All datasource configuration must live in `prisma.config.ts`.
    - ALWAYS use Driver Adapters (e.g., `@prisma/adapter-pg`) for database connections in `PrismaService`.
- **Docker & Permissions**: 
    - Maintain UID/GID synchronization in `Dockerfile.dev` to ensure files generated in-container are owned by the host user.
    - Always use non-root users in development containers.

## Architecture
- **NestJS Modules**: Ensure all shared services (like `PrismaService`) are exported from their respective modules and imported where needed. Avoid "magic" global providers unless explicitly configured.
- **Composition over Inheritance**: For `PrismaService`, prefer extending `PrismaClient` but ensure proper constructor initialization for adapters.
