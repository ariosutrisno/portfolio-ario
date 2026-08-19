import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:portofolio/portofolio/core/bio_config.dart';
import 'package:portofolio/portofolio/core/design_system.dart';
import 'package:portofolio/portofolio/features/case_study/case_study_data.dart';
import 'package:portofolio/portofolio/features/case_study/case_study_page.dart';
import 'package:portofolio/portofolio/features/resume/resume_page.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final scaffold = GlobalKey<ScaffoldState>();
  final sections = List.generate(5, (_) => GlobalKey());

  Future<void> openResume() async {
    if (scaffold.currentState?.isEndDrawerOpen ?? false) {
      Navigator.pop(context);
      await Future<void>.delayed(context.accessibleDuration(AppMotion.fast));
    }
    if (!mounted) return;
    await Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const ResumePage()));
  }

  Future<void> go(int index) async {
    // Read inherited accessibility state before a possible drawer-close await.
    final navigationDuration = context.accessibleDuration(AppMotion.navigation);
    if (scaffold.currentState?.isEndDrawerOpen ?? false) {
      Navigator.pop(context);
      await Future<void>.delayed(const Duration(milliseconds: 150));
    }
    final target = sections[index].currentContext;
    if (target != null && target.mounted) {
      await Scrollable.ensureVisible(
        target,
        duration: navigationDuration,
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
      endDrawer: MobileMenu(onNav: go, onResume: openResume),
      body: SafeArea(
        bottom: false,
        child: SelectionArea(
          child: Stack(
            children: [
              const Positioned.fill(child: Background()),
              SingleChildScrollView(
                primary: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                restorationId: 'portfolio-scroll',
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
                  onResume: openResume,
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
    color: C.headerGlass,
    child: Container(
      height: context.navigationHeight,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: C.line)),
      ),
      child: AppShell(
        child: LayoutBuilder(
          builder: (context, box) {
            final desktop = box.maxWidth >= AppBreakpoints.navigation;
            return Row(
              children: [
                AppIdentityMark(showName: box.maxWidth >= 360),
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
                    tooltip: 'Open menu',
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
                const AppIdentityMark(showName: false),
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
  Widget build(BuildContext context) => AppShell(
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
      const Eyebrow(BioConfig.heroEyebrow),
      const SizedBox(height: 22),
      Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: BioConfig.heroTitlePrefix),
            const TextSpan(
              text: BioConfig.heroTitleAccent,
              style: TextStyle(color: C.accent),
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
        BioConfig.heroBio,
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
          Proof('2 real projects', 'FSMS & Digital Ramp Checklist'),
          Proof('5 technology anchors', 'Office, SQL, Laravel, Flutter, AI'),
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
                  color: C.panel97,
                  border: Border.all(color: C.lineStrong),
                  borderRadius: BorderRadius.circular(AppRadius.hero),
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
                                  'FIRST PORTFOLIO · LEARNING IN PUBLIC',
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
                          'Observe → Build → Improve',
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
                            Expanded(child: MiniSkill('01', 'LARAVEL')),
                            SizedBox(width: 10),
                            Expanded(child: MiniSkill('02', 'FLUTTER')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Expanded(child: MiniSkill('03', 'MYSQL')),
                            SizedBox(width: 10),
                            Expanded(child: MiniSkill('04', 'CODEX')),
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
                                  'HONEST · TESTED · ITERATIVE',
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
          const Positioned(top: 48, left: 0, child: FloatTag('GARUDA CONTEXT')),
          const Positioned(
            right: -4,
            top: 100,
            child: FloatTag('2 REAL PROJECTS'),
          ),
          const Positioned(
            bottom: 50,
            left: 18,
            child: FloatTag('AI-ASSISTED'),
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
    p.color = C.accentGlow23;
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
    decoration: const BoxDecoration(color: C.lime, shape: BoxShape.circle),
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
    decoration: const BoxDecoration(
      color: C.panel2,
      border: Border.symmetric(
        horizontal: BorderSide(color: C.line),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: AppShell(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 18,
        runSpacing: 10,
        children: [
          for (final item in BioConfig.capabilities)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: item,
                    style: const TextStyle(
                      color: C.text,
                      fontSize: AppTypeScale.caption,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(
                    text: '  •',
                    style: TextStyle(
                      color: C.accent,
                      fontSize: AppTypeScale.caption,
                      fontWeight: FontWeight.w900,
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
  const Project(this.number, this.type, this.study, this.tags, this.art);
  final String number;
  final String type;
  final CaseStudyData study;
  final List<String> tags;
  final Art art;

  String get title => study.title;
  String get description => study.summary;
}

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});
  static const data = [
    Project('01', 'STATION MANAGEMENT', CaseStudies.fsms, [
      'Laravel',
      'MySQL / MariaDB',
      'Bootstrap',
      'Codex',
    ], Art.architecture),
    Project('02', 'MOBILE CHECKLIST', CaseStudies.digitalRamp, [
      'Flutter',
      'Workflow',
      'Mobile UX',
      'Codex',
    ], Art.flight),
  ];
  @override
  Widget build(BuildContext context) => AppShell(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionSpace),
      child: Column(
        children: [
          const SectionHead(
            '01',
            'SELECTED WORK',
            'Two honest projects shaped by aviation operations.',
            'These are the projects I am prepared to discuss truthfully: what I observed, what I built with extensive AI assistance, what I understand today, and what I still need to improve.',
          ),
          const SizedBox(height: 52),
          LayoutBuilder(
            builder: (context, box) {
              final columns = box.maxWidth > AppBreakpoints.medium ? 2 : 1;
              const gap = AppSpace.lg;
              final width = (box.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final p in data)
                    AppReveal(
                      child: SizedBox(width: width, child: ProjectCard(p)),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpace.huge),
          const _ConceptStudies(),
        ],
      ),
    ),
  );
}

class _ConceptStudies extends StatelessWidget {
  const _ConceptStudies();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Eyebrow('LEARNING LAB · CLEARLY LABELLED CONCEPTS'),
      const SizedBox(height: AppSpace.md),
      Text(
        'Exploring what I want to learn next.',
        style: AppFonts.heading(
          TextStyle(
            fontSize: AppTypeScale.panelTitle(context.screenWidth),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(height: AppSpace.sm),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: const Text(
          'These are study exercises, not deployed company projects. They show my direction in data, AI, and system architecture without overstating my experience.',
          style: TextStyle(color: C.muted, height: 1.6),
        ),
      ),
      const SizedBox(height: AppSpace.xl),
      LayoutBuilder(
        builder: (context, box) {
          final columns = box.maxWidth > 760 ? 2 : 1;
          const gap = AppSpace.md;
          final width = (box.maxWidth - gap * (columns - 1)) / columns;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final study in CaseStudies.concepts)
                AppReveal(
                  child: SizedBox(width: width, child: _ConceptCard(study)),
                ),
            ],
          );
        },
      ),
    ],
  );
}

class _ConceptCard extends StatelessWidget {
  const _ConceptCard(this.study);

  final CaseStudyData study;

  @override
  Widget build(BuildContext context) => Material(
    color: C.panel2,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: C.line),
      borderRadius: BorderRadius.circular(AppRadius.large),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => CaseStudyPage(study: study)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.science_outlined, color: C.accent2, size: 20),
                const SizedBox(width: AppSpace.xs),
                const Text(
                  'CONCEPT STUDY',
                  style: TextStyle(
                    color: C.accent2,
                    fontSize: AppTypeScale.label,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpace.base),
            Text(
              study.title,
              style: AppFonts.heading(
                const TextStyle(
                  fontSize: AppTypeScale.title,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.sm),
            Text(
              study.summary,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: C.muted,
                fontSize: AppTypeScale.bodySmall,
                height: 1.55,
              ),
            ),
            const SizedBox(height: AppSpace.base),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Read learning notes',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(width: AppSpace.xs),
                Icon(Icons.arrow_outward_rounded, size: 17),
              ],
            ),
          ],
        ),
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
      duration: context.accessibleDuration(AppMotion.hover),
      curve: AppMotion.standardCurve,
      decoration: BoxDecoration(
        color: hover ? C.panel2 : C.panel,
        border: Border.all(color: hover ? C.lime : C.line),
        borderRadius: BorderRadius.circular(AppRadius.card),
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
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          CaseStudyPage(study: widget.project.study),
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
    decoration: const BoxDecoration(color: C.artStart),
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

class FlightArt extends StatelessWidget {
  const FlightArt({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('AVIATION OPERATIONS', style: AppTextStyles.artMuted),
      const Spacer(),
      ArtPanel(
        child: Column(
          children: [
            const FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('FLT', style: AppTextStyles.artMuted),
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
                  Text('TURNAROUND ON TRACK', style: AppTextStyles.artMuted),
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
      const Text('DATA & AI', style: AppTextStyles.artMuted),
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
              Text('CONFIDENCE', style: AppTextStyles.artMuted),
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
      Expanded(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.artMuted,
        ),
      ),
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
      // Preserve a small connector between nodes even inside 240 px viewports.
      final nodeWidth = ((box.maxWidth - AppSpace.md) / 3).clamp(36.0, 68.0);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ARCHITECTURE', style: AppTextStyles.artMuted),
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
      color: C.headerGlass,
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
      'Hard Skills',
      'The practical tools I can honestly list today for office work and structured relational data.',
      'Microsoft Office · MySQL / MariaDB',
    ),
    (
      '02',
      'Frameworks',
      'The application frameworks I currently use to turn ideas into web and mobile prototypes.',
      'Laravel · Flutter · Bootstrap',
    ),
    (
      '03',
      'AI-Assisted Workflow',
      'I use Codex extensively to generate, explain, refactor, and test code while I strengthen my own understanding.',
      'Codex · Prompting · Code Review · Testing Support',
    ),
  ];
  @override
  Widget build(BuildContext context) => Container(
    color: C.panel75,
    padding: EdgeInsets.symmetric(vertical: context.sectionSpace),
    child: AppShell(
      child: Column(
        children: [
          const SectionHead(
            '02',
            'CURRENT TOOLKIT',
            'A focused stack, presented without exaggeration.',
            'I would rather show a small list I genuinely use than fill this portfolio with technologies I cannot yet explain. This toolkit will grow as my fundamentals and project experience grow.',
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
                    AppReveal(
                      child: SizedBox(width: width, child: ExpertiseCard(e)),
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
      'Garuda Indonesia',
      'Building strong operational context while learning how software can make familiar workflows clearer.',
    ),
    (
      'BUILDING',
      'First Portfolio',
      'Develop FSMS and Digital Ramp Checklist with Flutter, Laravel, databases, testing, and extensive Codex support.',
    ),
    (
      'NEXT',
      'Junior / Full-Stack Opportunity',
      'Join a team where I can contribute honestly, receive feedback, and improve technical independence.',
    ),
    (
      'GROWTH',
      'Reliable Product Engineer',
      'Build stronger fundamentals, clearer communication, collaboration habits, and ownership over real outcomes.',
    ),
  ];
  @override
  Widget build(BuildContext context) => AppShell(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: context.sectionSpace),
      child: Column(
        children: [
          const SectionHead(
            '03',
            'LEARNING JOURNEY',
            'Starting from operations and moving carefully into software.',
            'My direction is ambitious, but the next step is intentionally practical: understand the code I build, contribute inside a team, and become more independent through repeated real work.',
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
                      Expanded(
                        child: AppReveal(
                          child: JourneyItem(e.$2, active: e.$1 == 0),
                        ),
                      ),
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
                    AppReveal(
                      child: SizedBox(
                        width: itemWidth,
                        child: JourneyItem(
                          e.$2,
                          active: e.$1 == 0,
                          vertical: true,
                        ),
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
    child: AppShell(
      child: LayoutBuilder(
        builder: (context, box) {
          final desktop = box.maxWidth >= AppBreakpoints.splitContent;
          final title = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Eyebrow('04 — ABOUT', dark: true),
              SizedBox(height: 20),
              Text(
                'I’m bringing operational experience into my first serious software portfolio.',
                style: AppFonts.heading(
                  TextStyle(
                    color: C.darkText,
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
          'I work at Garuda Indonesia, and that environment gives me real problems to observe before I write code.',
          style: TextStyle(
            color: C.darkText,
            fontSize: AppTypeScale.title,
            height: 1.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'I currently depend heavily on Codex and AI during development. I do not want to hide that. AI helps me move from an idea to working code, while I keep learning how the structure works, how to test it, and how to identify mistakes.',
        ),
        SizedBox(height: 20),
        Text(
          'My next goal is not an inflated title. It is a real software opportunity where I can contribute, learn from stronger developers, communicate more clearly, and gradually become technically independent.',
        ),
        SizedBox(height: 28),
        Principle(
          '01',
          'Be honest about what I know and what AI helped build.',
        ),
        Principle('02', 'Understand the workflow before adding features.'),
        Principle('03', 'Test, ask for feedback, and improve continuously.'),
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
            style: const TextStyle(
              color: C.darkText,
              fontWeight: FontWeight.w700,
            ),
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
      'COMMUNICATION',
      'Learning to explain decisions in simpler language, ask clearer questions, and share progress without hiding uncertainty.',
    ),
    (
      'COLLABORATION',
      'Building confidence to receive feedback, work with different perspectives, and contribute consistently inside a team.',
    ),
    (
      'OWNERSHIP',
      'Moving from accepting AI output to understanding, testing, maintaining, and taking responsibility for the result.',
    ),
  ];
  @override
  Widget build(BuildContext context) => AppShell(
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsive(
          compact: 72.0,
          medium: 84.0,
          expanded: 92.0,
        ),
      ),
      child: AppReveal(
        child: Container(
          padding: EdgeInsets.all(
            context.responsive(compact: 26.0, medium: 40.0, expanded: 48.0),
          ),
          decoration: BoxDecoration(
            color: C.panel2,
            border: Border.all(color: C.line),
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Eyebrow('05 — SOFT-SKILL GROWTH'),
              const SizedBox(height: 18),
              Text(
                'Not zero—just skills that need deliberate practice.',
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
                    ? Column(
                        children: [for (final e in data) LeadershipItem(e)],
                      )
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
  Widget build(BuildContext context) => AppShell(
    child: Padding(
      padding: EdgeInsets.only(
        bottom: context.responsive(
          tiny: 36.0,
          compact: 44.0,
          medium: 52.0,
          expanded: 60.0,
        ),
      ),
      child: AppReveal(
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF192438),
                C.panel,
                Color(0xFF111827),
              ],
            ),
            border: Border.all(color: C.lineStrong),
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: AppShadows.card,
          ),
          padding: EdgeInsets.all(
            context.responsive(compact: 28.0, medium: 40.0, expanded: 52.0),
          ),
          child: LayoutBuilder(
            builder: (context, box) {
              final copy = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    BioConfig.contactEyebrow,
                    style: TextStyle(
                      color: C.accent,
                      fontSize: AppTypeScale.caption,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    BioConfig.contactTitle,
                    style: AppFonts.heading(
                      TextStyle(
                        color: C.text,
                        fontSize: AppTypeScale.sectionTitle(
                          context.screenWidth,
                        ),
                        height: 1.08,
                        letterSpacing: -1.2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    BioConfig.contactSubtitle,
                    style: TextStyle(
                      color: C.muted,
                      height: 1.6,
                      fontSize: AppTypeScale.body,
                    ),
                  ),
                ],
              );
              final actions = Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(
                        const ClipboardData(text: BioConfig.email),
                      );
                      onNotice('Email copied: ${BioConfig.email}');
                    },
                    icon: const Icon(Icons.mail_outline_rounded, size: 18),
                    style: FilledButton.styleFrom(
                      backgroundColor: C.accent,
                      foregroundColor: C.darkText,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                    ),
                    label: const Text(
                      BioConfig.contactCta,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  ContactLink(
                    'LinkedIn ↗',
                    () => onNotice(
                      'LinkedIn: ${BioConfig.linkedInUrl}',
                    ),
                  ),
                  ContactLink(
                    'GitHub ↗',
                    () => onNotice(
                      'GitHub: ${BioConfig.githubUrl}',
                    ),
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
                      children: [copy, const SizedBox(height: 28), actions],
                    );
            },
          ),
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
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: onTap,
    style: OutlinedButton.styleFrom(
      foregroundColor: C.text,
      side: const BorderSide(color: C.lineStrong),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      shape: const StadiumBorder(),
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
    child: AppShell(
      child: LayoutBuilder(
        builder: (context, box) {
          final identity = Text(
            key: const ValueKey('footer-identity'),
            '${BioConfig.name.toUpperCase()}  ·  TECHNOLOGY · DATA · AI · BUSINESS',
            style: const TextStyle(
              fontSize: AppTypeScale.caption,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w800,
            ),
          );
          final details = const Column(
            key: ValueKey('footer-details'),
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Designed as a long-term technology leadership portfolio.',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: C.muted,
                  fontSize: AppTypeScale.caption,
                ),
              ),
              SizedBox(height: AppSpace.xxs),
              AppCopyright(textAlign: TextAlign.right),
            ],
          );

          if (box.maxWidth >= AppBreakpoints.footer) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: identity),
                const SizedBox(width: AppSpace.xl),
                Expanded(
                  child: Align(alignment: Alignment.topRight, child: details),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              identity,
              const SizedBox(height: AppSpace.md),
              const Align(
                key: ValueKey('footer-details'),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Designed as a long-term technology leadership portfolio.',
                      style: TextStyle(
                        color: C.muted,
                        fontSize: AppTypeScale.caption,
                      ),
                    ),
                    SizedBox(height: AppSpace.xxs),
                    AppCopyright(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
