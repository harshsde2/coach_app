# CoachApp — Architecture

White-label member app for fibodo coaching businesses (first tenant: FORM).
Platforms: iOS + Android. Backend: existing fibodo REST API.

---

## 1. Principles

1. **Feature-first, layered inside each feature.** A feature can be read, tested and removed on its own.
2. **Dependencies point inward:** `presentation → domain ← data`. Domain code has no Dio, JSON or Flutter imports.
3. **Nothing brand-specific is hardcoded.** Name, colours and copy come from `TenantConfig`, the theme and l10n.
4. **Errors are values.** Repositories return `Result<T>`; the UI never sees a `DioException`.
5. **Write once, use anywhere.** Design tokens and shared widgets live in `core/` and features compose them.
6. **Every string goes through l10n, and every colour or size through a token.**

---

## 2. Tech stack

| Concern | Choice | Why |
|---|---|---|
| State management + DI | `flutter_riverpod` 3 + `riverpod_generator` | Compile-safe DI, async state built in, provider overrides for tests |
| Navigation | `go_router` (`StatefulShellRoute` for tabs) | Declarative, deep links, auth redirect guard, per-tab back stacks |
| HTTP | `dio` | Interceptors (auth, refresh, logging), cancellation |
| Models | `freezed` + `json_serializable` | Immutable models, `copyWith`, JSON mapping |
| Secure storage | `flutter_secure_storage` | Tokens and cached user in Keychain / Keystore |
| Localisation | `flutter_localizations` + `gen-l10n` (ARB) | Official and type-safe |
| Fonts | Bundled Manrope + DM Sans | No runtime download; works offline |
| Lints | `very_good_analysis` | Strict, industry-standard rules |
| Testing | `flutter_test`, `mocktail` | |

Chat and payments are still to be decided. Each will sit behind a repository interface so the provider can change without touching the UI.

---

## 3. Layers

```
presentation   Screens, widgets, Riverpod controllers (UI state)
     │ calls
     ▼
domain         Entities + repository interfaces (pure Dart)
     ▲ implements
     │
data           DTOs, remote/local data sources, repository implementations
```

- A **screen** reads a controller with `ref.watch` and sends user intent with `ref.read(provider.notifier).method()`.
- A **controller** calls a **repository** (the domain interface) and turns the `Result` into UI state.
- A **repository implementation** calls **data sources**, maps **DTO → entity**, and maps exceptions to `Failure` through `safeApiCall`.
- Use-case classes are added only when logic spans several repositories (for example checkout). There are no empty pass-through use cases.

---

## 4. Directory structure

```
coach_app/
├── assets/fonts/                  Manrope, DM Sans (+ OFL licence)
├── config/
│   ├── env/                       dev.json · staging.json · prod.json
│   └── tenants/                   form.json  (name, tagline, brand colours)
├── docs/                          requirements.md · architecture.md
├── lib/
│   ├── main.dart                  Error hooks, ProviderScope, runApp
│   ├── app.dart                   MaterialApp.router: theme, router, l10n
│   ├── core/
│   │   ├── config/                AppConfig (env), TenantConfig (brand)
│   │   ├── constants/             durations, storage keys, platform name
│   │   ├── error/                 Failure (sealed) + localised messages
│   │   ├── logging/               AppLogger facade
│   │   ├── network/
│   │   │   ├── api_client.dart          Dio provider
│   │   │   ├── api_endpoints.dart
│   │   │   ├── api_error_mapper.dart    DioException → Failure
│   │   │   ├── safe_api_call.dart       try/catch → Result, in one place
│   │   │   ├── session_events.dart      "session expired" broadcast
│   │   │   ├── token_refresh_client.dart
│   │   │   └── interceptors/            auth (+ refresh), logging
│   │   ├── router/                app_router (guard), app_routes, tab shell
│   │   ├── storage/               secure storage, TokenStorage
│   │   ├── theme/                 palette → AppColors / AppTextStyles → ThemeData
│   │   ├── utils/                 Result, validators, context extensions
│   │   └── widgets/               design system (import widgets.dart)
│   │       ├── buttons/           AppButton.primary / .outline / .text
│   │       ├── inputs/            AppTextField, AppPasswordField, AppCheckboxField
│   │       ├── display/           BrandMark, AppAvatar, Eyebrow, IconChip, AppBadge
│   │       ├── feedback/          AppLoader, AppEmptyState, toasts, confirm dialog
│   │       ├── layout/            AppScaffold, AppTabPage, SectionHeading, AppCard
│   │       └── navigation/        AppBottomNavBar
│   ├── features/
│   │   ├── auth/
│   │   │   ├── domain/            User entity, AuthRepository interface
│   │   │   ├── data/              DTOs, API + mock + local data sources, repo impl
│   │   │   └── presentation/      controllers, screens, widgets
│   │   ├── home/  wallet/  messages/  contacts/  profile/
│   │   │   └── presentation/screens/
│   │   └── …                      (bookings, checkout, shop, training, content …)
│   └── l10n/                      app_en.arb (+ generated)
└── test/                          mirrors lib/ + helpers/ + app/ (full-flow test)
```

---

## 5. Key mechanisms

### 5.1 Configuration (environment × tenant)

```bash
flutter run \
  --dart-define-from-file=config/env/dev.json \
  --dart-define-from-file=config/tenants/form.json
```

- `AppConfig` holds the environment, API base URL and `USE_MOCK_API`.
- `TenantConfig` holds the tenant id, name, tagline and brand colours. Each request carries the tenant id in the `X-Tenant-Id` header; the header name is still to be confirmed with the backend.
- **Not built yet:** native flavors so dev, staging and prod can be installed side by side, and a CI rebrand step for per-tenant bundle id, app name, icon and splash (`flutter_launcher_icons`, `flutter_native_splash`).

### 5.2 Theming

```
TenantConfig ─┐
AppPalette ───┴→ AppColors.dark / .light ─→ AppTextStyles.from(colors) ─→ ThemeData
                       (ThemeExtension)          (ThemeExtension)
```

- Widgets read `context.colors.brand`, `context.textStyles.title`, `AppSpacing.md`, `AppRadius.card`.
- Material widgets (TextField, Checkbox, SnackBar, Dialog) are themed centrally, so they match the design even when used directly.
- Light and dark themes are both supported. Dark is the default.

### 5.3 Networking and errors

```
Dio ─ AuthInterceptor  adds the Bearer token; on 401 refreshes once,
                       serialises concurrent 401s and retries; otherwise emits
                       SessionEvents.expired → AuthController logs out
    ─ LoggingInterceptor (non-prod; method, URL and status only, never bodies)

data source throws ─→ safeApiCall ─→ Ok(value) | Err(Failure)
```

`Failure` is a sealed class (`NetworkFailure`, `UnauthorizedFailure`, `ValidationFailure`,
`ServerFailure`, `UnknownFailure`), so presentation code handles it with an exhaustive `switch`.

### 5.4 Auth and routing

- `AuthController` (keepAlive) holds an `AsyncValue<User?>`: *loading* means the session is being restored, *data(user)* means signed in, and *data(null)* means signed out.
- On restore, the tokens are read and then the cached user is used. This makes startup instant and works offline. If no user is cached, the app falls back to `GET /me`.
- `GoRouter.redirect` runs `authGuard`. Signed-out users can only reach `/login/*`. Signed-in users never see the auth screens. While the session is restoring, the app shows `/splash`.
- Screens never navigate after login or logout themselves. Changing the auth state is enough, because the router reacts to it.
- Tabs use `StatefulShellRoute.indexedStack`, so each tab keeps its own back stack.

### 5.5 Mock API

With `USE_MOCK_API=true` (dev), `AuthMockDataSource` replaces the HTTP data source. It uses the same interface and simulates latency and errors:
`wrong@example.com` → login error, `taken@example.com` → sign-up error, reset code `123456`.

### 5.6 UI state

- **Form submission:** an `AsyncNotifier<void>` (idle, loading or error). The screen listens with `ref.listen` and shows `state.showErrorToast(context)`.
- **Multi-step flows:** a freezed state with a `step` enum (`ForgotPasswordController`).
- After every `await`, controllers check `ref.mounted` before updating state.

---

## 6. Conventions

- Files use `snake_case.dart`. Each file has one public widget. Widgets are split once they pass about 100 lines.
- Use `const` constructors wherever possible. No business logic in widgets and no `BuildContext` below the presentation layer.
- Generated files (`*.g.dart`, `*.freezed.dart`, l10n) are committed, so the project runs without build_runner.
- Commits follow Conventional Commits (`feat(auth): …`).
- Before each push: `dart format .`, `flutter analyze` and `flutter test`.

## 7. Testing

| Level | Covered |
|---|---|
| Unit | Validators, route guard, repository (DTO mapping, error mapping, session restore, logout) |
| Controller | `LoginController` success and failure, using a `ProviderContainer` with overrides |
| Widget | Login form validation and submission |
| App flow | Full app: login → tabs → profile → logout, with the mock API and in-memory secure storage |
