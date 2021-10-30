import 'package:nfc_manager/nfc_manager.dart';

class NFCBlocState {
  final Ndef? ndef;

  NFCBlocState({
    this.ndef,
  });

  NFCBlocState update({Ndef? ndef}) {
    return NFCBlocState(
      ndef: ndef ?? this.ndef,
    );
  }
}
