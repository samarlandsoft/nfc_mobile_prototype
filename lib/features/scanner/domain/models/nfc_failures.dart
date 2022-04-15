enum NFCFailureType {
  notValidChip,
  notValidNDEF,
  serviceBusy,
}

class NFCFailures {
  static const Map<NFCFailureType, String> failuresMessages = {
    NFCFailureType.notValidChip: 'This chip isn\'t valid',
    NFCFailureType.notValidNDEF: 'This chip doesn\'t support the NDEF',
    NFCFailureType.serviceBusy: 'NFC service is busy',
  };
}