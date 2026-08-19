import 'package:flutter/material.dart';

import '../responsive/app_breakpoints.dart';
import '../responsive/app_layout.dart';
import 'app_colors.dart';

/// The two bundled font families plus platform-safe fallbacks.
///
/// DM Sans is the global body face and Manrope is the display/heading face.
/// Both font files are registered in pubspec.yaml.
abstract final class AppFonts {
  static const body = 'DM Sans';
  static const display = 'Manrope';
  static const fallbacks = <String>[
    'Segoe UI',
    'Roboto',
    'Helvetica Neue',
    'Arial',
    'sans-serif',
  ];

  static TextStyle bodyStyle([TextStyle? source]) =>
      (source ?? const TextStyle()).copyWith(
        fontFamily: body,
        fontFamilyFallback: fallbacks,
        letterSpacing: source?.letterSpacing ?? 0.15,
        height: source?.height ?? 1.6,
      );

  static TextStyle heading([TextStyle? source]) =>
      (source ?? const TextStyle()).copyWith(
        fontFamily: display,
        fontFamilyFallback: fallbacks,
        letterSpacing: source?.letterSpacing ?? -0.2,
        height: source?.height ?? 1.25,
      );
}

/// Complete named type scale.
///
/// The fluid methods implement smooth scaling between phone and desktop.
abstract final class AppTypeScale {
  static const tiny = 8.0;
  static const micro = 9.0;
  static const label = 10.0;
  static const caption = 11.0;
  static const small = 12.0;
  static const bodySmall = 13.0;
  static const body = 14.0;
  static const bodyLarge = 16.0;
  static const resumeItem = 17.0;
  static const lead = 18.0;
  static const title = 20.0;
  static const journeyTitle = 21.0;
  static const expertiseTitle = 23.0;
  static const titleLarge = 24.0;
  static const metric = 26.0;
  static const mobileFeature = 27.0;
  static const mobilePanel = 31.0;
  static const resumeTitle = 32.0;
  static const displaySmall = 38.0;
  static const caseTitle = 40.0;
  static const mobileHero = 44.0;

  /// Linear interpolation used to scale typography smoothly.
  static double fluid(
    double width, {
    required double minimum,
    required double maximum,
    double from = AppLayout.minSupportedWidth,
    double to = AppBreakpoints.large,
  }) {
    final safeWidth = width.isFinite ? width : AppLayout.maxContentWidth;
    final progress = ((safeWidth - from) / (to - from)).clamp(0.0, 1.0);
    return minimum + (maximum - minimum) * progress;
  }

  static double hero(double width) => width <= AppBreakpoints.compact
      ? fluid(width, minimum: 38, maximum: 44, to: AppBreakpoints.compact)
      : fluid(width, minimum: 48, maximum: 86, from: AppBreakpoints.compact);

  static double sectionTitle(double width) =>
      fluid(width, minimum: 38, maximum: 62);

  static double featureTitle(double width) =>
      fluid(width, minimum: 27, maximum: 38);

  static double panelTitle(double width) =>
      fluid(width, minimum: 31, maximum: 38);

  static double caseHero(double width) =>
      fluid(width, minimum: 40, maximum: 80);

  static double caseSection(double width) =>
      fluid(width, minimum: 28, maximum: 40);
}

/// Reusable text recipes that are shared by several feature widgets.
abstract final class AppTextStyles {
  static const artMuted = TextStyle(
    color: C.muted,
    fontSize: AppTypeScale.micro,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );
}

