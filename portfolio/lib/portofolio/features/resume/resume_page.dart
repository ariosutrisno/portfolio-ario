
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:portofolio/portofolio/core/bio_config.dart';
import 'package:portofolio/portofolio/core/design_system.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Elegant CV palette — clean white paper on dark background
// ─────────────────────────────────────────────────────────────────────────────
abstract final class _Cv {
  // Outer dark background (the "desk")
  static const bg = Color(0xFF0B0F19);

  // Paper surface — pure clean white
  static const paper = Color(0xFFFFFFFF);
  static const paperShadow = Color(0x50000000);

  // Card surfaces inside the paper
  static const cardSurface = Color(0xFFF5F7FA);
  static const cardSurfaceHover = Color(0xFFEDF0F7);
  static const cardBorder = Color(0xFFE2E8F0);
  static const cardBorderHover = Color(0xFFCBD5E1);

  // Header border
  static const headerBorder = Color(0xFFE2E8F0);

  // Text hierarchy — high contrast on white, easy to read
  static const heading = Color(0xFF0F172A);
  static const body = Color(0xFF334155);
  static const muted = Color(0xFF64748B);

  // Accent colors — vibrant on white paper
  static const primary = Color(0xFF2563EB); // Royal blue
  static const primarySoft = Color(0xFFDBEAFE);
  static const secondary = Color(0xFF7C3AED); // Rich violet
  static const secondarySoft = Color(0xFFEDE9FE);
  static const mint = Color(0xFF059669); // Deep emerald
  static const mintSoft = Color(0xFFD1FAE5);
  static const amber = Color(0xFFD97706); // Warm amber
  static const rose = Color(0xFFE11D48); // Vivid rose

  // Pill accent palette (vibrant but clean on white)
  static const pillColors = <(Color, Color)>[
    (Color(0xFF2563EB), Color(0xFFDBEAFE)),   // Blue
    (Color(0xFF7C3AED), Color(0xFFEDE9FE)),   // Violet
    (Color(0xFF059669), Color(0xFFD1FAE5)),   // Emerald
    (Color(0xFFD97706), Color(0xFFFEF3C7)),   // Amber
    (Color(0xFFDB2777), Color(0xFFFCE7F3)),   // Pink
    (Color(0xFF0891B2), Color(0xFFCFFAFE)),   // Cyan
    (Color(0xFF4F46E5), Color(0xFFE0E7FF)),   // Indigo
    (Color(0xFF0D9488), Color(0xFFCCFBF1)),   // Teal
  ];

  // Divider on paper
  static const divider = Color(0xFFE2E8F0);
  static const dividerLight = Color(0xFFF1F5F9);
}

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) => Theme(
    data: AppTheme.resume,
    child: Scaffold(
      backgroundColor: _Cv.bg,
      body: SafeArea(
        child: Stack(
          children: [
            // Ambient background glow orbs behind the paper
            Positioned(
              top: -120,
              left: -80,
              child: _GlowOrb(
                color: _Cv.primary.withValues(alpha: 0.06),
                size: 400,
              ),
            ),
            Positioned(
              top: 300,
              right: -100,
              child: _GlowOrb(
                color: _Cv.secondary.withValues(alpha: 0.05),
                size: 350,
              ),
            ),
            Positioned(
              bottom: 100,
              left: -60,
              child: _GlowOrb(
                color: _Cv.mint.withValues(alpha: 0.04),
                size: 300,
              ),
            ),
            // Main scrollable content
            SingleChildScrollView(
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
                    margin:
                        EdgeInsets.symmetric(horizontal: context.pageGutter),
                    padding: EdgeInsets.all(
                      context.responsive(
                        tiny: 20.0,
                        compact: 28.0,
                        medium: 40.0,
                        expanded: 52.0,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: _Cv.paper,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      boxShadow: [
                        // Main depth shadow
                        const BoxShadow(
                          color: _Cv.paperShadow,
                          blurRadius: 60,
                          offset: Offset(0, 16),
                          spreadRadius: -8,
                        ),
                        // Subtle colored ambient glow
                        BoxShadow(
                          color: _Cv.primary.withValues(alpha: 0.08),
                          blurRadius: 100,
                          offset: const Offset(0, 30),
                        ),
                      ],
                    ),
                    child: const _ResumeContent(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Ambient glow orb for background atmosphere.
class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [color, color.withValues(alpha: 0)],
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
                _ElegantDivider(),
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

/// A subtle gradient divider for the paper look.
class _ElegantDivider extends StatelessWidget {
  const _ElegantDivider();

  @override
  Widget build(BuildContext context) => Container(
    height: 1.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1),
      gradient: const LinearGradient(
        colors: [
          Colors.transparent,
          _Cv.primary,
          _Cv.secondary,
          _Cv.mint,
          Colors.transparent,
        ],
        stops: [0.0, 0.2, 0.5, 0.8, 1.0],
      ),
    ),
  );
}

class _ResumeHeader extends StatelessWidget {
  const _ResumeHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(bottom: AppSpace.lg),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: _Cv.headerBorder, width: 1),
      ),
    ),
    child: LayoutBuilder(
      builder: (context, box) {
        final identity = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gradient badge
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_Cv.primarySoft, _Cv.secondarySoft],
                  ),
                  border: Border.all(
                    color: _Cv.primary.withValues(alpha: 0.25),
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [_Cv.primary, _Cv.secondary],
                  ).createShader(bounds),
                  child: const Text(
                    'CURRICULUM VITAE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppTypeScale.label,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.6,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.sm),
            // Name — bold dark text
            Text(
              BioConfig.name,
              style: AppFonts.heading(
                TextStyle(
                  color: _Cv.heading,
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
                color: _Cv.muted,
                fontSize: AppTypeScale.body,
                height: 1.45,
              ),
            ),
            const SizedBox(height: AppSpace.sm),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: const [
                _HeaderMetaItem(Icons.location_on_outlined, BioConfig.location),
                _HeaderMetaItem(Icons.mail_outline_rounded, BioConfig.email),
                _HeaderMetaItem(Icons.flag_outlined, BioConfig.nationality),
              ],
            ),
          ],
        );
        final action = Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            boxShadow: [
              BoxShadow(
                color: _Cv.primary.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: FilledButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_rounded, size: 18),
            style: FilledButton.styleFrom(
              backgroundColor: _Cv.primary,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: const StadiumBorder(),
            ),
            label: const Text(
              'Portfolio',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
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
            child: Icon(icon, size: 14, color: _Cv.primary),
          ),
        ),
        TextSpan(
          text: text,
          style: const TextStyle(
            color: _Cv.muted,
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
      _SectionHeading(BioConfig.resumeProfileHeading, accent: _Cv.primary),
      _PaperCard(
        accentColor: _Cv.primary,
        child: Text(
          BioConfig.resumeProfileBody,
          style: const TextStyle(color: _Cv.body, height: 1.7),
        ),
      ),
      _SectionHeading(
        BioConfig.resumeContextHeading,
        accent: _Cv.secondary,
      ),
      _PaperCard(
        accentColor: _Cv.secondary,
        child: _ResumeItem(
          title: BioConfig.resumeContextTitle,
          subtitle: BioConfig.resumeContextSubtitle,
          body: BioConfig.resumeContextBody,
          accentColor: _Cv.secondary,
          isLast: true,
        ),
      ),
      _SectionHeading(BioConfig.resumeProjectsHeading, accent: _Cv.mint),
      _PaperCard(
        accentColor: _Cv.mint,
        child: Column(
          children: [
            for (final entry in BioConfig.resumeProjects.indexed)
              _ResumeItem(
                title: entry.$2.title,
                subtitle: entry.$2.subtitle,
                body: entry.$2.description,
                accentColor: _Cv.mint,
                isLast: entry.$1 == BioConfig.resumeProjects.length - 1,
              ),
          ],
        ),
      ),
      _SectionHeading(
        BioConfig.resumeApproachHeading,
        accent: _Cv.amber,
      ),
      _PaperCard(
        accentColor: _Cv.amber,
        child: Text(
          BioConfig.resumeApproachBody,
          style: const TextStyle(color: _Cv.body, height: 1.7),
        ),
      ),
      _SectionHeading(BioConfig.resumeCareerHeading, accent: _Cv.rose),
      _PaperCard(
        accentColor: _Cv.rose,
        child: _CareerDirectionWidget(),
      ),
    ],
  );
}

/// A visual career direction widget with step badges and arrows.
class _CareerDirectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = BioConfig.resumeCareerBody.split('→');
    final colors = [_Cv.muted, _Cv.primary, _Cv.secondary, _Cv.mint];
    final bgColors = [
      _Cv.dividerLight,
      _Cv.primarySoft,
      _Cv.secondarySoft,
      _Cv.mintSoft,
    ];
    final isSmall = context.isCompact;
    final fontSize = isSmall ? AppTypeScale.label : AppTypeScale.small;

    return Wrap(
      spacing: isSmall ? 4 : 6,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 7 : 10,
              vertical: isSmall ? 4 : 5,
            ),
            decoration: BoxDecoration(
              color: i < bgColors.length ? bgColors[i] : _Cv.primarySoft,
              borderRadius: BorderRadius.circular(AppRadius.small),
              border: Border.all(
                color: (i < colors.length ? colors[i] : _Cv.primary)
                    .withValues(alpha: 0.25),
              ),
            ),
            child: Text(
              steps[i].trim(),
              style: TextStyle(
                color: i < colors.length ? colors[i] : _Cv.primary,
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
              ),
            ),
          ),
          if (i < steps.length - 1)
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  i < colors.length ? colors[i] : _Cv.primary,
                  i + 1 < colors.length ? colors[i + 1] : _Cv.primary,
                ],
              ).createShader(bounds),
              child: Icon(
                Icons.arrow_forward_rounded,
                size: isSmall ? 13 : 16,
                color: Colors.white,
              ),
            ),
        ],
      ],
    );
  }
}

class _ResumeAside extends StatelessWidget {
  const _ResumeAside();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _SectionHeading(
        BioConfig.resumeHardSkillsHeading,
        accent: _Cv.primary,
      ),
      _PaperCard(
        accentColor: _Cv.primary,
        child: _ColorPillWrap(BioConfig.resumeHardSkills, startIndex: 0),
      ),
      _SectionHeading(
        BioConfig.resumeFrameworksHeading,
        accent: _Cv.secondary,
      ),
      _PaperCard(
        accentColor: _Cv.secondary,
        child: _ColorPillWrap(BioConfig.resumeFrameworks, startIndex: 2),
      ),
      _SectionHeading(
        BioConfig.resumeAiWorkflowHeading,
        accent: _Cv.mint,
      ),
      _PaperCard(
        accentColor: _Cv.mint,
        child: _ColorPillWrap(BioConfig.resumeAiWorkflow, startIndex: 5),
      ),
      _SectionHeading(
        BioConfig.resumeSoftSkillsHeading,
        accent: _Cv.amber,
      ),
      _PaperCard(
        accentColor: _Cv.amber,
        child: Text(
          BioConfig.resumeSoftSkillsBody,
          style: const TextStyle(color: _Cv.body, height: 1.7),
        ),
      ),
      _SectionHeading(
        BioConfig.resumePortfolioNoteHeading,
        accent: _Cv.rose,
      ),
      _PaperCard(
        accentColor: _Cv.rose,
        child: Text(
          BioConfig.resumePortfolioNoteBody,
          style: const TextStyle(color: _Cv.body, height: 1.7),
        ),
      ),
      _SectionHeading(
        BioConfig.resumeContactHeading,
        accent: _Cv.primary,
      ),
      _PaperCard(
        accentColor: _Cv.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContactRow(
              Icons.mail_outline_rounded,
              'Email',
              BioConfig.email,
              accent: _Cv.primary,
              accentSoft: _Cv.primarySoft,
              onTap: () async {
                await Clipboard.setData(
                  const ClipboardData(text: BioConfig.email),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Email copied to clipboard!'),
                      backgroundColor: _Cv.heading,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                      ),
                      behavior: SnackBarBehavior.floating,
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
              accent: _Cv.secondary,
              accentSoft: _Cv.secondarySoft,
            ),
            const SizedBox(height: AppSpace.sm),
            const _ContactRow(
              Icons.flag_outlined,
              'Nationality',
              BioConfig.nationality,
              accent: _Cv.mint,
              accentSoft: _Cv.mintSoft,
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Paper Card — clean card with subtle hover effects on white paper
// ─────────────────────────────────────────────────────────────────────────────
class _PaperCard extends StatefulWidget {
  const _PaperCard({required this.child, this.accentColor = _Cv.primary});
  final Widget child;
  final Color accentColor;

  @override
  State<_PaperCard> createState() => _PaperCardState();
}

class _PaperCardState extends State<_PaperCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: AppMotion.hover,
      curve: Curves.easeOut,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpace.md),
      padding: const EdgeInsets.all(AppSpace.base),
      decoration: BoxDecoration(
        color: _hovered ? _Cv.cardSurfaceHover : _Cv.cardSurface,
        border: Border.all(
          color: _hovered ? _Cv.cardBorderHover : _Cv.cardBorder,
        ),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: _hovered
            ? [
                BoxShadow(
                  color: widget.accentColor.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
                const BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ]
            : const [
                BoxShadow(
                  color: Color(0x06000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
      ),
      child: widget.child,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Section heading with gradient accent bar — dark text on white paper
// ─────────────────────────────────────────────────────────────────────────────
class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.text, {this.accent = _Cv.primary});
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: AppSpace.sm),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Gradient bar indicator
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [accent, accent.withValues(alpha: 0.3)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: AppFonts.heading(
              TextStyle(
                color: accent,
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

class _ContactRow extends StatelessWidget {
  const _ContactRow(
    this.icon,
    this.label,
    this.value, {
    this.onTap,
    this.accent = _Cv.primary,
    this.accentSoft = _Cv.primarySoft,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final Color accent;
  final Color accentSoft;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.small),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: accentSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 14, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      color: _Cv.muted,
                      fontSize: AppTypeScale.small,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      color: _Cv.heading,
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
            Icon(Icons.copy_rounded, size: 13, color: accent),
          ],
        ],
      ),
    ),
  );
}

class _ResumeItem extends StatelessWidget {
  const _ResumeItem({
    required this.title,
    required this.subtitle,
    required this.body,
    this.accentColor = _Cv.primary,
    this.isLast = false,
  });

  final String title;
  final String subtitle;
  final String body;
  final Color accentColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpace.base),
    margin: EdgeInsets.only(bottom: isLast ? 0 : AppSpace.base),
    decoration: BoxDecoration(
      border: Border(
        bottom: isLast
            ? BorderSide.none
            : const BorderSide(color: _Cv.divider),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.heading(
            const TextStyle(
              color: _Cv.heading,
              fontSize: AppTypeScale.bodyLarge,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: AppSpace.xxs),
        Text(
          subtitle,
          style: TextStyle(
            color: accentColor,
            fontSize: AppTypeScale.small,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          body,
          style: const TextStyle(color: _Cv.body, height: 1.7),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Colorful Pills — vibrant on white paper with hover animation
// ─────────────────────────────────────────────────────────────────────────────
class _ColorPillWrap extends StatelessWidget {
  const _ColorPillWrap(this.items, {this.startIndex = 0});
  final List<String> items;
  final int startIndex;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpace.xs,
    runSpacing: AppSpace.xs,
    children: [
      for (var i = 0; i < items.length; i++)
        _ColorPill(
          items[i],
          colorPair:
              _Cv.pillColors[(startIndex + i) % _Cv.pillColors.length],
        ),
    ],
  );
}

class _ColorPill extends StatefulWidget {
  const _ColorPill(this.text, {required this.colorPair});
  final String text;
  final (Color, Color) colorPair; // (foreground, background)

  @override
  State<_ColorPill> createState() => _ColorPillState();
}

class _ColorPillState extends State<_ColorPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final (fg, bg) = widget.colorPair;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppMotion.hover,
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.sm,
          vertical: AppSpace.xs,
        ),
        decoration: BoxDecoration(
          color: _hovered ? fg.withValues(alpha: 0.15) : bg,
          border: Border.all(
            color: _hovered
                ? fg.withValues(alpha: 0.5)
                : fg.withValues(alpha: 0.18),
          ),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: fg.withValues(alpha: 0.15),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: fg,
            fontSize: AppTypeScale.caption,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
