import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Thin logging facade so the backing implementation (console, Sentry,
/// Crashlytics) can change without touching call sites.
abstract final class AppLogger {
  static void debug(String message, {String tag = 'App'}) {
    if (kDebugMode) developer.log(message, name: tag);
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String tag = 'App',
  }) {
    developer.log(
      message,
      name: tag,
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}
