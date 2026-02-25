# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Icarus** is a Flutter mobile app ("Walimurid" — parent-facing school app) that is white-labelable for multiple clients. It uses Riverpod + GoRouter + Dio and follows a clean architecture layered pattern identical to the "gaia" project.

## Common Commands

```bash
# Run default dev flavor
flutter run --dart-define=CLIENT=default --dart-define=ENV=dev

# Run a specific client/env
flutter run --dart-define=CLIENT=mancaksa --dart-define=ENV=prod

# Code generation (Riverpod, Freezed, json_serializable)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation
dart run build_runner watch --delete-conflicting-outputs

# Run tests
flutter test

# Run a single test file
flutter test test/path/to/test_file.dart

# Generate launcher icons for a specific flavor
dart run flutter_launcher_icons -f flutter_launcher_icons-defaultDev.yaml

# Lint
flutter analyze
```

## Architecture

### Multi-Client / Multi-Env System

The app is white-labeled via two Dart compile-time defines:
- `CLIENT` — e.g. `default`, `mancaksa`, `assa`
- `ENV` — e.g. `dev`, `prod`

`BuildEnv` (in `lib/app/environment/build_environment.dart`) reads these via `String.fromEnvironment`. At startup, `AppConfigLoader` loads `assets/clients/<CLIENT>/config.<ENV>.json`, falling back through `dev` → `default/dev`. The JSON provides `appName`, `baseUrl`, `colors`, `brandSpec`, and feature flags.

Client asset directories: `assets/clients/<client>/` (images, icons, config JSON files, launcher icon).

### Layer Structure (per feature)

Each feature under `lib/features/<feature>/` follows:
```
data/
  datasource/       # Remote (Dio) data sources
  models/           # Freezed + json_serializable DTOs
  mappers/          # Model → Entity conversion
  <feature>_repository_impl.dart
domain/
  entities/         # Pure Dart data classes
  repositories/     # Abstract interfaces
  usecase/          # Single-purpose use cases
presentation/
  providers/        # Riverpod controllers/notifiers (@riverpod codegen)
  screens/          # Screen widgets
  widgets/          # Screen-specific widgets
```

### Shared Infrastructure (`lib/shared/`)

- **`core/infrastructure/network/`** — `ApiClient` (Dio builder), `dio_provider.dart` (Riverpod provider with `AuthInterceptor`), `ApiGuard` (response validation helpers)
- **`core/infrastructure/auth/`** — `AuthStateProvider` (token refresh on startup, login/logout), `AuthLocalDataSource`, `AuthInterceptor`
- **`core/infrastructure/routes/app_router.dart`** — GoRouter with redirect guard based on `authStateProvider`; 4 bottom-nav branches: home, performance, chat, profile; login is outside the shell
- **`core/infrastructure/notifications/`** — Firebase Cloud Messaging setup, local notifications
- **`core/infrastructure/analytics/`** — Firebase Analytics via `AnalyticsTracker` abstraction
- **`core/types/`** — `Result<T>` sealed class (`Ok`/`Err`), `Failure` hierarchy, `guard()` async wrapper

### Theming / Branding

- **`BrandPalette`** — `ThemeExtension<BrandPalette>` registered in `MaterialApp`. Access in widgets via `context.brand.primary` etc.
- **`BrandAssets`** — Resolves asset paths per client: `assets/clients/<client>/images/<name>`. Provided as `brandAssetsProvider`.
- **`BrandSpec`** — Controls logo asset paths and login screen layout dimensions, loaded from config JSON.
- Colors come from `config.<env>.json` under the `"colors"` key and are parsed by `BrandPalette.fromConfig()`.

### State Management Patterns

- All providers use **Riverpod code generation** (`@riverpod` / `riverpod_annotation`). Always run `build_runner` after modifying annotated providers.
- Screens use `HookConsumerWidget` (flutter_hooks + hooks_riverpod).
- Controllers are `@riverpod class` notifiers; screens use `ref.listen()` for side-effects (snackbars, navigation).

### Code Generation Files

Files ending in `.g.dart` (Riverpod, json_serializable) and `.freezed.dart` are generated — never edit manually. After changing any `@riverpod`, `@freezed`, or `@JsonSerializable` annotated class, run `build_runner`.

### Feature Flags

Features can be toggled per client/env via the `"features"` map in config JSON (e.g., `"chat": true`). Read via `appConfigProvider.features['chat'] ?? false`.
