import 'package:flutter/material.dart';

import '../responsive/app_layout.dart';
import '../responsive/responsive_context.dart';

/// Shared page shell equivalent to the website's `.shell` CSS class.
///
/// It caps readable content at 1240 px, centers it on wide screens, and applies
/// responsive gutters on every mobile, tablet, desktop, and web viewport.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final availableWidth = box.maxWidth.isFinite
          ? box.maxWidth
          : context.screenWidth;
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayout.maxContentWidth,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.gutter(availableWidth),
            ),
            child: child,
          ),
        ),
      );
    },
  );
}
