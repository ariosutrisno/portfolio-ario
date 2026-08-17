import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

/// Application-wide Material theme assembled from the global design tokens.
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
      visualDensity: VisualDensity.adaptivePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      focusColor: C.accentGlow23,
      hoverColor: C.white06,
      splashColor: C.accentGlow15,
      highlightColor: C.white025,
      textTheme: _textTheme(base.textTheme),
      primaryTextTheme: _textTheme(base.primaryTextTheme),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: C.accent,
        selectionColor: C.accentGlow23,
        selectionHandleColor: C.accent,
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(AppRadius.pill),
        minThumbLength: 44,
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.dragged)) return C.accent;
          if (states.contains(WidgetState.hovered)) return C.accentGlow55;
          return C.lineStrong;
        }),
        thickness: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.dragged) ? 8 : 5,
        ),
      ),
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
      listTileTheme: const ListTileThemeData(
        iconColor: C.text,
        textColor: C.text,
        minTileHeight: 48,
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: C.panel2,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: C.line),
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.large)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: C.accent,
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
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: C.accent,
        linearTrackColor: C.line,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: C.panel2,
          border: Border.all(color: C.lineStrong),
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        textStyle: AppFonts.bodyStyle(
          const TextStyle(color: C.text, fontSize: AppTypeScale.small),
        ),
      ),
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

  static ThemeData get resume {
    final base = ThemeData.from(
      colorScheme: const ColorScheme.light(
        primary: C.resumeInk,
        onPrimary: C.pureWhite,
        secondary: C.darkGreen,
        surface: C.pureWhite,
        onSurface: C.resumeTitle,
        outline: C.resumeBorder,
      ),
      useMaterial3: true,
    );

    final body = base.textTheme.apply(
      fontFamily: AppFonts.body,
      bodyColor: C.resumeTitle,
      displayColor: C.resumeTitle,
    );

    return base.copyWith(
      scaffoldBackgroundColor: C.resumeSurface,
      textTheme: body.copyWith(
        displayLarge: AppFonts.heading(body.displayLarge),
        headlineLarge: AppFonts.heading(body.headlineLarge),
        headlineMedium: AppFonts.heading(body.headlineMedium),
        titleLarge: AppFonts.heading(body.titleLarge),
        titleMedium: AppFonts.heading(body.titleMedium),
        bodyLarge: body.bodyLarge?.copyWith(height: 1.6),
        bodyMedium: body.bodyMedium?.copyWith(height: 1.6),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: C.resumeInk,
          foregroundColor: C.pureWhite,
          minimumSize: const Size(44, 48),
          shape: const StadiumBorder(),
          textStyle: AppFonts.bodyStyle(
            const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: C.resumeInk,
          minimumSize: const Size(44, 44),
          textStyle: AppFonts.bodyStyle(
            const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(color: C.resumeRule),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: C.darkGreen,
        selectionColor: C.black14,
        selectionHandleColor: C.darkGreen,
      ),
    );
  }

  /// Applies DM Sans to body styles and Manrope to display/title styles.
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
