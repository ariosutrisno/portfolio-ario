import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Modern visual surface recipes and ambient lighting effects.
abstract final class AppGradients {
  static const background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F172A),
      C.background,
      Color(0xFF080C14),
    ],
  );

  static const card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF192438),
      C.panel,
      Color(0xFF111827),
    ],
  );

  static const projectArt = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E293B),
      Color(0xFF131D31),
      Color(0xFF0F172A),
    ],
  );

  static const leadership = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF192337),
      Color(0xFF0F172A),
    ],
  );

  static const accent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      C.accent,
      C.accent2,
    ],
  );
}

/// Ambient elevation and glow shadows providing tactile depth.
abstract final class AppShadows {
  static const elevated = <BoxShadow>[
    BoxShadow(
      color: Color(0x59000000),
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];

  static const card = <BoxShadow>[
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static const hover = <BoxShadow>[
    BoxShadow(
      color: Color(0x3338BDF8),
      blurRadius: 20,
      offset: Offset(0, 4),
    ),
  ];
}

