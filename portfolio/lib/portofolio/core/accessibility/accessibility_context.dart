import 'package:flutter/material.dart';

/// Accessibility helpers shared by animations and navigation.
extension AccessibilityContext on BuildContext {
  /// Mirrors CSS `prefers-reduced-motion: reduce` on supported platforms.
  bool get prefersReducedMotion =>
      MediaQuery.maybeOf(this)?.disableAnimations ?? false;

  /// Returns zero duration when the user has requested reduced motion.
  Duration accessibleDuration(Duration preferred) =>
      prefersReducedMotion ? Duration.zero : preferred;
}
