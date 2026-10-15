# CoachApp — Architecture

White-label member app for fibodo coaching businesses (first tenant: FORM).
Platforms: iOS + Android. Backend: existing fibodo REST API.

---

## 1. Principles

1. **Feature-first, layered inside each feature** — a feature can be read, tested and deleted in isolation.
2. **Dependencies point inward** — `presentation → domain ← data`. Domain has no Flutter, Dio or JSON imports.
3. **Nothing brand-specific is hardcoded** — colours, logo, name and copy come from `TenantConfig` + theme.
4. **Errors are values, not surprises** — repositories return `Result<T>`; the UI never sees a `DioException`.
5. **Immutable state, generated boilerplate** — freezed models, Riverpod code generation.
6. **Every string through l10n, every size through tokens.**

---

## 2. Tech stack

| Concern | Choice | Why |
|---|---|---|
| State management + DI | `flutter_riverpod` + `riverpod_generator` | Compile-safe DI, async state built in, easy overrides in tests |
| Navigation | `go_router` (+ `StatefulShellRoute` for tabs) | Declarative, deep links, auth redirect guard, per-tab back stacks |
| HTTP | `dio` | Interceptors (auth, refresh, logging), cancellation, multipart |
| Models | `freezed` + `json_serializable` | Immutable, `copyWith`, unions, JSON mapping |
| Secure storage | `flutter_secure_storage` | Tokens in Keychain / Keystore |
| Preferences | `shared_preferences` | Non-sensitive flags |
| Localisation | `flutter_localizations` + `gen-l10n` (ARB) | Official, type-safe strings |
| Fonts | Bundled Manrope + DM Sans | No runtime download, works offline |
| Images / SVG | `cached_network_image`, `flutter_svg` | |
| Logging | `logger` (dev only output) | |
| Lints | `very_good_analysis` | Strict, industry standard |
| Testing | `flutter_test`, `mocktail` | |
| Real-time chat | TBD (WebSocket / provider) — behind `ChatRepository` interface | |
| Payments | TBD — behind `PaymentRepository` interface | |

---

## 3. Layers

```
presentation   Screens, widgets, Riverpod notifiers (UI state)
     │ calls
     ▼
domain         Entities, repository interfaces (abstract), use-case logic if non-trivial
     ▲ implements
     │
data           DTOs (JSON), remote/local data sources, repository implementations, mappers
```

- **Screen** → reads a **Notifier** via `ref.watch`, sends user intent via `ref.read(...notifier).method()`.
- **Notifier** → calls a **Repository** (interface from domain), maps `Result` to UI state.
- **Repository impl** → calls **DataSource** (Dio), maps **DTO → Entity**, maps exceptions → `Failure`.
- Use-case classes are added only where logic spans several repositories (e.g. checkout) — no empty pass-through use cases.

---

## 4. Directory structure

```
coach_app/
├── assets/
│   ├── fonts/                     Manrope, DM Sans
│   ├── icons/                     SVG icons
│   └── tenants/
│       └── form/                  logo, headshot, app icon source per tenant
├── config/
│   ├── env/                       dev.json, staging.json, prod.json   (--dart-define-from-file)
│   └── tenants/                   form.json  (name, colours, assets path, support phone…)
├── docs/                          requirements.md, architecture.md
├── l10n.yaml
├── lib/
│   ├── main.dart                  Bootstrap: load config, ProviderScope, runApp
│   ├── app.dart                   MaterialApp.router: theme, router, localisation
│   │
│   ├── core/                      App-wide, feature-agnostic
│   │   ├── config/                AppConfig (env), TenantConfig (brand)
│   │   ├── constants/             durations, regex, storage keys
│   │   ├── error/                 AppException, Failure (sealed), error → message mapping
│   │   ├── network/
│   │   │   ├── api_client.dart    Dio factory (base URL, timeouts, headers)
│   │   │   ├── api_endpoints.dart
│   │   │   └── interceptors/      auth_interceptor, refresh_token_interceptor, logging_interceptor
│   │   ├── storage/               SecureStorage, PreferencesStorage wrappers
│   │   ├── router/
│   │   │   ├── app_router.dart    GoRouter + auth redirect
│   │   │   └── app_routes.dart    route paths/names in one place
│   │   ├── theme/
│   │   │   ├── app_colors.dart    ThemeExtension built from TenantConfig
│   │   │   ├── app_typography.dart
│   │   │   ├── app_spacing.dart   spacing + radius tokens
│   │   │   └── app_theme.dart     ThemeData assembly
│   │   ├── utils/
│   │   │   ├── result.dart        sealed Result<T> = Success | Error
│   │   │   ├── validators.dart
│   │   │   └── extensions/        context (theme, l10n), string, datetime
│   │   └── widgets/               Design-system components (no feature logic)
│   │       ├── buttons/           AppPrimaryButton, AppOutlineButton, AppTextButton
│   │       ├── inputs/            AppTextField, AppPasswordField, AppOtpField
│   │       ├── feedback/          AppLoader, AppEmptyState, AppErrorView, AppToast
│   │       └── layout/            AppScaffold, SectionHeading (eyebrow + title), AppCard
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── datasources/   auth_remote_data_source.dart, auth_local_data_source.dart
│   │   │   │   ├── models/        login_request.dart, auth_response_dto.dart, user_dto.dart
│   │   │   │   └── repositories/  auth_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/      user.dart, auth_session.dart
│   │   │   │   └── repositories/  auth_repository.dart   (abstract)
│   │   │   └── presentation/
│   │   │       ├── providers/     auth_controller.dart (session state), login_controller.dart …
│   │   │       ├── screens/       login_screen.dart, signup_screen.dart, forgot_password_screen.dart
│   │   │       └── widgets/       auth_header.dart, …
│   │   ├── home/
│   │   ├── bookings/
│   │   ├── checkout/              shared 4-step flow (booking / voucher / membership)
│   │   ├── shop/
│   │   ├── training/
│   │   ├── content/
│   │   ├── messaging/
│   │   ├── contacts/
│   │   ├── profile/
│   │   ├── wallet/
│   │   └── business/              about, reviews, news
│   │
│   └── l10n/                      app_en.arb (+ generated)
│
└── test/                          mirrors lib/
    ├── core/
    ├── features/auth/{data,presentation}/
    └── helpers/                   fakes, pump helpers, provider overrides
```

---

## 5. Key mechanisms

### 5.1 Configuration (environment × tenant)

```bash
flutter run \
  --dart-define-from-file=config/env/dev.json \
  --dart-define-from-file=config/tenants/form.json
```

- `AppConfig` — base URL, log level, env name.
- `TenantConfig` — tenant id, display name, brand colours, asset folder, support contact.
- The tenant id is sent to the API (header) if the backend is multi-tenant.
- Native per-tenant values (bundle id, app name, icon, splash) are produced by a rebrand script
  in CI (`flutter_launcher_icons`, `flutter_native_splash`). Environments use native flavors
  (`dev`, `staging`, `prod`) so they can be installed side by side.

### 5.2 Theming

`TenantConfig` → `AppColors` (ThemeExtension) → `ThemeData`.
Widgets read `context.colors.brand`, `context.text.sectionTitle`, `AppSpacing.md` —
no `Color(0xFF…)` or magic numbers in features.

### 5.3 Networking & errors

```
Dio ─ AuthInterceptor (adds Bearer token, tenant header)
    ─ RefreshTokenInterceptor (on 401: refresh once, queue concurrent requests, retry; else logout)
    ─ LoggingInterceptor (dev only, redacts secrets)

DataSource throws AppException  →  RepositoryImpl catches  →  Result.error(Failure)
                                                           →  Result.success(Entity)
```

`Failure` is a sealed class (`NetworkFailure`, `UnauthorizedFailure`, `ValidationFailure(fieldErrors)`,
`ServerFailure`, `UnknownFailure`) so the UI uses an exhaustive `switch`.

### 5.4 Auth & routing

- `AuthController` (keepAlive) holds `AuthState`: `unknown → authenticated(user) | unauthenticated`.
- On launch: read token from secure storage → fetch current user → set state.
- `GoRouter.redirect` listens to `AuthController`: unauthenticated users are sent to `/login`;
  authenticated users can't open auth routes.
- Tabs use `StatefulShellRoute.indexedStack` so each tab keeps its own back stack.

### 5.5 UI state

Screen-level async data: `AsyncValue<T>` from `@riverpod` providers → `.when(data, loading, error)`.
Form screens: freezed state (`isSubmitting`, `fieldErrors`) in a Notifier; one-off events
(toast, navigate) via `ref.listen`.

---

## 6. Conventions

- Files `snake_case.dart`, one public widget/class per file, widgets split past ~100 lines.
- `const` constructors everywhere possible.
- No business logic in widgets; no `BuildContext` in notifiers/repositories.
- Commits: Conventional Commits (`feat(auth): add login screen`).
- Generated files (`*.g.dart`, `*.freezed.dart`) are committed so reviewers can run without build_runner.
- CI: `dart format --set-exit-if-changed`, `flutter analyze`, `flutter test`.

## 7. Testing strategy

| Layer | What |
|---|---|
| Repository | DTO mapping, exception → Failure mapping (mocked data source) |
| Notifier | State transitions (mocked repository via provider override) |
| Widget | Auth screens: validation messages, loading state, navigation on success |
| Core | Validators, Result, refresh-token interceptor |
