import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  final dynamic result;
  final List<String>? errorMessages;
  final bool isSuccess;

  BaseResponse({this.result, this.errorMessages, required this.isSuccess});

  factory BaseResponse.fromJson(Map<String, dynamic>? _json) {

    dynamic result = _json?['result'];
    if (result is String && result.startsWith('{') && result.endsWith('}'))
      result = json.decode(result);

    return BaseResponse(

      result: result,  // _json?['result']==null ? null : _json?['result'] is String ? json.decode(_json?['result']) : _json?['result'],
      errorMessages: _json?['errorsMessage'] != null
          ? List<String>.from(_json?['errorsMessage'])
          : null,
      isSuccess: _json?['isSuccess'] ?? false,
    );
  }
}
