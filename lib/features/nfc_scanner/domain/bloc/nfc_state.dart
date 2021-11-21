import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/nfc_token.dart';

class NFCBlocState {
  final NFCToken? token;

  const NFCBlocState({
    this.token,
  });

  NFCBlocState update({NFCToken? token}) {
    return NFCBlocState(
      token: token ?? this.token,
    );
  }
}
