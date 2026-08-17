import 'package:flutter/material.dart';

import 'core/app_config.dart';
import 'core/design_system.dart';
import 'features/portfolio/portfolio_page.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appTitle,
      restorationScopeId: 'portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      scrollBehavior: const AppScrollBehavior(),
      home: const PortfolioPage(),
    );
  }
}
