class NFCResponseData {
  final bool isSuccess;
  final dynamic data;
  final String? error;

  NFCResponseData({
    required this.isSuccess,
    this.data,
    this.error,
  });
}
