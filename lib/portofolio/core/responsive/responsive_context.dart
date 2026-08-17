import 'package:flutter/material.dart';

import 'app_breakpoints.dart';
import 'app_layout.dart';

/// Convenience access to the global responsive system from any widget.
extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;

  ScreenClass get screenClass {
    final width = screenWidth;
    if (width < AppBreakpoints.tiny) return ScreenClass.tiny;
    if (width <= AppBreakpoints.compact) return ScreenClass.compact;
    if (width <= AppBreakpoints.medium) return ScreenClass.medium;
    if (width < AppBreakpoints.large) return ScreenClass.expanded;
    if (width < AppBreakpoints.wide) return ScreenClass.large;
    return ScreenClass.ultraWide;
  }

  bool get isTiny => screenClass == ScreenClass.tiny;
  bool get isCompact => switch (screenClass) {
    ScreenClass.tiny || ScreenClass.compact => true,
    _ => false,
  };
  bool get isMedium => screenClass == ScreenClass.medium;
  bool get isExpanded => switch (screenClass) {
    ScreenClass.expanded || ScreenClass.large || ScreenClass.ultraWide => true,
    _ => false,
  };

  double get pageGutter => AppLayout.gutter(screenWidth);
  double get sectionSpace => AppLayout.sectionSpace(screenWidth);
  double get navigationHeight => AppLayout.headerHeight(screenWidth);

  /// Selects a value for the current viewport with predictable fallbacks.
  /// Existing callers only need `compact`; all larger values are optional.
  T responsive<T>({
    T? tiny,
    required T compact,
    T? medium,
    T? expanded,
    T? large,
    T? ultraWide,
  }) {
    return switch (screenClass) {
      ScreenClass.tiny => tiny ?? compact,
      ScreenClass.compact => compact,
      ScreenClass.medium => medium ?? compact,
      ScreenClass.expanded => expanded ?? medium ?? compact,
      ScreenClass.large => large ?? expanded ?? medium ?? compact,
      ScreenClass.ultraWide =>
        ultraWide ?? large ?? expanded ?? medium ?? compact,
    };
  }
}
