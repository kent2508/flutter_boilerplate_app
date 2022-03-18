class ResponseProvider {
  ResponseProvider({required this.code, required this.message, this.data});

  factory ResponseProvider.fromJson(Map<String, dynamic> rawRes,
      {String? keyValue}) {
    final String code = rawRes['code'];
    final String message = rawRes['message'];
    final dynamic data =
        keyValue == null ? rawRes['data'] : rawRes['data'][keyValue];

    return ResponseProvider(
      code: code,
      message: message,
      data: data,
    );
  }
  // let custom for flexible your response
  final String code;
  final String message;
  final dynamic data;

  bool isSuccess() => RegExp(r'^2[0-9]{2}').hasMatch(code) && code.length == 3;
}
