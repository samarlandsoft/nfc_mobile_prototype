import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';

class NFCSweaterProps {
  final NFCSweater sweater;
  final bool fromToken;

  const NFCSweaterProps({
    required this.sweater,
    required this.fromToken,
  });
}
