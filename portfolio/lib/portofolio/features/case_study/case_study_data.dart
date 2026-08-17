class CaseStudyData {
  const CaseStudyData({
    required this.slug,
    required this.eyebrow,
    required this.title,
    required this.summary,
    required this.meta,
    required this.sections,
    required this.disclaimer,
  });

  final String slug;
  final String eyebrow;
  final String title;
  final String summary;
  final List<CaseMeta> meta;
  final List<CaseStudySection> sections;
  final String disclaimer;
}

class CaseMeta {
  const CaseMeta(this.label, this.value);

  final String label;
  final String value;
}

class CaseStudySection {
  const CaseStudySection({
    required this.index,
    required this.label,
    required this.title,
    required this.body,
    this.metrics = const [],
    this.flow = const [],
    this.decisions = const [],
  });

  final String index;
  final String label;
  final String title;
  final String body;
  final List<CaseMetric> metrics;
  final List<String> flow;
  final List<String> decisions;
}

class CaseMetric {
  const CaseMetric(this.value, this.label);

  final String value;
  final String label;
}

abstract final class CaseStudies {
  static const fsms = CaseStudyData(
    slug: 'fsms',
    eyebrow: 'AVIATION OPERATIONS · STATION WORKFLOW',
    title: 'FSMS — FOO Station Management System',
    summary:
        'A practical system concept for organizing Flight Operations Officer station workflows, operational information, and traceable records in one structured workspace.',
    meta: [
      CaseMeta('FOCUS', 'Station · Workflow · Data'),
      CaseMeta('CONTEXT', 'Garuda Indonesia exposure'),
      CaseMeta('BUILD STYLE', 'AI-assisted development'),
      CaseMeta('STATUS', 'Portfolio project'),
    ],
    disclaimer:
        'Portfolio presentation based on personal learning and operational exposure. No confidential company data is shown.',
    sections: [
      CaseStudySection(
        index: '01',
        label: 'OPERATIONAL CONTEXT',
        title:
            'Station work needs information that is structured, easy to find, and simple to follow.',
        body:
            'Operational work can involve repeated checks, changing information, and records that need to remain understandable later. FSMS explores how those activities can be organized into a clearer digital flow without exposing internal or confidential information.',
        metrics: [
          CaseMetric(
            'Station-based',
            'Designed around a local operational context',
          ),
          CaseMetric('Structured', 'Information grouped into clear workflows'),
          CaseMetric('Traceable', 'Records remain easier to review'),
        ],
      ),
      CaseStudySection(
        index: '02',
        label: 'SOLUTION DIRECTION',
        title: 'Turn scattered activities into one understandable workflow.',
        body:
            'The product direction connects station information, task progress, validation, and history. The interface prioritizes fast reading and clear status so it can support users working under operational pressure.',
        flow: [
          'Station',
          'Flight context',
          'Task workflow',
          'Validation',
          'History',
        ],
      ),
      CaseStudySection(
        index: '03',
        label: 'BUILD DECISIONS',
        title: 'Keep the first version focused and maintainable.',
        body:
            'The project is intentionally scoped around fundamentals that I can continue learning, testing, and improving.',
        decisions: [
          'Use clear role and workflow boundaries before adding advanced features.',
          'Keep operational timestamps and status changes explicit.',
          'Use MySQL or MariaDB for structured records and Laravel for backend workflows.',
          'Use Codex heavily for implementation support while reviewing behavior through tests and iteration.',
        ],
      ),
      CaseStudySection(
        index: '04',
        label: 'LEARNING VALUE',
        title: 'A real context for strengthening full-stack fundamentals.',
        body:
            'FSMS helps me practice translating an operational problem into data structures, interfaces, business rules, and maintainable code. The next goal is to improve technical independence and validate the workflow with appropriate users.',
        metrics: [
          CaseMetric('↑', 'Operational understanding'),
          CaseMetric('↑', 'Full-stack practice'),
          CaseMetric('Next', 'Validation and iteration'),
        ],
      ),
    ],
  );

  static const digitalRamp = CaseStudyData(
    slug: 'digital-ramp-checklist',
    eyebrow: 'AVIATION OPERATIONS · MOBILE CHECKLIST',
    title: 'Digital Ramp Checklist',
    summary:
        'A mobile-first checklist concept for making ramp activities clearer, faster to complete, and easier to review through structured validation and operational timestamps.',
    meta: [
      CaseMeta('FOCUS', 'Flutter · Checklist · Workflow'),
      CaseMeta('CONTEXT', 'Airline ramp operations'),
      CaseMeta('BUILD STYLE', 'AI-assisted development'),
      CaseMeta('STATUS', 'Portfolio project'),
    ],
    disclaimer:
        'Personal portfolio work inspired by operational experience. Screens and descriptions avoid confidential company procedures and data.',
    sections: [
      CaseStudySection(
        index: '01',
        label: 'BUSINESS PROBLEM',
        title:
            'Time-critical ramp activities need clarity, speed, and traceability.',
        body:
            'Ramp work contains activities that must be easy to understand and complete under real operating conditions. A useful digital checklist should reduce ambiguous states, preserve a clear record, and avoid adding unnecessary interaction.',
        metrics: [
          CaseMetric(
            'Mobile-first',
            'Designed for work close to the operation',
          ),
          CaseMetric('Time-aware', 'Operational timestamps remain explicit'),
          CaseMetric('Auditable', 'Completion history stays reviewable'),
        ],
      ),
      CaseStudySection(
        index: '02',
        label: 'SOLUTION',
        title: 'A guided checklist with business rules inside the experience.',
        body:
            'The interface presents the current flight context, required checklist items, progress, validation, and history as one controlled sequence. Touch targets and information hierarchy are designed for quick hand gestures and fast scanning.',
        flow: [
          'Assignment',
          'Flight info',
          'Checklist',
          'Validation',
          'History',
        ],
      ),
      CaseStudySection(
        index: '03',
        label: 'KEY DECISIONS',
        title: 'Decisions focused on reliable everyday use.',
        body:
            'The project combines Flutter interface work with backend and database fundamentals.',
        decisions: [
          'Keep the interface separated from services and data access.',
          'Treat operational time consistently and show status changes clearly.',
          'Prevent completion when required checklist items are still missing.',
          'Design for touch, narrow screens, enlarged text, and interrupted workflows.',
        ],
      ),
      CaseStudySection(
        index: '04',
        label: 'LEARNING VALUE',
        title: 'From operational observation to a testable mobile product.',
        body:
            'This project is evidence of how I approach a familiar operational problem: understand the workflow, create a simple digital model, build it with AI assistance, and keep testing until the interaction becomes clearer.',
        metrics: [
          CaseMetric('↓', 'Ambiguous checklist states'),
          CaseMetric('↑', 'Workflow clarity'),
          CaseMetric('↑', 'Flutter practice'),
        ],
      ),
    ],
  );

  static const dataAiConcept = CaseStudyData(
    slug: 'aviation-data-quality-concept',
    eyebrow: 'CONCEPT STUDY · DATA & AI',
    title: 'Aviation Data Quality & AI Review',
    summary:
        'A learning concept that separates deterministic validation, AI-assisted explanation, confidence scoring, and accountable human review.',
    meta: [
      CaseMeta('FOCUS', 'Data · AI · Quality'),
      CaseMeta('TYPE', 'Learning exploration'),
      CaseMeta('APPROACH', 'Rules before AI'),
      CaseMeta('STATUS', 'Concept study'),
    ],
    disclaimer:
        'This is a concept study, not a claim of a deployed Garuda Indonesia product.',
    sections: [
      CaseStudySection(
        index: '01',
        label: 'PROBLEM',
        title: 'Complete-looking data can still contain structural problems.',
        body:
            'Missing values, inconsistent routes, mismatched identifiers, duplicates, and unusual records can weaken reporting. Manual checking becomes harder as sources and records grow.',
        metrics: [
          CaseMetric('Multi-source', 'Different sources may disagree'),
          CaseMetric('Repeatable', 'Rules must produce consistent results'),
          CaseMetric('Reviewable', 'People remain responsible for decisions'),
        ],
      ),
      CaseStudySection(
        index: '02',
        label: 'CONCEPT',
        title: 'Use rules for certainty and AI for assistance.',
        body:
            'Deterministic rules handle explainable checks. AI can help summarize anomalies and suggest investigation paths, while a human decides whether a value should be accepted, corrected, or escalated.',
        flow: [
          'Sources',
          'Data pipeline',
          'Rule engine',
          'AI explanation',
          'Human review',
        ],
      ),
      CaseStudySection(
        index: '03',
        label: 'GUARDRAILS',
        title: 'AI should support judgment, not hide uncertainty.',
        body:
            'This concept is also how I want to use AI in my own development process: quickly, transparently, and with verification.',
        decisions: [
          'Keep deterministic rules for checks that must be repeatable.',
          'Show confidence and uncertainty instead of presenting guesses as facts.',
          'Preserve source lineage for every recommendation.',
          'Require human review for meaningful corrections or operational decisions.',
        ],
      ),
    ],
  );

  static const architectureConcept = CaseStudyData(
    slug: 'integration-architecture-concept',
    eyebrow: 'CONCEPT STUDY · SYSTEM ARCHITECTURE',
    title: 'Enterprise Integration Architecture',
    summary:
        'A learning blueprint for connecting mobile clients, APIs, services, data, and observability through clearer boundaries instead of fragile point-to-point integrations.',
    meta: [
      CaseMeta('FOCUS', 'Architecture · Integration'),
      CaseMeta('TYPE', 'Learning exploration'),
      CaseMeta('APPROACH', 'Simple boundaries'),
      CaseMeta('STATUS', 'Concept study'),
    ],
    disclaimer:
        'This is an architecture learning exercise, not a claim of enterprise architecture ownership at Garuda Indonesia.',
    sections: [
      CaseStudySection(
        index: '01',
        label: 'PROBLEM',
        title: 'Direct integrations become difficult to change and understand.',
        body:
            'Point-to-point connections can duplicate logic, spread security rules, and make failures harder to trace. Even a learning project benefits from clear contracts and ownership.',
        metrics: [
          CaseMetric('Boundaries', 'Separate responsibilities clearly'),
          CaseMetric('Contracts', 'Make data exchange explicit'),
          CaseMetric('Visibility', 'Design for easier investigation'),
        ],
      ),
      CaseStudySection(
        index: '02',
        label: 'REFERENCE FLOW',
        title: 'A layered platform that can evolve gradually.',
        body:
            'Clients call stable APIs, services own business behavior, data remains behind controlled interfaces, and logs make important flows easier to observe.',
        flow: [
          'Clients',
          'API gateway',
          'Services',
          'Events / data',
          'Observability',
        ],
      ),
      CaseStudySection(
        index: '03',
        label: 'LEARNING DECISIONS',
        title: 'Architecture starts with understandable fundamentals.',
        body:
            'The goal is not to claim advanced architecture experience, but to demonstrate the direction I am studying.',
        decisions: [
          'Use APIs as contracts instead of exposing database structures.',
          'Keep authentication and authorization consistent.',
          'Introduce asynchronous processing only where it solves a clear problem.',
          'Add logs and monitoring as part of the design, not as an afterthought.',
        ],
      ),
    ],
  );

  static const selected = [fsms, digitalRamp];
  static const concepts = [dataAiConcept, architectureConcept];
}
