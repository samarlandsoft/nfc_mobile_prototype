class JWTPayloadModel {
  final String version;
  final String tokenID;
  final String chipID;

  const JWTPayloadModel({
    this.version = '1',
    required this.tokenID,
    required this.chipID,
  });

  static JWTPayloadModel fromJson(Map<String, dynamic> json) {
    return JWTPayloadModel(
      version: json['version'] ?? 'null',
      tokenID: json['tokenID'] ?? 'null',
      chipID: json['chipID'] ?? 'null',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'tokenID': tokenID,
      'chipID': chipID,
    };
  }
}
