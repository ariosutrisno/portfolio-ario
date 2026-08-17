import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Global palette translated from the website CSS custom properties.
/// Widgets must consume these tokens instead of declaring local colors.
abstract final class C {
  static const background = Color(0xFF070A12);
  static const backgroundSoft = Color(0xFF0B0F1A);
  static const panel = Color(0xFF101522);
  static const panel2 = Color(0xFF0D1220);
  static const text = Color(0xFFF7F9FC);
  static const muted = Color(0xFF9AA4B5);
  static const line = Color(0x1CFFFFFF);
  static const lineStrong = Color(0x33FFFFFF);
  static const accent = Color(0xFF8AF7D4);
  static const accent2 = Color(0xFF7AA2FF);
  static const accent3 = Color(0xFFE7FF70);

  static const navText = Color(0xFFC8D0DC);
  static const heroMuted = Color(0xFF8794A9);
  static const leadText = Color(0xFFAEB8C8);
  static const subtleText = Color(0xFF718097);
  static const tagText = Color(0xFFCBD3DF);
  static const darkText = Color(0xFF0A0D14);
  static const darkGreen = Color(0xFF305B4F);
  static const darkAccentText = Color(0xFF293315);
  static const lightSurface = Color(0xFFF0F2F5);
  static const lightText = Color(0xFF5F6876);
  static const lightLine = Color(0xFFCBD0D7);

  static const backgroundGlow = Color(0x217AA2FF);
  static const blackShadow = Color(0x57000000);
  static const cardShadow = Color(0x24000000);
  static const hoverShadow = Color(0x338AF7D4);
  static const artStart = Color(0xFF0B111C);
  static const artEnd = Color(0xFF0A0D15);
  static const leadershipStart = Color(0x177AA2FF);
  static const leadershipEnd = Color(0x0F8AF7D4);

  // Compatibility aliases keep feature code readable while all values remain
  // controlled by this single palette.
  static const ink = background;
  static const white = text;
  static const lime = accent;
  static const blue = accent2;
  static const orange = accent3;
}

abstract final class AppGradients {
  static const background = RadialGradient(
    center: Alignment(.75, -.8),
    radius: 1.05,
    colors: [C.backgroundGlow, C.background],
    stops: [0, .68],
  );

  static const card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [C.panel, C.panel2],
  );

  static const projectArt = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [C.artStart, C.artEnd],
  );

  static const leadership = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [C.leadershipStart, C.leadershipEnd],
  );
}

abstract final class AppShadows {
  static const elevated = [
    BoxShadow(color: C.blackShadow, blurRadius: 80, offset: Offset(0, 30)),
  ];
  static const card = [
    BoxShadow(color: C.cardShadow, blurRadius: 40, offset: Offset(0, 18)),
  ];
  static const hover = [BoxShadow(color: C.hoverShadow, blurRadius: 24)];
}

/// DM Sans is the global body family; Manrope is the global display family.
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
      );

  static TextStyle heading([TextStyle? source]) => (source ?? const TextStyle())
      .copyWith(fontFamily: display, fontFamilyFallback: fallbacks);
}

/// Named type sizes prevent one-off font values from drifting between widgets.
abstract final class AppTypeScale {
  static const tiny = 8.0;
  static const micro = 9.0;
  static const label = 10.0;
  static const caption = 11.0;
  static const small = 12.0;
  static const bodySmall = 13.0;
  static const body = 14.0;
  static const bodyLarge = 16.0;
  static const lead = 18.0;
  static const title = 20.0;
  static const titleLarge = 24.0;
  static const metric = 26.0;

  static double fluid(
    double width, {
    required double minimum,
    required double maximum,
    double from = AppLayout.minSupportedWidth,
    double to = AppBreakpoints.large,
  }) {
    final progress = ((width - from) / (to - from)).clamp(0.0, 1.0);
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
}

/// Breakpoints mirror the reference CSS and add explicit desktop/wide classes.
abstract final class AppBreakpoints {
  static const double compact = 680;
  static const double medium = 1000;
  static const double expanded = 1240;
  static const double large = 1440;

  static const double navigation = medium;
  static const double splitContent = medium;
  static const double hero = medium;
}

abstract final class AppLayout {
  static const double minSupportedWidth = 280;
  static const double maxContentWidth = 1240;
  static const double mobileGutter = 15;
  static const double desktopGutter = 24;
  static const double mobileHeaderHeight = 68;
  static const double desktopHeaderHeight = 78;

  static double gutter(double width) =>
      width <= AppBreakpoints.compact ? mobileGutter : desktopGutter;

  static double headerHeight(double width) => width <= AppBreakpoints.compact
      ? mobileHeaderHeight
      : desktopHeaderHeight;

  static double sectionSpace(double width) {
    if (width <= AppBreakpoints.compact) return 82;
    if (width <= AppBreakpoints.medium) return 96;
    return 120;
  }

  static int gridColumns(
    double width, {
    int compact = 1,
    int medium = 2,
    int expanded = 3,
  }) {
    if (width >= AppBreakpoints.expanded) return expanded;
    if (width >= AppBreakpoints.compact) return medium;
    return compact;
  }
}

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

abstract final class AppRadius {
  static const double small = 10;
  static const double medium = 12;
  static const double large = 18;
  static const double card = 24;
  static const double hero = 32;
  static const double pill = 999;
}

abstract final class AppMotion {
  static const fast = Duration(milliseconds: 200);
  static const hover = Duration(milliseconds: 250);
  static const reveal = Duration(milliseconds: 550);
  static const navigation = Duration(milliseconds: 700);
  static const curve = Curves.easeInOutCubic;
}

enum ScreenClass { compact, medium, expanded, large }

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;

  ScreenClass get screenClass {
    final width = screenWidth;
    if (width <= AppBreakpoints.compact) return ScreenClass.compact;
    if (width <= AppBreakpoints.medium) return ScreenClass.medium;
    if (width < AppBreakpoints.large) return ScreenClass.expanded;
    return ScreenClass.large;
  }

  bool get isCompact => screenClass == ScreenClass.compact;
  bool get isMedium => screenClass == ScreenClass.medium;
  bool get isExpanded =>
      screenClass == ScreenClass.expanded || screenClass == ScreenClass.large;

  double get pageGutter => AppLayout.gutter(screenWidth);
  double get sectionSpace => AppLayout.sectionSpace(screenWidth);
  double get navigationHeight => AppLayout.headerHeight(screenWidth);

  T responsive<T>({required T compact, T? medium, T? expanded, T? large}) {
    return switch (screenClass) {
      ScreenClass.compact => compact,
      ScreenClass.medium => medium ?? compact,
      ScreenClass.expanded => expanded ?? medium ?? compact,
      ScreenClass.large => large ?? expanded ?? medium ?? compact,
    };
  }
}

abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.from(
      colorScheme: const ColorScheme.dark(
        primary: C.accent,
        onPrimary: C.darkText,
        secondary: C.accent2,
        tertiary: C.accent3,
        surface: C.panel,
        onSurface: C.text,
        outline: C.line,
        outlineVariant: C.lineStrong,
      ),
      useMaterial3: true,
    );

    return base.copyWith(
      scaffoldBackgroundColor: C.background,
      canvasColor: C.background,
      textTheme: _textTheme(base.textTheme),
      primaryTextTheme: _textTheme(base.primaryTextTheme),
      cardTheme: const CardThemeData(
        color: C.panel,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: C.line),
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.card)),
        ),
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: C.panel),
      dialogTheme: const DialogThemeData(
        backgroundColor: C.panel2,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: C.line),
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.large)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: C.text,
          foregroundColor: C.darkText,
          minimumSize: const Size(44, 50),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          shape: const StadiumBorder(),
          textStyle: AppFonts.bodyStyle(
            const TextStyle(
              fontSize: AppTypeScale.body,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: C.navText,
          minimumSize: const Size(44, 44),
          textStyle: AppFonts.bodyStyle(
            const TextStyle(
              fontSize: AppTypeScale.body,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(minimumSize: const Size(44, 44)),
      ),
      dividerTheme: const DividerThemeData(color: C.line, thickness: 1),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: C.panel2,
        contentTextStyle: AppFonts.bodyStyle(
          const TextStyle(color: C.text, fontSize: AppTypeScale.body),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
      ),
    );
  }

  static TextTheme _textTheme(TextTheme source) {
    final body = source.apply(
      fontFamily: AppFonts.body,
      bodyColor: C.text,
      displayColor: C.text,
    );

    return body.copyWith(
      displayLarge: AppFonts.heading(body.displayLarge),
      displayMedium: AppFonts.heading(body.displayMedium),
      displaySmall: AppFonts.heading(body.displaySmall),
      headlineLarge: AppFonts.heading(body.headlineLarge),
      headlineMedium: AppFonts.heading(body.headlineMedium),
      headlineSmall: AppFonts.heading(body.headlineSmall),
      titleLarge: AppFonts.heading(body.titleLarge),
      titleMedium: AppFonts.heading(body.titleMedium),
      titleSmall: AppFonts.heading(body.titleSmall),
      bodyLarge: body.bodyLarge?.copyWith(
        fontSize: AppTypeScale.bodyLarge,
        height: 1.6,
      ),
      bodyMedium: body.bodyMedium?.copyWith(
        fontSize: AppTypeScale.body,
        height: 1.6,
      ),
      bodySmall: body.bodySmall?.copyWith(
        fontSize: AppTypeScale.small,
        color: C.muted,
        height: 1.5,
      ),
      labelLarge: body.labelLarge?.copyWith(
        fontSize: AppTypeScale.body,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

/// Enables natural drag and scroll input on touchscreens, mouse, and trackpads.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };
}
