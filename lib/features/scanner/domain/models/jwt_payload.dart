class JWTPayloadModel {
  final String tokenID;
  final String chipID;

  const JWTPayloadModel({
    required this.tokenID,
    required this.chipID,
  });

  static JWTPayloadModel fromJson(Map<String, dynamic> json) {
    return JWTPayloadModel(
      tokenID: json['tokenID'] ?? 'null',
      chipID: json['chipID'] ?? 'null',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenID': tokenID,
      'chipID': chipID,
    };
  }
}
