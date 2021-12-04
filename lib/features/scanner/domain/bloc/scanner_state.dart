import 'package:nfc_mobile_prototype/features/scanner/domain/models/nfc_token.dart';

class ScannerBlocState {
  final NFCToken? token;

  const ScannerBlocState({
    this.token,
  });

  ScannerBlocState update({NFCToken? token}) {
    return ScannerBlocState(
      token: token ?? this.token,
    );
  }
}
