# PHP Docker Patterns (Laravel/Symfony)

## Development Strategy
- **FPM + Nginx**: Typically split into two containers or one with a process manager.
- **UID/GID Sync**: Crucial for `vendor/` and `storage/` permissions.
- **Composer Caching**: Copy `composer.json` and `composer.lock` before `composer install`.
- **PHP 8.3 Alpine**: Use a modern base image.

## Production Strategy
- **OPcache**: Enable and tune for performance.
- **Multi-Stage Build**:
  - `composer`: Install production dependencies.
  - `frontend`: Build assets (if applicable).
  - `runner`: Final optimized FPM image.
- **Nginx Config**: Optimized for the specific framework (e.g., Laravel's `public/index.php`).

## Framework Specifics
- **Laravel**: Run `artisan config:cache`, `route:cache`, `view:cache`.
- **Symfony**: Set `APP_ENV=prod`, run `cache:clear`.
