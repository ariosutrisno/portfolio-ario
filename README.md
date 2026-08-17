# Ario Portfolio

Responsive Flutter portfolio for mobile, desktop, and web. The global visual
foundation is translated from the original `styles.css`, while interaction
timings and reduced-motion behavior follow `script.js` and its CSS companion.

## Global architecture

All reusable settings and helpers live under `lib/portofolio/core`:

- `theme/app_colors.dart`: every source CSS color, including translucent values.
- `theme/app_typography.dart`: DM Sans, Manrope, fallback fonts, and fluid sizes.
- `theme/app_effects.dart`: gradients and shadows.
- `theme/app_tokens.dart`: spacing, radius, and motion constants.
- `theme/app_theme.dart`: the Material theme consumed by the entire app.
- `responsive/`: breakpoints, layout formulas, and `BuildContext` helpers.
- `accessibility/`: reduced-motion handling.
- `input/`: touch, mouse, stylus, and trackpad scrolling.
- `widgets/`: shared widgets such as the globally responsive content shell.

`core/design_system.dart` is the public barrel. Feature code imports that one
file rather than knowing the internal folder structure.

## Code order convention

Every Dart file follows this order so additions remain easy to track:

1. SDK and package imports, followed by project imports.
2. Classes, enums, extensions, and immutable data models.
3. Top-level functions only when a function does not belong to a class.

Feature-specific widgets remain inside their feature. A helper used by more
than one feature must be promoted to the appropriate `core` folder first.

## Responsive coverage

The responsive system uses logical width instead of device names, so the same
rules apply across Android, iOS, Windows, macOS, Linux, and browsers. Automated
widget tests exercise widths from 240 px through 3440 px, portrait/landscape,
mobile navigation, scrolling, dialogs, and enlarged text.

Run validation with:

```sh
flutter analyze
flutter test
```

### Multiplatform app icon

The browser favicon and native launcher icons use initials read from
`BioConfig.name`. After changing the configured name, regenerate every static
platform icon with:

```powershell
powershell -ExecutionPolicy Bypass -File tool/generate_app_icons.ps1
```

The generator creates flat navy-and-white icons for web, Android, iOS, Linux,
macOS, and Windows. It does not build the application.

## Portfolio content

The public story intentionally separates demonstrated work from learning
explorations:

- Selected projects: FSMS — FOO Station Management System and Digital Ramp
  Checklist.
- Concept studies: Aviation Data Quality & AI Review and Enterprise
  Integration Architecture. These pages are explicitly labelled as learning
  exercises, not deployed Garuda Indonesia products.
- Resume: a responsive Flutter page with current tools, frameworks, project
  context, AI-assisted workflow, and soft-skill growth areas.

Personal claims are deliberately conservative. The portfolio states that Codex
is used extensively and avoids confidential company data, invented outcomes,
or unsupported job-title claims.
