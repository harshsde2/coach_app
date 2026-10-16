import 'package:coach_app/core/config/app_config.dart';
import 'package:coach_app/core/config/tenant_config.dart';
import 'package:coach_app/core/constants/app_durations.dart';
import 'package:coach_app/core/network/interceptors/auth_interceptor.dart';
import 'package:coach_app/core/network/interceptors/logging_interceptor.dart';
import 'package:coach_app/core/network/session_events.dart';
import 'package:coach_app/core/network/token_refresh_client.dart';
import 'package:coach_app/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final config = ref.watch(appConfigProvider);
  final tenant = ref.watch(tenantConfigProvider);

  final options = BaseOptions(
    baseUrl: config.apiBaseUrl,
    connectTimeout: AppDurations.connectTimeout,
    receiveTimeout: AppDurations.receiveTimeout,
    contentType: Headers.jsonContentType,
    headers: {
      'Accept': 'application/json',
      // TODO(team): confirm how the API identifies the tenant.
      'X-Tenant-Id': tenant.id,
    },
  );

  final dio = Dio(options);
  dio.interceptors.addAll([
    AuthInterceptor(
      tokenStorage: ref.watch(tokenStorageProvider),
      refreshClient: TokenRefreshClient(Dio(options)),
      retryClient: dio,
      onSessionExpired: ref.watch(sessionEventsProvider).notifyExpired,
    ),
    if (!config.isProd) LoggingInterceptor(),
  ]);

  ref.onDispose(dio.close);
  return dio;
}
