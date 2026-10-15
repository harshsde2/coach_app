/// Shared timing values so motion and network behaviour stay consistent.
abstract final class AppDurations {
  static const fast = Duration(milliseconds: 150);
  static const medium = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 400);

  static const connectTimeout = Duration(seconds: 20);
  static const receiveTimeout = Duration(seconds: 30);

  /// Simulated latency for mock data sources.
  static const mockLatency = Duration(milliseconds: 800);
}
