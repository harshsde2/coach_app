import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const double screen = lg;

  static const screenPadding = EdgeInsets.symmetric(horizontal: screen);
}

abstract final class AppRadius {
  static const double xs = 6;
  static const double sm = 10;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 22;
  static const double full = 999;

  static const card = BorderRadius.all(Radius.circular(xl));
  static const input = BorderRadius.all(Radius.circular(sm));
  static const button = BorderRadius.all(Radius.circular(md));
  static const badge = BorderRadius.all(Radius.circular(xs));
}

abstract final class AppSizes {
  static const double buttonHeight = 52;
  static const double buttonHeightSmall = 40;
  static const double inputHeight = 52;
  static const double bottomNavHeight = 68;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double avatarSm = 38;
  static const double avatarLg = 82;
  static const double brandMark = 34;

  static const double formMaxWidth = 460;
}
