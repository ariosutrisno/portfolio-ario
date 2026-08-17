import 'package:flutter/material.dart';

import 'package:portofolio/portofolio/core/bio_config.dart';
import 'package:portofolio/portofolio/core/design_system.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) => Theme(
    data: AppTheme.resume,
    child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(
              tiny: AppSpace.sm,
              compact: AppSpace.md,
              medium: AppSpace.xl,
              expanded: AppSpace.xxl,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: context.pageGutter),
                padding: EdgeInsets.all(
                  context.responsive(
                    tiny: 20.0,
                    compact: 28.0,
                    medium: 42.0,
                    expanded: 54.0,
                  ),
                ),
                decoration: BoxDecoration(
                  color: C.pureWhite,
                  border: Border.all(color: C.resumeBorder),
                ),
                child: const _ResumeContent(),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _ResumeContent extends StatelessWidget {
  const _ResumeContent();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ResumeHeader(onBack: () => Navigator.maybePop(context)),
      const SizedBox(height: AppSpace.xl),
      LayoutBuilder(
        builder: (context, box) {
          if (box.maxWidth < 760) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ResumeMain(),
                SizedBox(height: AppSpace.xl),
                Divider(),
                SizedBox(height: AppSpace.md),
                _ResumeAside(),
              ],
            );
          }
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: _ResumeMain()),
              SizedBox(width: AppSpace.xxl),
              Expanded(flex: 2, child: _ResumeAside()),
            ],
          );
        },
      ),
    ],
  );
}

class _ResumeHeader extends StatelessWidget {
  const _ResumeHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(bottom: AppSpace.lg),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: C.resumeInk, width: 2)),
    ),
    child: LayoutBuilder(
      builder: (context, box) {
        final identity = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              BioConfig.name,
              style: AppFonts.heading(
                TextStyle(
                  color: C.resumeTitle,
                  fontSize: context.isCompact ? 32 : 40,
                  height: 1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.xs),
            const Text(
              'Garuda Indonesia · Operational Experience · Aspiring Developer',
              style: TextStyle(color: C.resumeMuted, height: 1.45),
            ),
          ],
        );
        final action = FilledButton.icon(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded, size: 18),
          label: const Text('Portfolio'),
        );
        return box.maxWidth < 600
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  identity,
                  const SizedBox(height: AppSpace.base),
                  action,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: identity),
                  const SizedBox(width: AppSpace.lg),
                  action,
                ],
              );
      },
    ),
  );
}

class _ResumeMain extends StatelessWidget {
  const _ResumeMain();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ResumeHeading('PROFILE'),
      Text(
        'I work at Garuda Indonesia and am building my path into software development through operationally grounded projects. My current focus is learning to turn familiar workflows into clear applications using Flutter, Laravel, and relational databases.',
        style: TextStyle(color: C.resumeBody),
      ),
      _ResumeHeading('CURRENT CONTEXT'),
      _ResumeItem(
        title: 'Garuda Indonesia',
        subtitle: 'Current workplace · Aviation operational exposure',
        body:
            'Daily exposure to airline operations gives me practical context for identifying repetitive workflows, information gaps, and opportunities for clearer digital tools. Specific role details can be added when ready for publication.',
      ),
      _ResumeHeading('SELECTED PROJECTS'),
      _ResumeItem(
        title: 'FSMS — FOO Station Management System',
        subtitle: 'Laravel · MySQL/MariaDB · Bootstrap · AI-assisted',
        body:
            'A portfolio project exploring how station workflows, operational information, validation, and history can be organized into one structured system.',
      ),
      _ResumeItem(
        title: 'Digital Ramp Checklist',
        subtitle: 'Flutter · Workflow · Mobile UX · AI-assisted',
        body:
            'A mobile-first checklist concept focused on fast scanning, required activity validation, operational timestamps, and traceable completion history.',
      ),
      _ResumeHeading('DEVELOPMENT APPROACH'),
      Text(
        'I currently rely heavily on Codex and AI to help generate, refactor, explain, and test code. I present that honestly: AI gives me speed, while my ongoing responsibility is to understand the result, verify behavior, improve fundamentals, and become more independent over time.',
        style: TextStyle(color: C.resumeBody),
      ),
      _ResumeHeading('CAREER DIRECTION'),
      Text(
        'Operational experience → Stronger coding fundamentals → Junior / Full-stack opportunity → Reliable product engineering.',
        style: TextStyle(color: C.resumeBody),
      ),
    ],
  );
}

class _ResumeAside extends StatelessWidget {
  const _ResumeAside();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ResumeHeading('HARD SKILLS'),
      _PillWrap(['Microsoft Office', 'MySQL / MariaDB']),
      _ResumeHeading('FRAMEWORKS'),
      _PillWrap(['Laravel', 'Flutter', 'Bootstrap']),
      _ResumeHeading('AI WORKFLOW'),
      _PillWrap(['Codex', 'Prompting', 'Code explanation', 'Testing support']),
      _ResumeHeading('SOFT-SKILL GROWTH'),
      Text(
        'Actively developing clearer communication, collaboration, confidence, and ownership through project work and feedback.',
        style: TextStyle(color: C.resumeBody),
      ),
      _ResumeHeading('PORTFOLIO NOTE'),
      Text(
        'First portfolio. Built iteratively with extensive AI assistance and a commitment to honest improvement.',
        style: TextStyle(color: C.resumeBody),
      ),
      _ResumeHeading('CONTACT'),
      Text(
        'Email: ${BioConfig.email}\n'
        'Location: ${BioConfig.location}\n'
        'Nationality: ${BioConfig.nationality}',
        style: TextStyle(color: C.resumeBody),
      ),
    ],
  );
}

class _ResumeHeading extends StatelessWidget {
  const _ResumeHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 30, bottom: AppSpace.md),
    child: Text(
      text,
      style: AppFonts.heading(
        const TextStyle(
          color: C.resumeTitle,
          fontSize: AppTypeScale.bodySmall,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}

class _ResumeItem extends StatelessWidget {
  const _ResumeItem({
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final String title;
  final String subtitle;
  final String body;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(bottom: AppSpace.lg),
    margin: const EdgeInsets.only(bottom: AppSpace.lg),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: C.resumeRule)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.heading(
            const TextStyle(
              color: C.resumeTitle,
              fontSize: AppTypeScale.resumeItem,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: AppSpace.xxs),
        Text(
          subtitle,
          style: const TextStyle(
            color: C.darkGreen,
            fontSize: AppTypeScale.small,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(body, style: const TextStyle(color: C.resumeBody)),
      ],
    ),
  );
}

class _PillWrap extends StatelessWidget {
  const _PillWrap(this.items);

  final List<String> items;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpace.xs,
    runSpacing: AppSpace.xs,
    children: [for (final item in items) _Pill(item)],
  );
}

class _Pill extends StatelessWidget {
  const _Pill(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpace.sm,
      vertical: AppSpace.xs,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: C.resumeTagLine),
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: C.resumeTitle,
        fontSize: AppTypeScale.caption,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
