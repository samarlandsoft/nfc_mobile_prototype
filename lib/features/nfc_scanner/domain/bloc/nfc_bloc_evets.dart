import 'package:nfc_manager/nfc_manager.dart';

abstract class NFCBlocEvent {
  const NFCBlocEvent([List props = const []]) : super();
}

class NFCReadChipEvent extends NFCBlocEvent {
  final Ndef? ndef;

  NFCReadChipEvent({required this.ndef}) : super([ndef]);
}