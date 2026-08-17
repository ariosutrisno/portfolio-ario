import 'package:flutter/material.dart';

import '../bio_config.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Shared copyright line with a year that updates automatically.
class AppCopyright extends StatelessWidget {
  const AppCopyright({super.key, this.textAlign});

  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => Text(
    '© ${DateTime.now().year} ${BioConfig.name}. All rights reserved.',
    textAlign: textAlign,
    style: const TextStyle(color: C.muted, fontSize: AppTypeScale.caption),
  );
}
