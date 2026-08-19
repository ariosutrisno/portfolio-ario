import 'app_breakpoints.dart';

/// Global dimensions and responsive layout calculations.
abstract final class AppLayout {
  static const double minSupportedWidth = 240;
  static const double maxContentWidth = 1240;
  static const double maxContentWidthWide = 1440;
  static const double tinyGutter = 12;
  static const double mobileGutter = 15;
  static const double desktopGutter = 24;
  static const double expandedGutter = 28;
  static const double wideGutter = 36;
  static const double mobileHeaderHeight = 68;
  static const double desktopHeaderHeight = 78;

  /// Keeps content away from the edges while preserving the CSS shell widths.
  static double gutter(double width) {
    if (width <= AppBreakpoints.tiny) return tinyGutter;
    if (width <= AppBreakpoints.compact) return mobileGutter;
    if (width <= AppBreakpoints.expanded) return desktopGutter;
    if (width <= AppBreakpoints.wide) return expandedGutter;
    return wideGutter;
  }

  static double headerHeight(double width) => width <= AppBreakpoints.compact
      ? mobileHeaderHeight
      : desktopHeaderHeight;

  /// Section rhythm scales up gradually from phones to desktop/web.
  static double sectionSpace(double width) {
    if (width <= AppBreakpoints.tiny) return 72;
    if (width <= AppBreakpoints.compact) return 82;
    if (width <= AppBreakpoints.medium) return 96;
    return 120;
  }

  /// Standard column calculation for reusable grids.
  static int gridColumns(
    double width, {
    int compact = 1,
    int medium = 2,
    int expanded = 3,
  }) {
    if (width > AppBreakpoints.expanded) return expanded;
    if (width > AppBreakpoints.compact) return medium;
    return compact;
  }
}
