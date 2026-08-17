import 'package:flutter/animation.dart';

/// Shared spacing scale used by every feature layout.
abstract final class AppSpace {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double base = 20;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double huge = 72;
}

/// Radius scale derived from the CSS controls, panels, and cards.
abstract final class AppRadius {
  static const double small = 10;
  static const double medium = 12;
  static const double large = 18;
  static const double card = 24;
  static const double hero = 32;
  static const double pill = 999;
}

/// Central motion settings corresponding to CSS transition and reveal timing.
abstract final class AppMotion {
  static const fast = Duration(milliseconds: 200);
  static const hover = Duration(milliseconds: 250);
  static const reveal = Duration(milliseconds: 550);
  static const navigation = Duration(milliseconds: 700);
  static const revealOffsetFraction = .035;
  static const standardCurve = Curves.easeOutCubic;
  static const revealCurve = Curves.easeOutCubic;
  static const curve = Curves.easeInOutCubic;
}
