import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Enables natural drag and scroll input on touchscreens, mouse, and trackpads.
/// This is applied once in `MaterialApp`, so every future page inherits it.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    final platform = getPlatform(context);
    return switch (platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      _ => const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    };
  }
}
