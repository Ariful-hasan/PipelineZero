---
name: universal-docker-standard
description: Generates high-performance, secure, and production-ready Docker configurations (dev + prod) for Node.js (NestJS, Express) and PHP (Laravel, Symfony) frameworks. Use this skill when asked to dockerize an application, set up a development container environment, or create production Dockerfiles.
---

# Universal Docker Standard

This skill provides a comprehensive workflow for dockerizing modern web applications with a focus on build performance, security, and developer ergonomics.

## Workflow

1.  **Framework Identification**:
    *   Analyze `package.json` for Node.js (NestJS, Express).
    *   Analyze `composer.json` for PHP (Laravel, Symfony).
    *   Identify database and cache requirements (Prisma, Eloquent, Redis, etc.).

2.  **Configuration Loading**:
    *   For Node.js apps: Read [node-base.md](references/node-base.md).
    *   For PHP apps: Read [php-base.md](references/php-base.md).
    *   For service orchestration: Read [docker-compose-patterns.md](references/docker-compose-patterns.md).

3.  **Directory Structure**:
    *   Create a `docker/` directory in the project root.
    *   Place `Dockerfile.dev` and `Dockerfile.prod` inside the `docker/` directory.

4.  **Implementation - Dockerfile.dev**:
    *   **Layer Caching**: Always copy dependency lockfiles and configuration files before running install commands.
    *   **UID/GID Synchronization**: Implement `ARG USER_ID` and `ARG GROUP_ID` to match the host user.
    *   **Framework Tasks**: Run necessary generation steps (e.g., `npx prisma generate`) **after** install but **before** copying the rest of the source code, using dummy environment variables where necessary.

5.  **Implementation - Dockerfile.prod**:
    *   **Multi-Stage**: Use multi-stage builds to produce the smallest possible final image.
    *   **Pruning**: Use `--only=production` for Node.js or `--no-dev` for PHP.
    *   **Minimal Base**: Use Alpine-based images where possible.

6.  **Implementation - Docker Compose**:
    *   Create `docker-compose.yml` for development (with volumes).
    *   Create `docker-compose.prod.yml` for production (without source volumes).
    *   Implement robust health checks for all service dependencies.

7.  **Verification**:
    *   Explain the UID/GID sync to the user.
    *   Provide commands for building and running (e.g., `docker-compose up --build`).

## Standards
- **Never hardcode secrets**: Use environment variables.
- **Rootless execution**: Always switch to a non-root user in the final stage.
- **Quiet flags**: Use `-q` or `--silent` for package managers.
- **Modern images**: Default to Node 24+ or PHP 8.3+.
