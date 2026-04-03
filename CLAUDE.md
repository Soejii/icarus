# CLAUDE.md

**Icarus** is a Flutter mobile app ("Walimurid", parent-facing school app), white-labelable for multiple clients. Uses Riverpod + GoRouter + Dio, clean architecture identical to the "gaia" project.

## Common Commands

```bash
flutter run --dart-define=CLIENT=default --dart-define=ENV=dev
flutter run --dart-define=CLIENT=mancaksa --dart-define=ENV=prod
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter analyze
```

## Architecture

### Multi-Client System

White-labeled via `CLIENT` (`default`, `mancaksa`, `assa`) and `ENV` (`dev`, `prod`) dart-defines. `AppConfigLoader` loads `assets/clients/<CLIENT>/config.<ENV>.json` with fallback chain. JSON provides `appName`, `baseUrl`, `colors`, `brandSpec`, and feature flags (`appConfigProvider.features['chat'] ?? false`).

### Layer Structure

Each feature under `lib/features/<feature>/` follows: `data/` (datasource, models, mappers, repository_impl), `domain/` (entities, repositories, usecase), `presentation/` (providers, screens, widgets). See Naming Conventions table below for file/class patterns.

### Shared Infrastructure (`lib/shared/`)

- `core/infrastructure/network/` -- `ApiClient`, `dio_provider.dart`, `ApiGuard`
- `core/infrastructure/auth/` -- `AuthStateProvider`, `AuthLocalDataSource`, `AuthInterceptor`
- `core/infrastructure/routes/app_router.dart` -- GoRouter with auth redirect guard, 4 bottom-nav branches
- `core/types/` -- `Result<T>` sealed class (`Ok`/`Err`), `Failure` hierarchy, `guard()` async wrapper

### Code Generation

Files ending in `.g.dart` and `.freezed.dart` are generated, never edit manually. Run `build_runner` after changing `@riverpod`, `@freezed`, or `@JsonSerializable` annotated classes.

## Coding Conventions

### Widget Structure (CRITICAL)

**NEVER use `_buildXxx()` underscore-prefixed methods or `class _Foo extends StatelessWidget` private widget classes.** These patterns are banned.

Extraction strategy:
1. **Separate file in `widgets/`** -- reused or complex widgets get their own file and class
2. **camelCase method on the parent class** -- for sub-widgets only used within one widget, return a Widget directly (no class, no underscore). See `majalahPopUp()` in `digital_magazine_card.dart` as reference.
3. **Inline in `build()`** -- only truly trivial (a `Text`, a `SizedBox`)

```dart
// CORRECT -- build() first, sub-widget methods below
class SomeScreen extends ConsumerWidget {
  const SomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(children: [
        const ExtractedWidget(),       // from widgets/ folder
        sectionHeader(context, 'Title'), // camelCase method below
      ]),
    );
  }

  sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(title, style: TextStyle(...)),
    );
  }
}

// WRONG -- never do this
class SomeScreen extends StatelessWidget {
  Widget _buildHeader() { ... }               // BANNED
}
class _MonthHeader extends StatelessWidget { } // BANNED
```

### Widget Base Classes

- `StatelessWidget` -- no state or providers
- `ConsumerWidget` -- only needs `ref.watch()` providers
- `HookConsumerWidget` -- needs flutter_hooks (`useEffect`, `useTabController`, etc.)

### State Management (Riverpod)

- `ref.watch()` in `build()`, `ref.read()` in callbacks, `ref.listen()` for side effects
- `AsyncValue` handling: `.when(data:, loading:, error:)`
- Provider chain (`{feature}_providers.dart`): DataSource -> Repository -> UseCase as `@riverpod` functions
- Controllers: `@riverpod class` extending `_$` base with `build()`, `loadMore()`, `refresh()`
- Result folding: `result.fold((failure) => throw failure, (entity) => entity)`

### Styling

**Text**: Always inline `TextStyle(fontFamily: 'OpenSans', fontSize: X.sp, fontWeight: FontWeight.wXXX, color: context.brand.xxx)`. Never `Theme.of(context).textTheme`.

**Sizing**: flutter_screenutil (design 375x812). `.w` widths, `.h` heights, `.sp` fonts, `.r` radii. No raw `MediaQuery`.

**Spacing**: `SizedBox(height: X.h)` / `SizedBox(width: X.w)` between widgets. `EdgeInsets.symmetric(horizontal: X.w, vertical: X.h)` for padding. No Gap package.

**Colors**: `context.brand.*` (`primary`, `textMain`, `textSecondary`, etc.). Fallback: `AppColors.*`. Inline `Color.fromRGBO()` only for one-off opacity.

### Imports

Always package imports (`import 'package:icarus/...'`), never relative.

### Naming Conventions

| Type | File | Class |
|------|------|-------|
| Screen | `{name}_screen.dart` | `{Name}Screen` |
| Widget | `{name}_widget.dart` | `{Name}Widget` |
| Card | `{entity}_card.dart` | `{Entity}Card` |
| Providers | `{feature}_providers.dart` | (top-level `@riverpod` functions) |
| Controller | `{feature}_controller.dart` | `{Feature}Controller` |
| Repository | `{feature}_repository.dart` / `_impl.dart` | `{Feature}Repository` / `Impl` |
| Data source | `{feature}_remote_data_source.dart` | `{Feature}RemoteDataSource` |
| Model (DTO) | `{entity}_model.dart` | `{Entity}Model` (`@freezed`) |
| Entity | `{entity}_entity.dart` | `{Entity}Entity` (plain Dart class) |
| Mapper | `{entity}_mapper.dart` | `extension {Entity}Mapper on {Entity}Model` |
| Use case | `{action}_{entity}_usecase.dart` | `{Action}{Entity}Usecase` |

### Data Layer Patterns

- **Models**: `@freezed` + `@JsonSerializable(fieldRename: FieldRename.snake)` with `fromJson`
- **Entities**: Plain Dart classes, final fields, named constructor params (not Freezed)
- **Mappers**: Extension on Model with `toEntity()` method
- **Repositories**: `guard()` wrapper, return `Result<T>`
- **Data sources**: Dio via constructor, parse JSON, return Models
- **Use cases**: Single public method, repository via constructor

### General Style

- `const` constructors on all widgets when possible
- Trailing commas everywhere
- camelCase variables, `_` prefix for private fields/classes
- Package imports only, never relative
