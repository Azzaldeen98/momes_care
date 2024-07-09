import 'dart:convert';

class BaseResponse {
  final dynamic result;
  final List<String>? errorMessages;
  final bool isSuccess;

  BaseResponse({this.result, this.errorMessages, required this.isSuccess});

  factory BaseResponse.fromJson(Map<String, dynamic>? _json) {
    return BaseResponse(
      result: _json?['result'] is String ? json.decode(_json?['result']) : _json?['result'],
      errorMessages: _json?['errorsMessage'] != null
          ? List<String>.from(_json?['errorsMessage'])
          : null,
      isSuccess: _json?['isSuccess'] ?? false,
    );
  }
}
