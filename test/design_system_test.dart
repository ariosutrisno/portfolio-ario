import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portofolio/portofolio/core/design_system.dart';

void main() {
  group('global design tokens', () {
    test('calm navy monochrome palette retains its exact values', () {
      expect(C.garudaNavy, const Color(0xFF002561));
      expect(C.background, C.garudaNavy);
      expect(C.accent, C.text);
      expect(C.text, const Color(0xFFF4F6F8));
      expect(C.darkText, const Color(0xFF111111));
    });

    test('brand surfaces keep important text comfortably readable', () {
      double contrast(Color foreground, Color background) {
        final light = foreground.computeLuminance();
        final dark = background.computeLuminance();
        final brightest = light > dark ? light : dark;
        final darkest = light > dark ? dark : light;
        return (brightest + .05) / (darkest + .05);
      }

      expect(contrast(C.text, C.background), greaterThanOrEqualTo(4.5));
      expect(contrast(C.muted, C.background), greaterThanOrEqualTo(4.5));
      expect(contrast(C.darkText, C.accent), greaterThanOrEqualTo(4.5));
      expect(contrast(C.resumeBody, C.pureWhite), greaterThanOrEqualTo(4.5));
    });

    test('font families and fluid type scale are globally bounded', () {
      expect(AppFonts.body, 'DM Sans');
      expect(AppFonts.display, 'Manrope');
      expect(AppTypeScale.hero(240), 38);
      expect(AppTypeScale.hero(680), 44);
      expect(AppTypeScale.hero(5000), 86);
    });

    test('layout helpers cover narrow through ultrawide viewports', () {
      expect(AppLayout.gutter(240), AppLayout.tinyGutter);
      expect(AppLayout.gutter(390), AppLayout.mobileGutter);
      expect(AppLayout.gutter(1440), AppLayout.desktopGutter);
      expect(AppLayout.gridColumns(320), 1);
      expect(AppLayout.gridColumns(680), 1);
      expect(AppLayout.gridColumns(681), 2);
      expect(AppLayout.gridColumns(768), 2);
      expect(AppLayout.gridColumns(1240), 2);
      expect(AppLayout.gridColumns(1440), 3);
    });

    test('global scroll accepts every supported pointer device', () {
      final devices = const AppScrollBehavior().dragDevices;

      expect(devices, contains(PointerDeviceKind.touch));
      expect(devices, contains(PointerDeviceKind.mouse));
      expect(devices, contains(PointerDeviceKind.stylus));
      expect(devices, contains(PointerDeviceKind.trackpad));
    });

    testWidgets('global scroll physics adapt to the host platform', (
      tester,
    ) async {
      const behavior = AppScrollBehavior();
      late ScrollPhysics physics;

      Future<void> readPhysics(TargetPlatform platform) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Theme(
              data: ThemeData(platform: platform),
              child: Builder(
                builder: (context) {
                  physics = behavior.getScrollPhysics(context);
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      }

      await readPhysics(TargetPlatform.iOS);
      expect(physics, isA<BouncingScrollPhysics>());

      await readPhysics(TargetPlatform.macOS);
      expect(physics, isA<BouncingScrollPhysics>());

      await readPhysics(TargetPlatform.android);
      expect(physics, isA<ClampingScrollPhysics>());

      await readPhysics(TargetPlatform.windows);
      expect(physics, isA<ClampingScrollPhysics>());
    });
  });

  group('responsive context', () {
    const cases = <(double, ScreenClass)>[
      (240, ScreenClass.tiny),
      (320, ScreenClass.compact),
      (680, ScreenClass.compact),
      (681, ScreenClass.medium),
      (1001, ScreenClass.expanded),
      (1440, ScreenClass.large),
      (1920, ScreenClass.ultraWide),
    ];

    for (final entry in cases) {
      testWidgets('${entry.$1}px maps to ${entry.$2.name}', (tester) async {
        late ScreenClass actual;

        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: Size(entry.$1, 800)),
            child: Builder(
              builder: (context) {
                actual = context.screenClass;
                return const SizedBox.shrink();
              },
            ),
          ),
        );

        expect(actual, entry.$2);
      });
    }

    testWidgets('reduced motion removes global animation duration', (
      tester,
    ) async {
      late Duration actual;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Builder(
            builder: (context) {
              actual = context.accessibleDuration(AppMotion.reveal);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(actual, Duration.zero);
    });

    testWidgets('reveal content appears immediately with reduced motion', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true, size: Size(320, 568)),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SingleChildScrollView(
              child: AppReveal(child: Text('Accessible content')),
            ),
          ),
        ),
      );
      await tester.pump();

      final transition = tester.widget<FadeTransition>(
        find.byType(FadeTransition),
      );
      expect(transition.opacity.value, 1);
      expect(find.text('Accessible content'), findsOneWidget);
    });
  });
}
