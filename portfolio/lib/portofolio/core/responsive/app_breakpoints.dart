/// Named viewport boundaries for phone, tablet, laptop, and wide web layouts.
///
/// `compact` (680 px) and `medium` (1000 px) exactly match the source CSS.
/// Extra boundaries make very small phones and wide desktop behavior explicit.
abstract final class AppBreakpoints {
  static const double tiny = 320;
  static const double compact = 680;
  static const double medium = 1000;
  static const double expanded = 1240;
  static const double large = 1440;
  static const double wide = 1920;

  // Semantic aliases explain why a component switches at a given width.
  static const double navigation = medium;
  static const double splitContent = medium;
  static const double hero = medium;
  static const double footer = 820;
}

/// Device-independent layout classes. They describe available logical pixels,
/// not operating systems, so Android, iOS, desktop, and web behave consistently.
enum ScreenClass { tiny, compact, medium, expanded, large, ultraWide }
