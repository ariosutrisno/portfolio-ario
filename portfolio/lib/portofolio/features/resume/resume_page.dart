import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:portofolio/portofolio/core/bio_config.dart';
import 'package:portofolio/portofolio/core/design_system.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) => Theme(
    data: AppTheme.resume,
    child: Scaffold(
      backgroundColor: C.background,
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
              constraints: const BoxConstraints(maxWidth: 1040),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: context.pageGutter),
                padding: EdgeInsets.all(
                  context.responsive(
                    tiny: 18.0,
                    compact: 24.0,
                    medium: 36.0,
                    expanded: 48.0,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF162032),
                      C.panel,
                      Color(0xFF0F172A),
                    ],
                  ),
                  border: Border.all(color: C.lineStrong),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  boxShadow: AppShadows.card,
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
          if (box.maxWidth < 800) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ResumeMain(),
                SizedBox(height: AppSpace.xl),
                Divider(color: C.line),
                SizedBox(height: AppSpace.md),
                _ResumeAside(),
              ],
            );
          }
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _ResumeMain()),
              SizedBox(width: AppSpace.xl),
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
      border: Border(bottom: BorderSide(color: C.lineStrong, width: 1.5)),
    ),
    child: LayoutBuilder(
      builder: (context, box) {
        final identity = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: C.accentGlow15,
                  border: Border.all(color: C.accent),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: const Text(
                  'CURRICULUM VITAE',
                  style: TextStyle(
                    color: C.accent,
                    fontSize: AppTypeScale.label,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.sm),
            Text(
              BioConfig.name,
              style: AppFonts.heading(
                TextStyle(
                  color: C.text,
                  fontSize: context.isCompact ? 32 : 42,
                  height: 1.05,
                  letterSpacing: -1.4,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.xs),
            Text(
              BioConfig.roleTitle,
              style: const TextStyle(
                color: C.muted,
                fontSize: AppTypeScale.body,
                height: 1.45,
              ),
            ),
            const SizedBox(height: AppSpace.sm),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                _HeaderMetaItem(Icons.location_on_outlined, BioConfig.location),
                _HeaderMetaItem(Icons.mail_outline_rounded, BioConfig.email),
                _HeaderMetaItem(Icons.flag_outlined, BioConfig.nationality),
              ],
            ),
          ],
        );
        final action = FilledButton.icon(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded, size: 18),
          style: FilledButton.styleFrom(
            backgroundColor: C.accent,
            foregroundColor: C.darkText,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
          label: const Text(
            'Portfolio',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        );
        return box.maxWidth < 640
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  identity,
                  const SizedBox(height: AppSpace.base),
                  action,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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

class _HeaderMetaItem extends StatelessWidget {
  const _HeaderMetaItem(this.icon, this.text);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      children: [
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(icon, size: 14, color: C.accent),
          ),
        ),
        TextSpan(
          text: text,
          style: const TextStyle(
            color: C.muted,
            fontSize: AppTypeScale.small,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _ResumeMain extends StatelessWidget {
  const _ResumeMain();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _ResumeHeading(BioConfig.resumeProfileHeading),
      _ResumeCard(
        child: Text(
          BioConfig.resumeProfileBody,
          style: const TextStyle(color: C.text, height: 1.65),
        ),
      ),
      const _ResumeHeading(BioConfig.resumeContextHeading),
      _ResumeCard(
        child: _ResumeItem(
          title: BioConfig.resumeContextTitle,
          subtitle: BioConfig.resumeContextSubtitle,
          body: BioConfig.resumeContextBody,
          isLast: true,
        ),
      ),
      const _ResumeHeading(BioConfig.resumeProjectsHeading),
      _ResumeCard(
        child: Column(
          children: [
            for (final entry in BioConfig.resumeProjects.indexed)
              _ResumeItem(
                title: entry.$2.title,
                subtitle: entry.$2.subtitle,
                body: entry.$2.description,
                isLast: entry.$1 == BioConfig.resumeProjects.length - 1,
              ),
          ],
        ),
      ),
      const _ResumeHeading(BioConfig.resumeApproachHeading),
      _ResumeCard(
        child: Text(
          BioConfig.resumeApproachBody,
          style: const TextStyle(color: C.text, height: 1.65),
        ),
      ),
      const _ResumeHeading(BioConfig.resumeCareerHeading),
      _ResumeCard(
        child: Text(
          BioConfig.resumeCareerBody,
          style: const TextStyle(
            color: C.accent,
            fontWeight: FontWeight.w600,
            height: 1.6,
          ),
        ),
      ),
    ],
  );
}

class _ResumeAside extends StatelessWidget {
  const _ResumeAside();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _ResumeHeading(BioConfig.resumeHardSkillsHeading),
      _ResumeCard(
        child: _PillWrap(BioConfig.resumeHardSkills),
      ),
      const _ResumeHeading(BioConfig.resumeFrameworksHeading),
      _ResumeCard(
        child: _PillWrap(BioConfig.resumeFrameworks),
      ),
      const _ResumeHeading(BioConfig.resumeAiWorkflowHeading),
      _ResumeCard(
        child: _PillWrap(BioConfig.resumeAiWorkflow),
      ),
      const _ResumeHeading(BioConfig.resumeSoftSkillsHeading),
      _ResumeCard(
        child: Text(
          BioConfig.resumeSoftSkillsBody,
          style: const TextStyle(color: C.muted, height: 1.6),
        ),
      ),
      const _ResumeHeading(BioConfig.resumePortfolioNoteHeading),
      _ResumeCard(
        child: Text(
          BioConfig.resumePortfolioNoteBody,
          style: const TextStyle(color: C.muted, height: 1.6),
        ),
      ),
      const _ResumeHeading(BioConfig.resumeContactHeading),
      _ResumeCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContactRow(
              Icons.mail_outline_rounded,
              'Email',
              BioConfig.email,
              onTap: () async {
                await Clipboard.setData(
                  const ClipboardData(text: BioConfig.email),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email copied to clipboard!'),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: AppSpace.sm),
            const _ContactRow(
              Icons.location_on_outlined,
              'Location',
              BioConfig.location,
            ),
            const SizedBox(height: AppSpace.sm),
            const _ContactRow(
              Icons.flag_outlined,
              'Nationality',
              BioConfig.nationality,
            ),
          ],
        ),
      ),
    ],
  );
}

class _ResumeCard extends StatelessWidget {
  const _ResumeCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: AppSpace.md),
    padding: const EdgeInsets.all(AppSpace.base),
    decoration: BoxDecoration(
      color: C.panel2,
      border: Border.all(color: C.line),
      borderRadius: BorderRadius.circular(AppRadius.medium),
    ),
    child: child,
  );
}

class _ContactRow extends StatelessWidget {
  const _ContactRow(this.icon, this.label, this.value, {this.onTap});

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.small),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: C.accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      color: C.muted,
                      fontSize: AppTypeScale.small,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      color: C.text,
                      fontSize: AppTypeScale.small,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 4),
            const Icon(Icons.copy_rounded, size: 13, color: C.accent),
          ],
        ],
      ),
    ),
  );
}

class _ResumeHeading extends StatelessWidget {
  const _ResumeHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: AppSpace.sm),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: C.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppFonts.heading(
              const TextStyle(
                color: C.text,
                fontSize: AppTypeScale.caption,
                letterSpacing: 1.8,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ResumeItem extends StatelessWidget {
  const _ResumeItem({
    required this.title,
    required this.subtitle,
    required this.body,
    this.isLast = false,
  });

  final String title;
  final String subtitle;
  final String body;
  final bool isLast;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpace.base),
    margin: EdgeInsets.only(bottom: isLast ? 0 : AppSpace.base),
    decoration: BoxDecoration(
      border: Border(
        bottom: isLast
            ? BorderSide.none
            : const BorderSide(color: C.line),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.heading(
            const TextStyle(
              color: C.text,
              fontSize: AppTypeScale.bodyLarge,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: AppSpace.xxs),
        Text(
          subtitle,
          style: const TextStyle(
            color: C.accent,
            fontSize: AppTypeScale.small,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          body,
          style: const TextStyle(color: C.muted, height: 1.6),
        ),
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
      color: C.panel,
      border: Border.all(color: C.lineStrong),
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: C.text,
        fontSize: AppTypeScale.caption,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
