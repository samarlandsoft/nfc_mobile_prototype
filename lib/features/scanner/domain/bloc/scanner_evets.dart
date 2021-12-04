import 'package:nfc_mobile_prototype/features/scanner/domain/models/nfc_token.dart';

abstract class ScannerBlocEvent {
  const ScannerBlocEvent([List props = const []]) : super();
}

class ScannerReadChipEvent extends ScannerBlocEvent {
  final NFCToken? token;

  ScannerReadChipEvent({required this.token}) : super([token]);
}