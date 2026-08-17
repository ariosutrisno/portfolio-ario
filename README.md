# Ario Portfolio

Flutter portfolio application deployed to GitHub Pages.

## Repository structure

- `portfolio/` contains the Flutter application and its platform projects.
- `.github/workflows/deploy.yml` validates, builds, and deploys the web release.

## Local development

Run the following commands from the repository root:

```sh
cd portfolio
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Create the same release bundle used by GitHub Pages with:

```sh
cd portfolio
flutter build web --release --base-href "/portfolio-ario/"
```

Pushes to `main` that change the Flutter app or deployment workflow trigger the
GitHub Pages pipeline. In the repository settings, set **Pages > Source** to
**GitHub Actions** before the first deployment.

For architecture, design-system, and content notes, see
[`portfolio/README.md`](portfolio/README.md).
