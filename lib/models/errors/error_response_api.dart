// To parse this JSON data, do
//
//     final errorResponseApi = errorResponseApiFromJson(jsonString);

import 'dart:convert';

ErrorResponseApi errorResponseApiFromJson(String str) => ErrorResponseApi.fromJson(json.decode(str));

String errorResponseApiToJson(ErrorResponseApi data) => json.encode(data.toJson());

class ErrorResponseApi {
    final dynamic details;
    final int? statusCode;
    final String? message;

    ErrorResponseApi({
        this.details,
        this.statusCode,
        this.message,
    });

    factory ErrorResponseApi.fromJson(Map<String, dynamic> json) => ErrorResponseApi(
        details: json["details"],
        statusCode: json["statusCode"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "details": details,
        "statusCode": statusCode,
        "message": message,
    };
}
