import 'dart:convert';

class ApiResponse {
  final dynamic details;
  final int? statusCode;
  final String? message;

  ApiResponse({this.details, this.statusCode, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      details: json['details'],
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }

  MessageDetails? getMessageDetails() {
    if (message == null) return null;
    var decodedMessage = jsonDecode(message!);
    return MessageDetails.fromJson(decodedMessage['error']);
  }
}

class MessageDetails {
  final int? code;
  final ErrorMessage? message;

  MessageDetails({this.code, this.message});

  factory MessageDetails.fromJson(Map<String, dynamic> json) {
    return MessageDetails(
      code: json['code'],
      message: ErrorMessage.fromJson(json['message']),
    );
  }
}

class ErrorMessage {
  final String? lang;
  final String? value;

  ErrorMessage({this.lang, this.value});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      lang: json['lang'],
      value: json['value'],
    );
  }
}
