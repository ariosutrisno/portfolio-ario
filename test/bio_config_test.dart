import 'package:flutter_test/flutter_test.dart';

import 'package:portofolio/portofolio/core/bio_config.dart';

void main() {
  test('public bio is configured in one place', () {
    expect(BioConfig.name, 'Ario Sutrisno');
    expect(BioConfig.email, 'sutrisnoario@gmail.com');
    expect(BioConfig.location, 'Bekasi, West Java');
    expect(BioConfig.nationality, 'Indonesia');
  });

  test('header initials are generated from the configured name', () {
    expect(BioConfig.initials, 'AS');
    expect(BioConfig.initialsFor('Rio S'), 'RS');
  });
}
