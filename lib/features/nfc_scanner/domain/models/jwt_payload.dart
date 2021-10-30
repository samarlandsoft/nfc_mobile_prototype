class JWTPayloadModel {
  final String tokenID;
  final String data;

  const JWTPayloadModel({
    required this.tokenID,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'tokenID': tokenID,
      'data': data,
    };
  }
}
