import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class LicenseService {
  void init() {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['fonts'], license);
    });
  }
}