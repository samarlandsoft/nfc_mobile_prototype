import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/nfc_token.dart';

abstract class NFCBlocEvent {
  const NFCBlocEvent([List props = const []]) : super();
}

class NFCReadChipEvent extends NFCBlocEvent {
  final NFCToken? token;

  NFCReadChipEvent({required this.token}) : super([token]);
}