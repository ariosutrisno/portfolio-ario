import 'package:flutter/material.dart';

import 'package:portofolio/portofolio/core/bio_config.dart';
import 'package:portofolio/portofolio/core/design_system.dart';
import 'package:portofolio/portofolio/features/resume/resume_page.dart';

import 'case_study_data.dart';

class CaseStudyPage extends StatelessWidget {
  const CaseStudyPage({super.key, required this.study});

  final CaseStudyData study;

  void _openResume(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const ResumePage()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          _CaseHeader(onResume: () => _openResume(context)),
          Expanded(
            child: SingleChildScrollView(
              primary: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  _CaseHero(study),
                  for (final section in study.sections) _CaseSection(section),
                  _CaseFooter(onResume: () => _openResume(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _CaseHeader extends StatelessWidget {
  const _CaseHeader({required this.onResume});

  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) => Container(
    height: context.navigationHeight,
    decoration: const BoxDecoration(
      color: C.headerGlass,
      border: Border(bottom: BorderSide(color: C.line)),
    ),
    child: AppShell(
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            tooltip: 'Back to portfolio',
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(width: AppSpace.xs),
          const AppIdentityMark(showName: false),
          if (!context.isTiny) ...[
            const SizedBox(width: AppSpace.sm),
            const Expanded(
              child: Text(
                'CASE STUDY',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppTypeScale.small,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ] else
            const Spacer(),
          TextButton(onPressed: onResume, child: const Text('Resume')),
        ],
      ),
    ),
  );
}

class _CaseHero extends StatelessWidget {
  const _CaseHero(this.study);

  final CaseStudyData study;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: C.backgroundSoft,
      border: Border(bottom: BorderSide(color: C.line)),
    ),
    child: AppShell(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.responsive(
            tiny: 56.0,
            compact: 66.0,
            medium: 82.0,
            expanded: 96.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_rounded, size: 17),
              label: const Text('Back to selected work'),
              style: TextButton.styleFrom(
                foregroundColor: C.backLink,
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: AppSpace.xxl),
            Text(
              study.eyebrow,
              style: const TextStyle(
                color: C.accent,
                fontSize: AppTypeScale.caption,
                letterSpacing: 1.7,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: AppSpace.base),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Text(
                study.title,
                style: AppFonts.heading(
                  TextStyle(
                    fontSize: AppTypeScale.caseHero(context.screenWidth),
                    height: 1.02,
                    letterSpacing: -1.8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.lg),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 790),
              child: Text(
                study.summary,
                style: const TextStyle(
                  color: C.caseLead,
                  fontSize: AppTypeScale.lead,
                  height: 1.65,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.xxl),
            _MetaGrid(study.meta),
            const SizedBox(height: AppSpace.lg),
            Container(
              padding: const EdgeInsets.all(AppSpace.md),
              decoration: BoxDecoration(
                color: C.accentGlow07,
                border: Border.all(color: C.accentGlow23),
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.verified_user_outlined,
                    color: C.accent,
                    size: 19,
                  ),
                  const SizedBox(width: AppSpace.sm),
                  Expanded(
                    child: Text(
                      study.disclaimer,
                      style: const TextStyle(
                        color: C.leadText,
                        fontSize: AppTypeScale.bodySmall,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _MetaGrid extends StatelessWidget {
  const _MetaGrid(this.items);

  final List<CaseMeta> items;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final columns = box.maxWidth >= 900 ? 4 : (box.maxWidth >= 520 ? 2 : 1);
      const gap = AppSpace.lg;
      final width = (box.maxWidth - gap * (columns - 1)) / columns;
      return Container(
        padding: const EdgeInsets.only(top: AppSpace.lg),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: C.line)),
        ),
        child: Wrap(
          spacing: gap,
          runSpacing: AppSpace.lg,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: const TextStyle(
                        color: C.deepMuted,
                        fontSize: AppTypeScale.micro,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpace.xxs),
                    Text(
                      item.value,
                      style: const TextStyle(
                        fontSize: AppTypeScale.bodySmall,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    },
  );
}

class _CaseSection extends StatelessWidget {
  const _CaseSection(this.section);

  final CaseStudySection section;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: C.line)),
    ),
    child: AppShell(
      child: AppReveal(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.sectionSpace),
          child: LayoutBuilder(
            builder: (context, box) {
              final split = box.maxWidth > AppBreakpoints.medium;
              final index = Text(
                '${section.index} — ${section.label}',
                style: const TextStyle(
                  color: C.accent,
                  fontSize: AppTypeScale.label,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w900,
                ),
              );
              final content = _CaseSectionContent(section);
              return split
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: index),
                        const SizedBox(width: AppSpace.xxl),
                        Expanded(flex: 5, child: content),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        index,
                        const SizedBox(height: AppSpace.xl),
                        content,
                      ],
                    );
            },
          ),
        ),
      ),
    ),
  );
}

class _CaseSectionContent extends StatelessWidget {
  const _CaseSectionContent(this.section);

  final CaseStudySection section;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        section.title,
        style: AppFonts.heading(
          TextStyle(
            fontSize: AppTypeScale.caseSection(context.screenWidth),
            height: 1.1,
            letterSpacing: -1,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(height: AppSpace.base),
      Text(
        section.body,
        style: const TextStyle(
          color: C.caseBody,
          fontSize: AppTypeScale.bodyLarge,
          height: 1.7,
        ),
      ),
      if (section.metrics.isNotEmpty) ...[
        const SizedBox(height: AppSpace.xl),
        _MetricGrid(section.metrics),
      ],
      if (section.flow.isNotEmpty) ...[
        const SizedBox(height: AppSpace.xl),
        _Flow(section.flow),
      ],
      if (section.decisions.isNotEmpty) ...[
        const SizedBox(height: AppSpace.xl),
        _DecisionList(section.decisions),
      ],
    ],
  );
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid(this.metrics);

  final List<CaseMetric> metrics;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final columns = box.maxWidth >= 680 ? 3 : 1;
      const gap = AppSpace.sm;
      final width = (box.maxWidth - gap * (columns - 1)) / columns;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final metric in metrics)
            Container(
              width: width,
              constraints: const BoxConstraints(minHeight: 132),
              padding: const EdgeInsets.all(AppSpace.base),
              decoration: BoxDecoration(
                color: C.panel,
                border: Border.all(color: C.line),
                borderRadius: BorderRadius.circular(AppRadius.large),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metric.value,
                    style: AppFonts.heading(
                      const TextStyle(
                        color: C.text,
                        fontSize: AppTypeScale.titleLarge,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    metric.label,
                    style: const TextStyle(
                      color: C.caseMetric,
                      fontSize: AppTypeScale.caption,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    },
  );
}

class _Flow extends StatelessWidget {
  const _Flow(this.steps);

  final List<String> steps;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      if (box.maxWidth < 720) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final step in steps.indexed) ...[
              _FlowNode(step.$2),
              if (step.$1 < steps.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpace.xs),
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: C.accent,
                    size: 18,
                  ),
                ),
            ],
          ],
        );
      }

      return Row(
        children: [
          for (final step in steps.indexed) ...[
            Expanded(child: _FlowNode(step.$2)),
            if (step.$1 < steps.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpace.xs),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: C.accent,
                  size: 18,
                ),
              ),
          ],
        ],
      );
    },
  );
}

class _FlowNode extends StatelessWidget {
  const _FlowNode(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 68),
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpace.sm,
      vertical: AppSpace.md,
    ),
    decoration: BoxDecoration(
      color: C.panel2,
      border: Border.all(color: C.lineStrong),
      borderRadius: BorderRadius.circular(AppRadius.medium),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: AppTypeScale.caption,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class _DecisionList extends StatelessWidget {
  const _DecisionList(this.items);

  final List<String> items;

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: C.line)),
    ),
    child: Column(
      children: [
        for (final item in items.indexed)
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpace.md),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: C.line)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 42,
                  child: Text(
                    '${item.$1 + 1}'.padLeft(2, '0'),
                    style: const TextStyle(
                      color: C.deepMuted,
                      fontSize: AppTypeScale.label,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.$2,
                    style: const TextStyle(
                      fontSize: AppTypeScale.body,
                      height: 1.55,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

class _CaseFooter extends StatelessWidget {
  const _CaseFooter({required this.onResume});

  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) => AppShell(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.xxl),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpace.lg,
        runSpacing: AppSpace.md,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                BioConfig.name,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              SizedBox(height: AppSpace.xxs),
              Text(
                'Garuda Indonesia · Operations · Software',
                style: TextStyle(
                  color: C.footerText,
                  fontSize: AppTypeScale.caption,
                ),
              ),
              SizedBox(height: AppSpace.xxs),
              AppCopyright(),
            ],
          ),
          Wrap(
            spacing: AppSpace.sm,
            children: [
              TextButton(
                onPressed: () => Navigator.maybePop(context),
                child: const Text('Portfolio'),
              ),
              FilledButton(onPressed: onResume, child: const Text('Resume')),
            ],
          ),
        ],
      ),
    ),
  );
}
