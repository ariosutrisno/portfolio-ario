import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:portofolio/portofolio/core/app_config.dart';
import 'package:portofolio/portofolio/core/design_system.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final scaffold = GlobalKey<ScaffoldState>();
  final sections = List.generate(5, (_) => GlobalKey());

  Future<void> go(int index) async {
    if (scaffold.currentState?.isEndDrawerOpen ?? false) {
      Navigator.pop(context);
      await Future<void>.delayed(const Duration(milliseconds: 150));
    }
    final target = sections[index].currentContext;
    if (target != null && target.mounted) {
      await Scrollable.ensureVisible(
        target,
        duration: AppMotion.navigation,
        curve: AppMotion.curve,
        alignment: .02,
      );
    }
  }

  void notice(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: C.panel2,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      endDrawer: MobileMenu(
        onNav: go,
        onResume: () {
          Navigator.pop(context);
          notice('Add resume.html or a CV URL to activate the Resume button.');
        },
      ),
      body: SafeArea(
        bottom: false,
        child: SelectionArea(
          child: Stack(
            children: [
              const Positioned.fill(child: Background()),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: context.navigationHeight),
                    HeroSection(onWork: () => go(0), onAbout: () => go(3)),
                    const CapabilityBand(),
                    KeyedSubtree(key: sections[0], child: const WorkSection()),
                    KeyedSubtree(
                      key: sections[1],
                      child: const ExpertiseSection(),
                    ),
                    KeyedSubtree(
                      key: sections[2],
                      child: const JourneySection(),
                    ),
                    KeyedSubtree(key: sections[3], child: const AboutSection()),
                    const LeadershipSection(),
                    KeyedSubtree(
                      key: sections[4],
                      child: ContactSection(onNotice: notice),
                    ),
                    const Footer(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Header(
                  onNav: go,
                  onMenu: () => scaffold.currentState?.openEndDrawer(),
                  onResume: () => notice(
                    'Add resume.html or a CV URL to activate the Resume button.',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context) => const IgnorePointer(
    child: DecoratedBox(
      decoration: BoxDecoration(gradient: AppGradients.background),
    ),
  );
}

class Shell extends StatelessWidget {
  const Shell({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppLayout.maxContentWidth),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.pageGutter),
        child: child,
      ),
    ),
  );
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.onNav,
    required this.onMenu,
    required this.onResume,
  });
  final ValueChanged<int> onNav;
  final VoidCallback onMenu;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) => Material(
    color: C.background.withValues(alpha: .72),
    child: Container(
      height: context.navigationHeight,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: C.line)),
      ),
      child: Shell(
        child: LayoutBuilder(
          builder: (context, box) {
            final desktop = box.maxWidth >= AppBreakpoints.navigation;
            return Row(
              children: [
                Brand(showName: box.maxWidth >= 290),
                const Spacer(),
                if (desktop) ...[
                  for (final e in [
                    'Work',
                    'Expertise',
                    'Journey',
                    'About',
                  ].indexed)
                    TextButton(
                      onPressed: () => onNav(e.$1),
                      style: TextButton.styleFrom(foregroundColor: C.muted),
                      child: Text(e.$2),
                    ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => onNav(4),
                    style: TextButton.styleFrom(foregroundColor: C.white),
                    child: const Text('Contact'),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 42,
                    child: FilledButton(
                      onPressed: onResume,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                      ),
                      child: const Text('Resume'),
                    ),
                  ),
                ] else
                  IconButton(
                    onPressed: onMenu,
                    tooltip: 'Buka menu',
                    icon: const Icon(Icons.menu_rounded),
                  ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

class Brand extends StatelessWidget {
  const Brand({super.key, this.showName = true});
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
          gradient: LinearGradient(
            colors: [
              C.text.withValues(alpha: .09),
              C.text.withValues(alpha: .02),
            ],
          ),
          border: Border.all(color: C.lineStrong),
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: const Text(
          'AS',
          style: TextStyle(
            fontSize: AppTypeScale.small,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      if (showName) ...[
        const SizedBox(width: 12),
        const Text(
          'ARIO SUTRISNO',
          style: TextStyle(
            fontSize: AppTypeScale.bodySmall,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ],
  );
}

class MobileMenu extends StatelessWidget {
  const MobileMenu({super.key, required this.onNav, required this.onResume});
  final ValueChanged<int> onNav;
  final VoidCallback onResume;
  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: C.panel,
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Brand(showName: false),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 36),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (final e in [
                    'Work',
                    'Expertise',
                    'Journey',
                    'About',
                    'Contact',
                  ].indexed)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        e.$2,
                        style: const TextStyle(
                          fontSize: AppTypeScale.titleLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_outward_rounded,
                        size: 18,
                      ),
                      onTap: () => onNav(e.$1),
                    ),
                  const SizedBox(height: AppSpace.xl),
                  FilledButton(
                    onPressed: onResume,
                    child: const Text('Resume'),
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

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onWork, required this.onAbout});
  final VoidCallback onWork;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) => Shell(
    child: LayoutBuilder(
      builder: (context, box) {
        final desktop = box.maxWidth >= AppBreakpoints.hero;
        final copy = HeroCopy(
          desktop: desktop,
          onWork: onWork,
          onAbout: onAbout,
        );
        const visual = HeroVisual();
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(
              compact: 60.0,
              medium: 76.0,
              expanded: 92.0,
            ),
          ),
          child: desktop
              ? Row(
                  children: [
                    Expanded(flex: 11, child: copy),
                    const SizedBox(width: 54),
                    const Expanded(flex: 9, child: visual),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [copy, const SizedBox(height: 54), visual],
                ),
        );
      },
    ),
  );
}

class HeroCopy extends StatelessWidget {
  const HeroCopy({
    super.key,
    required this.desktop,
    required this.onWork,
    required this.onAbout,
  });
  final bool desktop;
  final VoidCallback onWork;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Eyebrow('TECHNOLOGY · DATA · AI · BUSINESS'),
      const SizedBox(height: 22),
      Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: 'Engineering systems that turn complex operations into ',
            ),
            TextSpan(
              text: 'measurable impact.',
              style: const TextStyle(color: C.lime),
            ),
          ],
        ),
        style: AppFonts.heading(
          TextStyle(
            fontSize: AppTypeScale.hero(context.screenWidth),
            height: 1.04,
            letterSpacing: -2.1,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(height: 24),
      Text(
        'Full-stack developer evolving toward technology leadership — building enterprise software, data intelligence, automation, and digital products with a strong operational mindset.',
        style: TextStyle(
          color: C.leadText,
          fontSize: context.isCompact
              ? AppTypeScale.bodyLarge
              : AppTypeScale.lead,
          height: 1.7,
        ),
      ),
      const SizedBox(height: 30),
      Wrap(
        spacing: 18,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          FilledButton.icon(
            onPressed: onWork,
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.arrow_downward_rounded, size: 18),
            label: const Text('Explore Selected Work'),
          ),
          TextButton.icon(
            onPressed: onAbout,
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.arrow_outward_rounded, size: 18),
            style: TextButton.styleFrom(foregroundColor: C.white),
            label: const Text('About my direction'),
          ),
        ],
      ),
      const SizedBox(height: 45),
      const Wrap(
        spacing: 34,
        runSpacing: 20,
        children: [
          Proof('End-to-end', 'Product & engineering ownership'),
          Proof('Operational', 'Real-world systems & workflows'),
          Proof('Executive-minded', 'Technology tied to business outcomes'),
        ],
      ),
    ],
  );
}

class Proof extends StatelessWidget {
  const Proof(this.title, this.caption, {super.key});
  final String title;
  final String caption;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: context.isCompact ? 260 : 145,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        Text(
          caption,
          style: const TextStyle(
            color: C.muted,
            fontSize: AppTypeScale.small,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

class HeroVisual extends StatelessWidget {
  const HeroVisual({super.key});
  @override
  Widget build(BuildContext context) {
    final visual = CustomPaint(
      painter: OrbitPainter(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 470),
              child: Container(
                width: double.infinity,
                height: context.isCompact ? 360 : 430,
                padding: EdgeInsets.all(
                  context.isCompact ? AppSpace.base : AppSpace.lg,
                ),
                decoration: BoxDecoration(
                  color: C.panel.withValues(alpha: .97),
                  border: Border.all(color: C.lineStrong),
                  borderRadius: BorderRadius.circular(AppRadius.hero),
                  boxShadow: AppShadows.elevated,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 280,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            SignalDot(),
                            SizedBox(width: 9),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'CAREER OPERATING SYSTEM',
                                  style: TextStyle(
                                    color: C.muted,
                                    fontSize: AppTypeScale.label,
                                    letterSpacing: 1.3,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 23),
                        Text(
                          'Build → Scale → Lead',
                          style: AppFonts.heading(
                            const TextStyle(
                              fontSize: AppTypeScale.titleLarge,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 21),
                        const Row(
                          children: [
                            Expanded(child: MiniSkill('01', 'ENGINEERING')),
                            SizedBox(width: 10),
                            Expanded(child: MiniSkill('02', 'DATA & AI')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Expanded(child: MiniSkill('03', 'ARCHITECTURE')),
                            SizedBox(width: 10),
                            Expanded(child: MiniSkill('04', 'STRATEGY')),
                          ],
                        ),
                        const SizedBox(height: 21),
                        const Divider(color: C.line),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'TECHNOLOGY LEADERSHIP TRAJECTORY',
                                  style: TextStyle(
                                    color: C.muted,
                                    fontSize: AppTypeScale.micro,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_outward_rounded, size: 17),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(top: 48, left: 0, child: FloatTag('SYSTEM DESIGN')),
          const Positioned(
            right: -4,
            top: 100,
            child: FloatTag('AI AUTOMATION'),
          ),
          const Positioned(
            bottom: 50,
            left: 18,
            child: FloatTag('BUSINESS IMPACT'),
          ),
        ],
      ),
    );

    if (context.isCompact) {
      return SizedBox(height: 420, child: visual);
    }
    return AspectRatio(aspectRatio: 1, child: visual);
  }
}

class OrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    p.color = C.line;
    canvas.drawCircle(center, size.shortestSide * .43, p);
    p.color = C.lime.withValues(alpha: .23);
    canvas.drawCircle(center, size.shortestSide * .34, p);
    canvas.drawCircle(
      Offset(size.width * .82, size.height * .25),
      4,
      Paint()..color = C.lime,
    );
    canvas.drawCircle(
      Offset(size.width * .17, size.height * .72),
      3,
      Paint()..color = C.blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SignalDot extends StatelessWidget {
  const SignalDot({super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: 8,
    height: 8,
    decoration: const BoxDecoration(
      color: C.lime,
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: C.lime, blurRadius: 8)],
    ),
  );
}

class MiniSkill extends StatelessWidget {
  const MiniSkill(this.number, this.label, {super.key});
  final String number;
  final String label;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: C.ink,
      border: Border.all(color: C.line),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: const TextStyle(color: C.lime, fontSize: AppTypeScale.label),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppTypeScale.caption,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

class FloatTag extends StatelessWidget {
  const FloatTag(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(
      color: C.panel2,
      border: Border.all(color: C.line),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: AppTypeScale.micro,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class CapabilityBand extends StatelessWidget {
  const CapabilityBand({super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: C.lime,
    padding: const EdgeInsets.symmetric(vertical: 19),
    child: Shell(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 15,
        runSpacing: 9,
        children: [
          for (final item in [
            'FULL-STACK ENGINEERING',
            'MOBILE ENGINEERING',
            'BACKEND & API',
            'DATA ENGINEERING',
            'AI & AUTOMATION',
            'SYSTEM ARCHITECTURE',
            'DIGITAL TRANSFORMATION',
          ])
            Text(
              '$item  •',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: C.ink,
                fontSize: AppTypeScale.caption,
                letterSpacing: .8,
                fontWeight: FontWeight.w900,
              ),
            ),
        ],
      ),
    ),
  );
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.dark = false});
  final String text;
  final bool dark;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      color: dark ? C.darkGreen : C.lime,
      fontSize: AppTypeScale.caption,
      letterSpacing: 1.7,
      fontWeight: FontWeight.w900,
    ),
  );
}

class SectionHead extends StatelessWidget {
  const SectionHead(
    this.number,
    this.label,
    this.title,
    this.description, {
    super.key,
  });
  final String number;
  final String label;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final desktop = box.maxWidth >= AppBreakpoints.splitContent;
      final heading = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow('$number — $label'),
          const SizedBox(height: 18),
          Text(
            title,
            style: AppFonts.heading(
              TextStyle(
                fontSize: AppTypeScale.sectionTitle(context.screenWidth),
                height: 1.04,
                letterSpacing: -1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      );
      final copy = Text(
        description,
        style: const TextStyle(
          color: C.muted,
          fontSize: AppTypeScale.bodyLarge,
          height: 1.65,
        ),
      );
      return desktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 3, child: heading),
                const SizedBox(width: 70),
                Expanded(flex: 2, child: copy),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [heading, const SizedBox(height: 22), copy],
            );
    },
  );
}

enum Art { flight, ai, architecture }

class Project {
  const Project(
    this.number,
    this.type,
    this.title,
    this.description,
    this.tags,
    this.art,
  );
  final String number;
  final String type;
  final String title;
  final String description;
  final List<String> tags;
  final Art art;
}

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});
  static const data = [
    Project(
      '01',
      'ENTERPRISE PRODUCT',
      'Digital Ramp Operations Management Platform',
      'A role-based operational platform for managing flight assignments, turnaround activities, safety checks, delay information, approvals, and operational history.',
      ['Flutter', 'API', 'RBAC', 'Operations'],
      Art.flight,
    ),
    Project(
      '02',
      'DATA INTELLIGENCE',
      'AI Aviation Data Quality Platform',
      'An anomaly-detection and data-quality concept that combines deterministic rules, confidence scoring, AI-assisted explanations, and human review.',
      ['Data Quality', 'AI', 'Automation', 'Analytics'],
      Art.ai,
    ),
    Project(
      '03',
      'ENTERPRISE SYSTEMS',
      'Enterprise Integration Architecture',
      'A scalable integration blueprint connecting flight, aircraft, operational, and user systems through APIs, queues, caching, observability, and clear domain boundaries.',
      ['API', 'Events', 'System Design', 'Scalability'],
      Art.architecture,
    ),
  ];
  @override
  Widget build(BuildContext context) => Shell(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionSpace),
      child: Column(
        children: [
          const SectionHead(
            '01',
            'SELECTED WORK',
            'Projects designed around real operational problems.',
            'Each case study explains the business problem, product decision, architecture, implementation approach, and the impact the system is designed to create.',
          ),
          const SizedBox(height: 52),
          LayoutBuilder(
            builder: (context, box) {
              final columns = context.screenWidth >= AppBreakpoints.large
                  ? 3
                  : (context.screenWidth >= AppBreakpoints.medium ? 2 : 1);
              const gap = AppSpace.lg;
              final width = (box.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final p in data)
                    SizedBox(width: width, child: ProjectCard(p)),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}

class ProjectCard extends StatefulWidget {
  const ProjectCard(this.project, {super.key});
  final Project project;
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hover = true),
    onExit: (_) => setState(() => hover = false),
    child: AnimatedContainer(
      duration: AppMotion.hover,
      transform: Matrix4.translationValues(0, hover ? -6 : 0, 0),
      decoration: BoxDecoration(
        color: C.panel,
        border: Border.all(color: hover ? C.lime : C.line),
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: hover ? AppShadows.hover : AppShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProjectArt(widget.project.art),
          Padding(
            padding: EdgeInsets.all(
              context.isCompact ? AppSpace.lg : AppSpace.xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.project.number} / ${widget.project.type}',
                  style: const TextStyle(
                    color: C.muted,
                    fontSize: AppTypeScale.label,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.project.title,
                  style: AppFonts.heading(
                    TextStyle(
                      fontSize: AppTypeScale.featureTitle(context.screenWidth),
                      height: 1.12,
                      letterSpacing: -.8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.project.description,
                  style: const TextStyle(
                    color: C.muted,
                    fontSize: AppTypeScale.body,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [for (final tag in widget.project.tags) Tag(tag)],
                ),
                const SizedBox(height: 18),
                TextButton.icon(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: C.panel2,
                      title: Text(widget.project.title),
                      content: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: Text(
                          '${widget.project.description}\n\nThis case study will cover the problem, process, architecture, contribution, and measurable results.',
                          style: const TextStyle(color: C.muted, height: 1.6),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_outward_rounded, size: 17),
                  style: TextButton.styleFrom(
                    foregroundColor: C.lime,
                    padding: EdgeInsets.zero,
                  ),
                  label: const Text(
                    'View case study',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class ProjectArt extends StatelessWidget {
  const ProjectArt(this.art, {super.key});
  final Art art;
  @override
  Widget build(BuildContext context) => Container(
    height: context.isCompact ? 270 : 330,
    padding: EdgeInsets.all(context.isCompact ? AppSpace.lg : 28),
    decoration: const BoxDecoration(gradient: AppGradients.projectArt),
    child: MediaQuery.withClampedTextScaling(
      minScaleFactor: 1,
      maxScaleFactor: 1,
      child: switch (art) {
        Art.flight => const FlightArt(),
        Art.ai => const AiArt(),
        Art.architecture => const ArchitectureArt(),
      },
    ),
  );
}

const artMuted = TextStyle(
  color: C.muted,
  fontSize: AppTypeScale.micro,
  fontWeight: FontWeight.w700,
);

class FlightArt extends StatelessWidget {
  const FlightArt({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('AVIATION OPERATIONS', style: artMuted),
      const Spacer(),
      ArtPanel(
        child: Column(
          children: [
            const FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('FLT', style: artMuted),
                  SizedBox(width: 12),
                  Text('GA 687', style: TextStyle(fontWeight: FontWeight.w900)),
                  SizedBox(width: 28),
                  Text(
                    'CGK → DPS',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13),
            const LinearProgressIndicator(
              value: .72,
              minHeight: 3,
              color: C.lime,
              backgroundColor: C.line,
            ),
            const SizedBox(height: 13),
            const FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: C.lime, size: 15),
                  SizedBox(width: 7),
                  Text('TURNAROUND ON TRACK', style: artMuted),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class AiArt extends StatelessWidget {
  const AiArt({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('DATA & AI', style: artMuted),
      const Spacer(),
      LayoutBuilder(
        builder: (context, box) {
          const metric = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '97.8%',
                style: TextStyle(
                  fontSize: AppTypeScale.metric,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text('CONFIDENCE', style: artMuted),
            ],
          );
          const statuses = Column(
            children: [
              Status('Route consistency', true),
              SizedBox(height: 8),
              Status('Flight pattern', false),
              SizedBox(height: 8),
              Status('Payload check', true),
            ],
          );

          return ArtPanel(
            child: box.maxWidth < 280
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [metric, SizedBox(height: 12), statuses],
                  )
                : const Row(
                    children: [
                      metric,
                      SizedBox(width: 18),
                      Expanded(child: statuses),
                    ],
                  ),
          );
        },
      ),
    ],
  );
}

class Status extends StatelessWidget {
  const Status(this.text, this.ok, {super.key});
  final String text;
  final bool ok;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(text, style: artMuted)),
      Text(
        ok ? 'PASS' : 'REVIEW',
        style: TextStyle(
          color: ok ? C.lime : C.orange,
          fontSize: AppTypeScale.tiny,
          fontWeight: FontWeight.w900,
        ),
      ),
    ],
  );
}

class ArchitectureArt extends StatelessWidget {
  const ArchitectureArt({super.key});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final nodeWidth = (box.maxWidth / 3).clamp(48.0, 68.0);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ARCHITECTURE', style: artMuted),
          const Spacer(),
          Row(
            children: [
              Node(Icons.phone_android_rounded, 'Flutter', width: nodeWidth),
              Expanded(child: Container(height: 1, color: C.blue)),
              Node(Icons.api_rounded, 'API', width: nodeWidth),
              Expanded(child: Container(height: 1, color: C.blue)),
              Node(Icons.storage_rounded, 'Data', width: nodeWidth),
            ],
          ),
          const Spacer(),
        ],
      );
    },
  );
}

class ArtPanel extends StatelessWidget {
  const ArtPanel({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: C.ink.withValues(alpha: .72),
      border: Border.all(color: C.line),
      borderRadius: BorderRadius.circular(5),
    ),
    child: child,
  );
}

class Node extends StatelessWidget {
  const Node(this.icon, this.text, {super.key, this.width = 68});
  final IconData icon;
  final String text;
  final double width;
  @override
  Widget build(BuildContext context) => Container(
    width: width,
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: C.ink,
      border: Border.all(color: C.line),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      children: [
        Icon(icon, color: C.lime, size: 19),
        const SizedBox(height: 7),
        Text(
          text,
          style: const TextStyle(
            fontSize: AppTypeScale.micro,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class Tag extends StatelessWidget {
  const Tag(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: C.line),
      borderRadius: BorderRadius.circular(3),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: C.muted,
        fontSize: AppTypeScale.label,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({super.key});
  static const data = [
    (
      '01',
      'Product Engineering',
      'From requirements and user flows to production-ready mobile and web experiences.',
      'Flutter · Web · UX Flow · State Management',
    ),
    (
      '02',
      'Backend & APIs',
      'Clear domain logic, secure APIs, data validation, integrations, and maintainable architecture.',
      'Laravel · REST · Auth · SQL · Business Rules',
    ),
    (
      '03',
      'Data Engineering',
      'Cleaning, matching, validating, and transforming operational datasets into decision-ready information.',
      'Power Query · SQL · Data Quality · ETL',
    ),
    (
      '04',
      'AI & Automation',
      'Applying AI where it improves detection, explanation, prioritization, and operational efficiency.',
      'Agents · Rule Engines · Confidence Scoring',
    ),
    (
      '05',
      'System Architecture',
      'Designing boundaries, data flows, integration patterns, security, observability, and scale.',
      'Architecture · Events · Caching · RBAC',
    ),
    (
      '06',
      'Technology Strategy',
      'Connecting engineering investment with productivity, risk reduction, customer value, and growth.',
      'Roadmaps · Governance · KPI · Business Impact',
    ),
  ];
  @override
  Widget build(BuildContext context) => Container(
    color: C.panel.withValues(alpha: .75),
    padding: EdgeInsets.symmetric(vertical: context.sectionSpace),
    child: Shell(
      child: Column(
        children: [
          const SectionHead(
            '02',
            'EXPERTISE',
            'More than a stack. A complete problem-solving system.',
            'The goal is not to collect technologies. It is to understand the problem, design the right system, build it reliably, and connect the outcome to business value.',
          ),
          const SizedBox(height: 52),
          LayoutBuilder(
            builder: (context, box) {
              final columns = context.screenWidth >= AppBreakpoints.medium
                  ? 3
                  : (context.screenWidth > AppBreakpoints.compact ? 2 : 1);
              final width = (box.maxWidth - (columns - 1)) / columns;
              return Wrap(
                spacing: 1,
                runSpacing: 1,
                children: [
                  for (final e in data)
                    SizedBox(width: width, child: ExpertiseCard(e)),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}

class ExpertiseCard extends StatelessWidget {
  const ExpertiseCard(this.data, {super.key});
  final (String, String, String, String) data;
  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 250),
    padding: const EdgeInsets.all(27),
    decoration: BoxDecoration(
      color: C.panel2,
      border: Border.all(color: C.line, width: .6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.$1,
          style: const TextStyle(color: C.lime, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 23),
        Text(
          data.$2,
          style: const TextStyle(
            fontSize: AppTypeScale.title,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.$3,
          style: const TextStyle(
            color: C.muted,
            height: 1.55,
            fontSize: AppTypeScale.bodySmall,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          data.$4,
          style: const TextStyle(
            fontSize: AppTypeScale.caption,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class JourneySection extends StatelessWidget {
  const JourneySection({super.key});
  static const data = [
    (
      'NOW',
      'Full-Stack Developer',
      'Ship reliable products, understand operations deeply, and strengthen engineering fundamentals.',
    ),
    (
      'NEXT',
      'Senior / Tech Lead',
      'Own architecture decisions, improve team delivery, mentor engineers, and reduce technical risk.',
    ),
    (
      'LEADERSHIP',
      'Head / CTO / CIO',
      'Shape platforms, teams, governance, technology strategy, budgets, and measurable transformation.',
    ),
    (
      'EXECUTIVE',
      'Director / CEO / Board',
      'Connect technology, people, capital, risk, product, and market opportunity into long-term enterprise value.',
    ),
  ];
  @override
  Widget build(BuildContext context) => Shell(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionSpace),
      child: Column(
        children: [
          const SectionHead(
            '03',
            'CAREER JOURNEY',
            'Building toward technology leadership.',
            'The portfolio is designed to evolve as responsibilities grow — from hands-on engineering to architecture, leadership, business ownership, and executive decision-making.',
          ),
          const SizedBox(height: 58),
          LayoutBuilder(
            builder: (context, box) {
              final desktop = context.screenWidth > AppBreakpoints.medium;
              if (desktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final e in data.indexed) ...[
                      Expanded(child: JourneyItem(e.$2, active: e.$1 == 0)),
                      if (e.$1 < data.length - 1)
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Divider(color: C.line),
                          ),
                        ),
                    ],
                  ],
                );
              }

              final columns = context.screenWidth > AppBreakpoints.compact
                  ? 2
                  : 1;
              const gap = AppSpace.lg;
              final itemWidth = (box.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                children: [
                  for (final e in data.indexed)
                    SizedBox(
                      width: itemWidth,
                      child: JourneyItem(
                        e.$2,
                        active: e.$1 == 0,
                        vertical: true,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}

class JourneyItem extends StatelessWidget {
  const JourneyItem(
    this.data, {
    super.key,
    required this.active,
    this.vertical = false,
  });
  final (String, String, String) data;
  final bool active;
  final bool vertical;
  Widget get dot => Container(
    width: 15,
    height: 15,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: active ? C.lime : C.ink,
      border: Border.all(color: active ? C.lime : C.muted),
    ),
  );
  @override
  Widget build(BuildContext context) => Padding(
    padding: vertical ? const EdgeInsets.only(bottom: 34) : EdgeInsets.zero,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vertical) ...[dot, const SizedBox(width: 20)],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!vertical) ...[dot, const SizedBox(height: 22)],
              Text(
                data.$1,
                style: TextStyle(
                  color: active ? C.lime : C.muted,
                  fontSize: AppTypeScale.label,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data.$2,
                style: const TextStyle(
                  fontSize: AppTypeScale.lead,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data.$3,
                style: const TextStyle(
                  color: C.muted,
                  height: 1.5,
                  fontSize: AppTypeScale.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) => Container(
    color: C.lightSurface,
    padding: EdgeInsets.symmetric(vertical: context.sectionSpace),
    child: Shell(
      child: LayoutBuilder(
        builder: (context, box) {
          final desktop = box.maxWidth >= AppBreakpoints.splitContent;
          final title = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Eyebrow('04 — ABOUT', dark: true),
              SizedBox(height: 20),
              Text(
                'I build at the intersection of operations, engineering, and business.',
                style: AppFonts.heading(
                  TextStyle(
                    color: C.ink,
                    fontSize: AppTypeScale.sectionTitle(context.screenWidth),
                    height: 1.04,
                    letterSpacing: -1.3,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          );
          const copy = AboutCopy();
          return desktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: title),
                    const SizedBox(width: 90),
                    const Expanded(child: copy),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [title, const SizedBox(height: 42), copy],
                );
        },
      ),
    ),
  );
}

class AboutCopy extends StatelessWidget {
  const AboutCopy({super.key});
  @override
  Widget build(BuildContext context) => const DefaultTextStyle(
    style: TextStyle(
      color: C.lightText,
      fontSize: AppTypeScale.bodyLarge,
      height: 1.65,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My focus is building technology that solves real operational problems — not technology for its own sake.',
          style: TextStyle(
            color: C.ink,
            fontSize: AppTypeScale.title,
            height: 1.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'I approach projects by understanding the workflow first, translating that workflow into clear product and system decisions, then implementing the solution with maintainability, data integrity, and user impact in mind.',
        ),
        SizedBox(height: 20),
        Text(
          'Over time, my goal is to expand from hands-on software engineering into architecture, product strategy, technology leadership, and executive responsibility.',
        ),
        SizedBox(height: 28),
        Principle('01', 'Understand the business before the code.'),
        Principle('02', 'Design systems for clarity, auditability, and scale.'),
        Principle('03', 'Measure outcomes, not just features shipped.'),
      ],
    ),
  );
}

class Principle extends StatelessWidget {
  const Principle(this.number, this.text, {super.key});
  final String number;
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 15),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: C.lightLine)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 38,
          child: Text(
            number,
            style: const TextStyle(
              color: C.darkGreen,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: C.ink, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}

class LeadershipSection extends StatelessWidget {
  const LeadershipSection({super.key});
  static const data = [
    (
      'ENGINEERING',
      'Reliability, performance, architecture, maintainability, delivery discipline.',
    ),
    (
      'PEOPLE',
      'Communication, mentoring, alignment, ownership, decision clarity.',
    ),
    (
      'BUSINESS',
      'Impact, risk, cost, efficiency, user value, growth opportunities.',
    ),
  ];
  @override
  Widget build(BuildContext context) => Shell(
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsive(
          compact: 72.0,
          medium: 84.0,
          expanded: 92.0,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(
          context.responsive(compact: 26.0, medium: 40.0, expanded: 48.0),
        ),
        decoration: BoxDecoration(
          gradient: AppGradients.leadership,
          border: Border.all(color: C.line),
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Eyebrow('05 — LEADERSHIP MINDSET'),
            const SizedBox(height: 18),
            Text(
              'From building features to building capability.',
              style: AppFonts.heading(
                TextStyle(
                  fontSize: AppTypeScale.sectionTitle(context.screenWidth),
                  height: 1.04,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
            ),
            const SizedBox(height: 38),
            LayoutBuilder(
              builder: (context, box) => box.maxWidth < AppBreakpoints.medium
                  ? Column(children: [for (final e in data) LeadershipItem(e)])
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final e in data)
                          Expanded(child: LeadershipItem(e)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}

class LeadershipItem extends StatelessWidget {
  const LeadershipItem(this.data, {super.key});
  final (String, String) data;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 25, bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.$1,
          style: const TextStyle(
            color: C.lime,
            fontSize: AppTypeScale.label,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 11),
        Text(
          data.$2,
          style: const TextStyle(
            color: C.muted,
            height: 1.55,
            fontSize: AppTypeScale.bodySmall,
          ),
        ),
      ],
    ),
  );
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.onNotice});
  final ValueChanged<String> onNotice;
  @override
  Widget build(BuildContext context) => Shell(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 104),
      child: Container(
        color: C.lime,
        padding: EdgeInsets.all(
          context.responsive(compact: 28.0, medium: 40.0, expanded: 52.0),
        ),
        child: LayoutBuilder(
          builder: (context, box) {
            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '06 — CONTACT',
                  style: TextStyle(
                    color: C.ink,
                    fontSize: AppTypeScale.caption,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Open to the next serious technology challenge.',
                  style: AppFonts.heading(
                    TextStyle(
                      color: C.ink,
                      fontSize: AppTypeScale.sectionTitle(context.screenWidth),
                      height: 1.04,
                      letterSpacing: -1.2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'For software engineering, architecture, digital transformation, data, or technology leadership opportunities.',
                  style: const TextStyle(color: C.darkAccentText, height: 1.5),
                ),
              ],
            );
            final actions = Wrap(
              spacing: 9,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      const ClipboardData(text: AppConfig.email),
                    );
                    onNotice(
                      'Email placeholder copied. Replace it in the portfolio contact settings.',
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: C.ink,
                    foregroundColor: C.white,
                  ),
                  child: const Text('Email me'),
                ),
                ContactLink(
                  'LinkedIn ↗',
                  () => onNotice(
                    'Add your LinkedIn URL in the contact settings.',
                  ),
                ),
                ContactLink(
                  'GitHub ↗',
                  () =>
                      onNotice('Add your GitHub URL in the contact settings.'),
                ),
              ],
            );
            return box.maxWidth >= AppBreakpoints.medium
                ? Row(
                    children: [
                      Expanded(flex: 3, child: copy),
                      const SizedBox(width: 44),
                      Expanded(flex: 2, child: actions),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [copy, const SizedBox(height: 30), actions],
                  );
          },
        ),
      ),
    ),
  );
}

class ContactLink extends StatelessWidget {
  const ContactLink(this.text, this.onTap, {super.key});
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
      foregroundColor: C.ink,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 16),
    ),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
  );
}

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 30),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: C.line)),
    ),
    child: const Shell(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 30,
        runSpacing: 12,
        children: [
          Text(
            'ARIO SUTRISNO  ·  TECHNOLOGY · DATA · AI · BUSINESS',
            style: TextStyle(
              fontSize: AppTypeScale.caption,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Designed as a long-term technology leadership portfolio.',
            style: TextStyle(color: C.muted, fontSize: AppTypeScale.caption),
          ),
        ],
      ),
    ),
  );
}
