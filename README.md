# CoachApp

A white-label member app for coaching businesses on the **fibodo** platform.
One codebase produces a separately branded app for each business. The first tenant is **FORM**.

Platforms: iOS and Android · Flutter 3.47 · Dart 3.13

## Getting started

```bash
flutter pub get
flutter run \
  --dart-define-from-file=config/env/dev.json \
  --dart-define-from-file=config/tenants/form.json
```

In VS Code, pick a configuration such as **FORM · dev (mock API)** from *Run and Debug*.
A plain `flutter run` also works: it uses the dev and FORM defaults.

### Mock API (dev)

The dev environment uses an in-memory backend, so the app runs without an API:

| Action | Behaviour |
|---|---|
| Log in | Any email or password works. `wrong@example.com` returns an error |
| Sign up | Any details work. `taken@example.com` returns "already exists" |
| Reset password | Use the code `123456` |

## Environments and tenants

| File | Purpose |
|---|---|
| `config/env/{dev,staging,prod}.json` | API base URL, mock switch |
| `config/tenants/<tenant>.json` | Business name, tagline, brand colours |

To add a business, add `config/tenants/<id>.json` and build with that file.

## Commands

```bash
dart run build_runner watch -d   # regenerate freezed / json / riverpod code
flutter gen-l10n                  # regenerate strings after editing lib/l10n/app_en.arb
flutter analyze                   # very_good_analysis lints
flutter test                      # unit, widget and app-flow tests
dart format .
```

## Project structure

```
lib/
├── core/        config · network · router · storage · theme · utils · widgets
└── features/    auth · home · wallet · messages · contacts · profile
                 └── data / domain / presentation
```

See [docs/architecture.md](docs/architecture.md) for the design decisions and
[docs/requirements.md](docs/requirements.md) for the screen inventory.

## Using the design system

```dart
import 'package:coach_app/core/theme/theme.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/widgets.dart';

Text('Hello', style: context.textStyles.title);           // typography
Container(color: context.colors.surface);                  // colours
const SizedBox(height: AppSpacing.md);                     // spacing
AppButton.primary(label: context.l10n.loginButton, onPressed: submit);
```

Don't hardcode colours, font sizes or user-facing strings in feature code.
