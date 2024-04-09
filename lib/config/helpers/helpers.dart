import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ventas_facil/models/errors/error_response_api.dart';
import 'package:ventas_facil/models/errors/error_response_sap.dart';


class Helper {
  BuildContext? context;
  Helper.of(BuildContext context) {
    context = context;
  }


  static ErrorResponseSap getErrorSap(Map<String, dynamic> data){
    ErrorResponseApi errorResponse = ErrorResponseApi.fromJson(data);

    String jsonString = errorResponse.message!;
    jsonString = jsonString.replaceAll('\\', '');

    Map<String, dynamic> dataMensaje = json.decode(jsonString);

    // Acceder a los datos 
    int errorCode = dataMensaje['error']['code'];
    String errorMensaje = dataMensaje['error']['message']['value'];
    final response = ErrorResponseSap(code: errorCode, message: errorMensaje);
    return response;
  }

  // static Uri getUri(String path) {
  //   String _path = Uri.parse(GlobalConfiguration().getString('base_url')).path;
  //   if (!_path.endsWith('/')) {
  //     _path += '/';
  //   }
  //   Uri uri = Uri(
  //       scheme: Uri.parse(GlobalConfiguration().getString('base_url')).scheme,
  //       host: Uri.parse(GlobalConfiguration().getString('base_url')).host,
  //       port: Uri.parse(GlobalConfiguration().getString('base_url')).port,
  //       path: _path + path);
  //   return uri;
  // }
}
