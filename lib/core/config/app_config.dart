import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

enum AppEnvironment { dev, staging, prod }

/// Build-time environment settings.
///
/// Values come from `--dart-define-from-file=config/env/<env>.json`.
/// Defaults allow a plain `flutter run` to start in dev with the mock API.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.useMockApi,
  });

  factory AppConfig.fromEnvironment() {
    return AppConfig(
      environment: AppEnvironment.values.byName(
        const String.fromEnvironment('APP_ENV', defaultValue: 'dev'),
      ),
      apiBaseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api-dev.fibodo.com',
      ),
      useMockApi: const bool.fromEnvironment(
        'USE_MOCK_API',
        defaultValue: true,
      ),
    );
  }

  final AppEnvironment environment;
  final String apiBaseUrl;

  /// When true, data sources return local fake data instead of calling the
  /// API. Lets UI work continue independently of backend availability.
  final bool useMockApi;

  bool get isProd => environment == AppEnvironment.prod;
}

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) => AppConfig.fromEnvironment();
