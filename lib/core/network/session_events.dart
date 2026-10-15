import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_events.g.dart';

/// Broadcasts session-level events from the network layer.
///
/// Lets `core` tell the auth feature that the session ended (refresh token
/// rejected) without `core` depending on any feature code.
class SessionEvents {
  final _expired = StreamController<void>.broadcast();

  Stream<void> get onExpired => _expired.stream;

  void notifyExpired() => _expired.add(null);

  Future<void> dispose() => _expired.close();
}

@Riverpod(keepAlive: true)
SessionEvents sessionEvents(Ref ref) {
  final events = SessionEvents();
  ref.onDispose(events.dispose);
  return events;
}
