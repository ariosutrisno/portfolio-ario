import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Flat surface recipes kept global for visual consistency.
abstract final class AppGradients {
  static const background = LinearGradient(
    colors: [C.background, C.background],
  );

  static const card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [C.panel, C.panel],
  );

  static const projectArt = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [C.artStart, C.artStart],
  );

  static const leadership = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [C.panel2, C.panel2],
  );
}

/// Elevation is intentionally disabled to keep the portfolio visually flat.
abstract final class AppShadows {
  static const elevated = <BoxShadow>[];
  static const card = <BoxShadow>[];
  static const hover = <BoxShadow>[];
}
