// To parse this JSON data, do
//
//     final empleadoVenta = empleadoVentaFromJson(jsonString);

import 'dart:convert';

EmpleadoVenta empleadoVentaFromJson(String str) => EmpleadoVenta.fromJson(json.decode(str));

String empleadoVentaToJson(EmpleadoVenta data) => json.encode(data.toJson());

class EmpleadoVenta {
  int? codigoEmpleado;
  String? nombreEmpleado;
  dynamic observaciones;
  String? email;

  EmpleadoVenta({
      this.codigoEmpleado,
      this.nombreEmpleado,
      this.observaciones,
      this.email,
  });

  EmpleadoVenta copyWith({
      int? codigoEmpleado,
      String? nombreEmpleado,
      dynamic observaciones,
      String? email,
  }) => 
      EmpleadoVenta(
          codigoEmpleado: codigoEmpleado ?? this.codigoEmpleado,
          nombreEmpleado: nombreEmpleado ?? this.nombreEmpleado,
          observaciones: observaciones ?? this.observaciones,
          email: email ?? this.email,
      );

  factory EmpleadoVenta.fromJson(Map<String, dynamic> json) => EmpleadoVenta(
      codigoEmpleado: json["codigoEmpleado"],
      nombreEmpleado: json["nombreEmpleado"],
      observaciones: json["observaciones"],
      email: json["email"],
  );

  Map<String, dynamic> toJson() => {
      "codigoEmpleado": codigoEmpleado,
      "nombreEmpleado": nombreEmpleado,
      "observaciones": observaciones,
      "email": email,
  };
}
