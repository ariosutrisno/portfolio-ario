import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portofolio/portofolio/app.dart';

void main() {
  const viewports = <String, Size>{
    'tiny legacy viewport': Size(280, 653),
    'small Android': Size(320, 568),
    'standard Android': Size(360, 800),
    'modern phone': Size(390, 844),
    'large phone': Size(430, 932),
    'small foldable': Size(600, 960),
    'mobile breakpoint': Size(680, 960),
    'tablet portrait': Size(768, 1024),
    'tablet landscape': Size(1024, 768),
    'laptop': Size(1366, 768),
    'desktop': Size(1920, 1080),
    '2K desktop': Size(2560, 1440),
    'ultrawide': Size(3440, 1440),
  };

  for (final viewport in viewports.entries) {
    testWidgets('full portfolio is responsive on ${viewport.key}', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(viewport.value);
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      expect(find.text('AS'), findsOneWidget);
      expect(find.text('Explore Selected Work'), findsOneWidget);
      expect(
        find.text('Digital Ramp Operations Management Platform'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);

      final scrollable = find.byType(SingleChildScrollView);
      expect(scrollable, findsOneWidget);
      final dragDistance = viewport.value.height * .72;

      for (var step = 0; step < 12; step++) {
        await tester.drag(scrollable, Offset(0, -dragDistance));
        await tester.pump();
        expect(
          tester.takeException(),
          isNull,
          reason: '${viewport.key} overflowed at scroll step $step',
        );
      }

      expect(
        find.text('Designed as a long-term technology leadership portfolio.'),
        findsOneWidget,
      );
    });
  }

  testWidgets('mobile navigation and dialog survive enlarged text', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    tester.platformDispatcher.textScaleFactorTestValue = 1.4;
    addTearDown(() async {
      tester.platformDispatcher.clearTextScaleFactorTestValue();
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Buka menu'));
    await tester.pumpAndSettle();
    expect(find.text('Journey'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();

    final caseStudyLink = find.text('View case study').first;
    await Scrollable.ensureVisible(
      tester.element(caseStudyLink),
      alignment: .5,
      duration: const Duration(milliseconds: 300),
    );
    await tester.pumpAndSettle();
    await tester.tap(caseStudyLink);
    await tester.pumpAndSettle();

    expect(find.text('Close'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
