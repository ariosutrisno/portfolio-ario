/// The single source of truth for public personal information.
///
/// Edit the values in this file once and every portfolio surface will use the
/// updated bio. Header initials are generated automatically from [name].
abstract final class BioConfig {
  static const name = 'Ario Sutrisno';
  static const email = 'sutrisnoario@gmail.com';
  static const location = 'Bekasi, West Java';
  static const nationality = 'Indonesia';

  /// Uses the first letter of the first and last words in [name].
  ///
  /// Examples: `Ario Sutrisno` becomes `AS`, and `Rio S` becomes `RS`.
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
