import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portofolio/portofolio/core/design_system.dart';
import 'package:portofolio/portofolio/features/case_study/case_study_data.dart';
import 'package:portofolio/portofolio/features/case_study/case_study_page.dart';
import 'package:portofolio/portofolio/features/resume/resume_page.dart';

void main() {
  const pageSizes = <String, Size>{
    'narrow': Size(240, 480),
    'desktop': Size(1440, 900),
  };

  for (final size in pageSizes.entries) {
    for (final study in [
      CaseStudies.fsms,
      CaseStudies.digitalRamp,
      CaseStudies.dataAiConcept,
      CaseStudies.architectureConcept,
    ]) {
      testWidgets('${study.slug} is responsive on ${size.key}', (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = size.value;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.dark,
            scrollBehavior: const AppScrollBehavior(),
            home: CaseStudyPage(study: study),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(study.title), findsOneWidget);
        expect(find.text('Back to selected work'), findsOneWidget);
        expect(tester.takeException(), isNull);

        final scrollable = find.byType(SingleChildScrollView);
        for (var step = 0; step < 10; step++) {
          await tester.drag(scrollable, Offset(0, -size.value.height * .72));
          await tester.pump();
          expect(
            tester.takeException(),
            isNull,
            reason: '${study.slug} overflowed at step $step on ${size.key}',
          );
        }

        expect(find.text('Portfolio'), findsOneWidget);
      });
    }

    testWidgets('resume is responsive on ${size.key}', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size.value;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          scrollBehavior: AppScrollBehavior(),
          home: ResumePage(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('PROFILE'), findsOneWidget);
      expect(find.text('FSMS — FOO Station Management System'), findsOneWidget);
      expect(find.text('Microsoft Office'), findsOneWidget);
      expect(tester.takeException(), isNull);

      final scrollable = find.byType(SingleChildScrollView);
      for (var step = 0; step < 8; step++) {
        await tester.drag(scrollable, Offset(0, -size.value.height * .7));
        await tester.pump();
        expect(
          tester.takeException(),
          isNull,
          reason: 'Resume overflowed at step $step on ${size.key}',
        );
      }

      expect(find.text('CONTACT'), findsOneWidget);
    });
  }
}
