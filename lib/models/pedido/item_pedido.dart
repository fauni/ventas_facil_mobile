// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

ItemPedido itemFromJson(String str) => ItemPedido.fromJson(json.decode(str));

String itemToJson(ItemPedido data) => json.encode(data.toJson());

class ItemPedido {
  int? numeroDeLinea;
  String? codigo;
  String? descripcion;
  String? descripcionAdicional;
  double? cantidad;
  double? precioPorUnidad;
  double? descuento;
  String? indicadorDeImpuestos;
  double? unidadDeMedidaManual;
  int? codigoUnidadMedida;
  String? nombreUnidadMedida;
  DateTime? fechaDeEntrega;
  String? codigoAlmacen;
  String? codigoProveedor;
  String? nombreProveedor;
  String? codigoTfeUnidad;
  String? nombreTfeUnidad;
  // double? porcentajeDescuento;
  // double? precioTrasElDescuento;
  // String? monedaPrecio;

  ItemPedido(
      {this.numeroDeLinea,
      this.codigo,
      this.descripcion,
      this.descripcionAdicional,
      this.cantidad,
      this.precioPorUnidad,
      this.descuento,
      this.indicadorDeImpuestos,
      this.unidadDeMedidaManual,
      this.codigoUnidadMedida,
      this.nombreUnidadMedida,
      this.fechaDeEntrega,
      this.codigoAlmacen,
      this.codigoProveedor,
      this.nombreProveedor,
      this.codigoTfeUnidad,
      this.nombreTfeUnidad
  });

  double? get total => cantidad != null && precioPorUnidad != null
      ? cantidad! * precioPorUnidad!
      : null;
  double? get precioConIVA => total != null ? total! - total! * 0.13 : null;
  double? get precioConDescuento =>
      total != null ? total! - total! * descuento! / 100 : null;

  ItemPedido copyWith(
          {int? numeroDeLinea,
          String? codigo,
          String? descripcion,
          String? descripcionAdicional,
          double? cantidad,
          double? precioPorUnidad,
          double? descuento,
          String? indicadorDeImpuestos,
          double? unidadDeMedidaManual,
          int? codigoUnidadMedida,
          String? nombreUnidadMedida,
          DateTime? fechaDeEntrega,
          String? codigoAlmacen,
          String? codigoProveedor,
          String? nombreProveedor,
          String? codigoTfeUnidad,
          String? nombreTfeUnidad
          }) =>
      ItemPedido(
          numeroDeLinea: numeroDeLinea ?? this.numeroDeLinea,
          codigo: codigo ?? this.codigo,
          descripcion: descripcion ?? this.descripcion,
          descripcionAdicional:
              descripcionAdicional ?? this.descripcionAdicional,
          cantidad: cantidad ?? this.cantidad,
          precioPorUnidad: precioPorUnidad ?? this.precioPorUnidad,
          descuento: descuento ?? this.descuento,
          indicadorDeImpuestos:
              indicadorDeImpuestos ?? this.indicadorDeImpuestos,
          unidadDeMedidaManual:
              unidadDeMedidaManual ?? this.unidadDeMedidaManual,
          codigoUnidadMedida: codigoUnidadMedida ?? this.codigoUnidadMedida,
          nombreUnidadMedida: nombreUnidadMedida ?? this.nombreUnidadMedida,
          fechaDeEntrega: fechaDeEntrega ?? this.fechaDeEntrega,
          codigoAlmacen: codigoAlmacen ?? this.codigoAlmacen,
          codigoProveedor: codigoProveedor ?? this.codigoProveedor,
          nombreProveedor: nombreProveedor ?? this.nombreProveedor,
          codigoTfeUnidad: codigoTfeUnidad ?? this.codigoTfeUnidad,
          nombreTfeUnidad: nombreTfeUnidad ?? this.nombreTfeUnidad
        );

  factory ItemPedido.fromJson(Map<String, dynamic> json) => ItemPedido(
      numeroDeLinea: json["numeroDeLinea"],
      codigo: json["codigo"],
      descripcion: json["descripcion"],
      descripcionAdicional: json["descripcionAdicional"],
      cantidad: json["cantidad"]?.toDouble(),
      precioPorUnidad: json["precioPorUnidad"]?.toDouble(),
      descuento: json["descuento"]?.toDouble(),
      indicadorDeImpuestos: json["indicadorDeImpuestos"],
      unidadDeMedidaManual: json["unidadDeMedidaManual"]?.toDouble(),
      codigoUnidadMedida: json["codigoUnidadMedida"],
      nombreUnidadMedida: json["nombreUnidadMedida"],
      fechaDeEntrega: json["fechaDeEntrega"] == null ? null : DateTime.parse(json["fechaDeEntrega"]),
      codigoAlmacen: json["codigoAlmacen"],
      codigoProveedor: json["codigoProveedor"],
      nombreProveedor: json["nombreProveedor"],
      codigoTfeUnidad: json["codigoTfeUnidad"],
      nombreTfeUnidad: json["nombreTfeUnidad"]
    );

  Map<String, dynamic> toJson() => {
        "numeroDeLinea": numeroDeLinea,
        "codigo": codigo,
        "descripcion": descripcion,
        "descripcionAdicional": descripcionAdicional,
        "cantidad": cantidad,
        "precioPorUnidad": precioPorUnidad,
        "descuento": descuento,
        "indicadorDeImpuestos": indicadorDeImpuestos,
        "unidadDeMedidaManual": unidadDeMedidaManual,
        "codigoUnidadMedida": codigoUnidadMedida,
        "nombreUnidadMedida": nombreUnidadMedida,
        "fechaDeEntrega": fechaDeEntrega?.toIso8601String(),
        "codigoAlmacen": codigoAlmacen,
        "codigoProveedor": codigoProveedor,
        "nombreProveedor": nombreProveedor,
        "codigoTfeUnidad": codigoTfeUnidad,
        "nombreTfeUnidad": nombreTfeUnidad
      };
}
