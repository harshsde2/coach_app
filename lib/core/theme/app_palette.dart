import 'dart:ui';

/// Do not use these in widgets: use the semantic `context.colors` instead,
/// which resolves the right value for the current brightness and tenant.
abstract final class AppPalette {
  static const ink = Color(0xFF090B0B);
  static const panel = Color(0xFF121515);
  static const panelRaised = Color(0xFF191D1C);
  static const textOnDark = Color(0xFFF5F7F5);
  static const mutedOnDark = Color(0xFF8D9692);
  static const subtleOnDark = Color(0xFF727B77);
  static const lineOnDark = Color(0x17FFFFFF);
  static const avatarOnDark = Color(0xFF27302D);
  static const navOnDark = Color(0xF00C0E0E);

  static const paper = Color(0xFFF3F5F2);
  static const white = Color(0xFFFFFFFF);
  static const paperRaised = Color(0xFFF8FAF7);
  static const textOnLight = Color(0xFF111512);
  static const mutedOnLight = Color(0xFF68716C);
  static const subtleOnLight = Color(0xFF8A938E);
  static const lineOnLight = Color(0x1A121C16);
  static const avatarOnLight = Color(0xFFE9EEE9);
  static const navOnLight = Color(0xF0FFFFFF);

  static const error = Color(0xFFE27676);
  static const success = Color(0xFF5FCB8A);
  static const warning = Color(0xFFFFD967);
}
