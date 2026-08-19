/// The single source of truth for all public personal information and portfolio copy.
///
/// Edit the values in this file once to customize all descriptions across
/// the main portfolio, sections, and the resume.
abstract final class BioConfig {
  // --- Personal Identity ---
  static const name = 'Ario Sutrisno';
  static const email = 'sutrisnoario@gmail.com';
  static const location = 'Bekasi, West Java';
  static const nationality = 'Indonesia';
  static const roleTitle = 'Garuda Indonesia · Operational Experience · Aspiring Developer';
  static const workplace = 'Garuda Indonesia';
  static const linkedInUrl = 'https://id.linkedin.com/in/ario-sutrisno';
  static const githubUrl = 'https://github.com/ariosutrisno';

  // --- Portfolio Hero Section ---
  static const heroEyebrow = 'GARUDA INDONESIA · OPERATIONS · SOFTWARE';
  static const heroTitlePrefix = 'Turning aviation experience into ';
  static const heroTitleAccent = 'clear digital tools.';
  static const heroBio =
      'I’m Ario Sutrisno. I work at Garuda Indonesia and I’m building my path into software development through two operationally grounded projects, extensive Codex assistance, and honest continuous learning.';

  // --- Capability Band ---
  static const capabilities = <String>[
    'MICROSOFT OFFICE',
    'MYSQL / MARIADB',
    'LARAVEL',
    'FLUTTER',
    'BOOTSTRAP',
    'CODEX / AI WORKFLOW',
  ];

  // --- Contact Section ---
  static const contactEyebrow = '06 — CONTACT';
  static const contactTitle = 'Open to the next serious technology challenge.';
  static const contactSubtitle =
      'For software engineering, architecture, digital transformation, data, or technology leadership opportunities.';
  static const contactCta = 'Email me';

  // --- Resume Sections ---
  static const resumeProfileHeading = 'PROFILE';
  static const resumeProfileBody =
      'I work at Garuda Indonesia and am building my path into software development through operationally grounded projects. My current focus is learning to turn familiar workflows into clear applications using Flutter, Laravel, and relational databases.';

  static const resumeContextHeading = 'CURRENT CONTEXT';
  static const resumeContextTitle = 'Garuda Indonesia';
  static const resumeContextSubtitle = 'Current workplace · Aviation operational exposure';
  static const resumeContextBody =
      'Daily exposure to airline operations gives me practical context for identifying repetitive workflows, information gaps, and opportunities for clearer digital tools. Specific role details can be added when ready for publication.';

  static const resumeProjectsHeading = 'SELECTED PROJECTS';
  static const resumeProjects = <ResumeProjectItem>[
    ResumeProjectItem(
      title: 'FSMS — FOO Station Management System',
      subtitle: 'Laravel · MySQL/MariaDB · Bootstrap · AI-assisted',
      description:
          'A portfolio project exploring how station workflows, operational information, validation, and history can be organized into one structured system.',
    ),
    ResumeProjectItem(
      title: 'Digital Ramp Checklist',
      subtitle: 'Flutter · Workflow · Mobile UX · AI-assisted',
      description:
          'A mobile-first checklist concept focused on fast scanning, required activity validation, operational timestamps, and traceable completion history.',
    ),
  ];

  static const resumeApproachHeading = 'DEVELOPMENT APPROACH';
  static const resumeApproachBody =
      'I currently rely heavily on Codex and AI to help generate, refactor, explain, and test code. I present that honestly: AI gives me speed, while my ongoing responsibility is to understand the result, verify behavior, improve fundamentals, and become more independent over time.';

  static const resumeCareerHeading = 'CAREER DIRECTION';
  static const resumeCareerBody =
      'Operational experience → Stronger coding fundamentals → Junior / Full-stack opportunity → Reliable product engineering.';

  // --- Resume Aside / Sidebar ---
  static const resumeHardSkillsHeading = 'HARD SKILLS';
  static const resumeHardSkills = <String>['Microsoft Office', 'MySQL / MariaDB'];

  static const resumeFrameworksHeading = 'FRAMEWORKS';
  static const resumeFrameworks = <String>['Laravel', 'Flutter', 'Bootstrap'];

  static const resumeAiWorkflowHeading = 'AI WORKFLOW';
  static const resumeAiWorkflow = <String>[
    'Codex',
    'Prompting',
    'Code explanation',
    'Testing support',
  ];

  static const resumeSoftSkillsHeading = 'SOFT-SKILL GROWTH';
  static const resumeSoftSkillsBody =
      'Actively developing clearer communication, collaboration, confidence, and ownership through project work and feedback.';

  static const resumePortfolioNoteHeading = 'PORTFOLIO NOTE';
  static const resumePortfolioNoteBody =
      'First portfolio. Built iteratively with extensive AI assistance and a commitment to honest improvement.';

  static const resumeContactHeading = 'CONTACT';

  /// Uses the first letter of the first and last words in [name].
  static String get initials => initialsFor(name);

  static String initialsFor(String value) {
    final words = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList(growable: false);

    if (words.isEmpty) return '';
    if (words.length == 1) {
      final word = words.first;
      return word.substring(0, word.length >= 2 ? 2 : 1).toUpperCase();
    }

    return '${words.first[0]}${words.last[0]}'.toUpperCase();
  }
}

class ResumeProjectItem {
  const ResumeProjectItem({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  final String title;
  final String subtitle;
  final String description;
}
