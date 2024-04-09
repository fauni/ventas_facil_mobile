// To parse this JSON data, do
//
//     final errorResponseApi = errorResponseApiFromJson(jsonString);

import 'dart:convert';

ErrorResponseSap errorResponseSapFromJson(String str) => ErrorResponseSap.fromJson(json.decode(str));

String errorResponseSapToJson(ErrorResponseSap data) => json.encode(data.toJson());

class ErrorResponseSap {
    final int? code;
    final String? message;

    ErrorResponseSap({
        this.code,
        this.message,
    });

    factory ErrorResponseSap.fromJson(Map<String, dynamic> json) => ErrorResponseSap(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}
