import 'package:flutter/material.dart';

import '../bio_config.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/app_typography.dart';

/// Reusable portfolio identity for headers on every supported platform.
class AppIdentityMark extends StatelessWidget {
  const AppIdentityMark({super.key, this.showName = true});

  final bool showName;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: C.garudaNavy,
          border: Border.all(color: C.white),
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: Text(
          BioConfig.initials,
          semanticsLabel: '${BioConfig.name} initials',
          style: const TextStyle(
            fontSize: AppTypeScale.small,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      if (showName) ...[
        const SizedBox(width: 12),
        Text(
          BioConfig.name.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: AppTypeScale.bodySmall,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ],
  );
}
