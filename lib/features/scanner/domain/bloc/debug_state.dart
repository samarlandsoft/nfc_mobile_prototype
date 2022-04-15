class DebugBlocState {
  final String? chipID;
  final String? tokenID;
  final String? md5Hash;

  const DebugBlocState({
    this.chipID,
    this.tokenID,
    this.md5Hash,
  });

  factory DebugBlocState.initial() {
    return const DebugBlocState(
      chipID: null,
      tokenID: null,
      md5Hash: null,
    );
  }

  DebugBlocState update({
    String? chipID,
    String? tokenID,
    String? md5Hash,
  }) {
    return DebugBlocState(
      chipID: chipID ?? this.chipID,
      tokenID: tokenID ?? this.tokenID,
      md5Hash: md5Hash ?? this.md5Hash,
    );
  }
}
