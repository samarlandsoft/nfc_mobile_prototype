import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';

class NFCDataProps {
  final NFCSweater sweater;
  final bool fromToken;

  const NFCDataProps({
    required this.sweater,
    required this.fromToken,
  });
}
