import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portofolio/portofolio/app.dart';

void main() {
  const viewports = <String, Size>{
    'narrow embedded web': Size(240, 480),
    'tiny legacy viewport': Size(280, 653),
    'small Android': Size(320, 568),
    'standard Android': Size(360, 800),
    'modern phone': Size(390, 844),
    'modern phone landscape': Size(844, 390),
    'large phone': Size(430, 932),
    'small foldable': Size(600, 960),
    'small foldable landscape': Size(960, 600),
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
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = viewport.value;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      expect(find.text('AS'), findsOneWidget);
      expect(
        find.text(
          '© ${DateTime.now().year} Ario Sutrisno. All rights reserved.',
        ),
        findsOneWidget,
      );
      expect(find.text('Explore Selected Work'), findsOneWidget);
      expect(find.text('FSMS — FOO Station Management System'), findsOneWidget);
      expect(find.text('Digital Ramp Checklist'), findsOneWidget);
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

  testWidgets('footer uses opposite content edges on laptop', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1366, 768);
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final identity = find.byKey(const ValueKey('footer-identity'));
    final details = find.byKey(const ValueKey('footer-details'));
    expect(tester.getTopLeft(identity).dx, closeTo(87, 1));
    expect(tester.getTopRight(details).dx, closeTo(1279, 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'mobile navigation, case study, and resume survive enlarged text',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 568);
      tester.platformDispatcher.textScaleFactorTestValue = 1.4;
      addTearDown(() async {
        tester.platformDispatcher.clearTextScaleFactorTestValue();
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byTooltip('Open menu'));
      await tester.pumpAndSettle();
      expect(find.text('Journey'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      final caseStudyLink = find.text('View case study').first;
      await Scrollable.ensureVisible(
        tester.element(caseStudyLink),
        alignment: .5,
        duration: Duration.zero,
      );
      await tester.pumpAndSettle();
      await tester.tap(caseStudyLink);
      await tester.pumpAndSettle();

      expect(find.text('Back to selected work'), findsOneWidget);
      expect(find.text('01 — OPERATIONAL CONTEXT'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byTooltip('Back to portfolio'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Open menu'));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView), const Offset(0, -420));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Resume'));
      await tester.pumpAndSettle();

      expect(find.text('PROFILE'), findsOneWidget);
      expect(find.text('HARD SKILLS'), findsOneWidget);
      expect(find.text('Microsoft Office'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
