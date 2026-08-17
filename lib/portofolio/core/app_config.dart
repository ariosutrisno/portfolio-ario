import 'bio_config.dart';

/// Global application metadata and external destinations.
///
/// Personal information lives in [BioConfig].
abstract final class AppConfig {
  static const name = BioConfig.name;
  static const workplace = 'Garuda Indonesia';
  static const appTitle = '$name — Full-Stack Developer · Mobile & Web';
  static const publicRole = 'Developer · System Analyst · Aviation Operations';
  static const email = BioConfig.email;
  static const linkedInUrl = ' https://id.linkedin.com/in/ario-sutrisno';
  static const githubUrl = 'https://github.com/ariosutrisno';
}
