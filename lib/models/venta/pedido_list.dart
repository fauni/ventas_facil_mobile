// To parse this JSON data, do
//
//     final pedidoList = pedidoListFromJson(jsonString);

import 'dart:convert';

import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/venta/persona_contacto.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';

PedidoList pedidoListFromJson(String str) =>
    PedidoList.fromJson(json.decode(str));

String pedidoListToJson(PedidoList data) => json.encode(data.toJson());

class PedidoList {
  final int? id;
  final int? codigoSap;
  final int? numeroDocumento;
  final String? tipoDocumento;
  final DateTime? fechaDeEntrega;
  final DateTime? fechaDelDocumento;
  final String? codigoCliente;
  final String? nombreCliente;
  SocioNegocio? cliente;
  final int? codigoPersonaDeContacto;
  final PersonaContacto? contacto;
  final String? moneda;
  final String? comentarios;
  final int? codigoEmpleadoDeVentas;
  final EmpleadoVenta? empleado;
  final String? nombreFactura;
  final String? nitFactura;
  final String? estado;
  final String? estadoCancelado;
  final double? descuento;
  final double? impuesto;
  final double? total;
  final List<LinesOrder>? linesOrder;
  final String? usuarioVentaFacil;
  final String? latitud;
  final String? longitud;
  final DateTime? fechaRegistroApp;
  final DateTime? horaRegistroApp;

  PedidoList({
    this.id,
    this.codigoSap,
    this.numeroDocumento,
    this.tipoDocumento,
    this.fechaDeEntrega,
    this.fechaDelDocumento,
    this.codigoCliente,
    this.nombreCliente,
    this.cliente,
    this.codigoPersonaDeContacto,
    this.contacto,
    this.moneda,
    this.comentarios,
    this.codigoEmpleadoDeVentas,
    this.empleado,
    this.nombreFactura,
    this.nitFactura,
    this.estado,
    this.estadoCancelado,
    this.descuento,
    this.impuesto,
    this.total,
    this.linesOrder,
    this.usuarioVentaFacil,
    this.latitud,
    this.longitud,
    this.fechaRegistroApp,
    this.horaRegistroApp,
  });

  double get totalAntesDelDescuento {
    double totalADTemp = 0;
    for (var element in linesOrder!) {
      totalADTemp += element.total!;
    }
    return totalADTemp;
  }

  double get totalDescuento {
    double totalAD = 0;
    for (var element in linesOrder!) {
      var precioDescuento = element.total! * element.descuento! / 100;
      totalAD += precioDescuento;
    }
    return totalAD;
  }

  double get totalDespuesDelDescuento {
    return totalAntesDelDescuento - totalDescuento;
  }

  PedidoList copyWith({
    int? id,
    int? codigoSap,
    int? numeroDocumento,
    String? tipoDocumento,
    DateTime? fechaDeEntrega,
    DateTime? fechaDelDocumento,
    String? codigoCliente,
    String? nombreCliente,
    SocioNegocio? cliente,
    int? codigoPersonaDeContacto,
    PersonaContacto? contacto,
    String? moneda,
    String? comentarios,
    int? codigoEmpleadoDeVentas,
    EmpleadoVenta? empleado,
    String? nombreFactura,
    String? nitFactura,
    String? estado,
    String? estadoCancelado,
    double? descuento,
    double? impuesto,
    double? total,
    List<LinesOrder>? linesOrder,
    String? usuarioVentaFacil,
    String? latitud,
    String? longitud,
    DateTime? fechaRegistroApp,
    DateTime? horaRegistroApp,
  }) =>
      PedidoList(
        id: id ?? this.id,
        codigoSap: codigoSap ?? this.codigoSap,
        numeroDocumento: numeroDocumento ?? this.numeroDocumento,
        tipoDocumento: tipoDocumento ?? this.tipoDocumento,
        fechaDeEntrega: fechaDeEntrega ?? this.fechaDeEntrega,
        fechaDelDocumento: fechaDelDocumento ?? this.fechaDelDocumento,
        codigoCliente: codigoCliente ?? this.codigoCliente,
        nombreCliente: nombreCliente ?? this.nombreCliente,
        cliente: cliente ?? this.cliente,
        codigoPersonaDeContacto:
            codigoPersonaDeContacto ?? this.codigoPersonaDeContacto,
        contacto: contacto ?? this.contacto,
        moneda: moneda ?? this.moneda,
        comentarios: comentarios ?? this.comentarios,
        codigoEmpleadoDeVentas:
            codigoEmpleadoDeVentas ?? this.codigoEmpleadoDeVentas,
        empleado: empleado ?? this.empleado,
        nombreFactura: nombreFactura ?? this.nombreFactura,
        nitFactura: nitFactura ?? this.nitFactura,
        estado: estado ?? this.estado,
        estadoCancelado: estadoCancelado ?? this.estadoCancelado,
        descuento: descuento ?? this.descuento,
        impuesto: impuesto ?? this.impuesto,
        total: total ?? this.total,
        linesOrder: linesOrder ?? this.linesOrder,
        usuarioVentaFacil: usuarioVentaFacil ?? this.usuarioVentaFacil,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
        fechaRegistroApp: fechaRegistroApp ?? this.fechaRegistroApp,
        horaRegistroApp: horaRegistroApp ?? this.horaRegistroApp,
      );

  factory PedidoList.fromJson(Map<String, dynamic> json) => PedidoList(
        id: json["id"],
        codigoSap: json["codigoSap"],
        numeroDocumento: json["numeroDocumento"],
        tipoDocumento: json["tipoDocumento"],
        fechaDeEntrega: json["fechaDeEntrega"] == null
            ? null
            : DateTime.parse(json["fechaDeEntrega"]),
        fechaDelDocumento: json["fechaDelDocumento"] == null
            ? null
            : DateTime.parse(json["fechaDelDocumento"]),
        codigoCliente: json["codigoCliente"],
        nombreCliente: json["nombreCliente"],
        cliente: json["cliente"] == null
            ? null
            : SocioNegocio.fromJson(json["cliente"]),
        codigoPersonaDeContacto: json["codigoPersonaDeContacto"],
        contacto: json["contacto"] == null
            ? null
            : PersonaContacto.fromJson(json["contacto"]),
        moneda: json["moneda"],
        comentarios: json["comentarios"],
        codigoEmpleadoDeVentas: json["codigoEmpleadoDeVentas"],
        empleado: json["empleado"] == null
            ? null
            : EmpleadoVenta.fromJson(json["empleado"]),
        nombreFactura: json["nombreFactura"],
        nitFactura: json["nitFactura"],
        estado: json["estado"],
        estadoCancelado: json["estadoCancelado"],
        descuento: json["descuento"]?.toDouble(),
        impuesto: json["impuesto"]?.toDouble(),
        total: json["total"]?.toDouble(),
        linesOrder: json["linesOrder"] == null
            ? []
            : List<LinesOrder>.from(
                json["linesOrder"]!.map((x) => LinesOrder.fromJson(x))),
        usuarioVentaFacil: json["usuarioVentaFacil"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        fechaRegistroApp: json["fechaRegistroApp"] == null
            ? null
            : DateTime.parse(json["fechaRegistroApp"]),
        horaRegistroApp: json["horaRegistroApp"] == null
            ? null
            : DateTime.parse(json["horaRegistroApp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigoSap": codigoSap,
        "numeroDocumento": numeroDocumento,
        "tipoDocumento": tipoDocumento,
        "fechaDeEntrega": fechaDeEntrega?.toIso8601String(),
        "fechaDelDocumento": fechaDelDocumento?.toIso8601String(),
        "codigoCliente": codigoCliente,
        "nombreCliente": nombreCliente,
        "cliente": cliente,
        "codigoPersonaDeContacto": codigoPersonaDeContacto,
        "contacto": contacto,
        "moneda": moneda,
        "comentarios": comentarios,
        "codigoEmpleadoDeVentas": codigoEmpleadoDeVentas,
        "empleado": empleado,
        "nombreFactura": nombreFactura,
        "nitFactura": nitFactura,
        "estado": estado,
        "estadoCancelado": estadoCancelado,
        "descuento": descuento,
        "impuesto": impuesto,
        "total": total,
        "linesOrder": linesOrder == null
            ? []
            : List<dynamic>.from(linesOrder!.map((x) => x.toJson())),
        "usuarioVentaFacil": usuarioVentaFacil,
        "latitud": latitud,
        "longitud": longitud,
        "fechaRegistroApp": fechaRegistroApp?.toIso8601String(),
        "horaRegistroApp": horaRegistroApp?.toIso8601String(),
      };
}

class LinesOrder {
  final int? numeroDeLinea;
  final String? codigo;
  final String? descripcion;
  final String? descripcionAdicional;
  final double? cantidad;
  final double? precioUnitario;
  final double? precioDespuesImpuestos;
  final String? moneda;
  final double? descuento;
  final double? totalLinea;
  final String? codigoDeAlmacen;
  final String? unidadDeMedida;
  final int? codigoUnidadMedida;
  final String? estadoLinea;
  final DateTime? fechaDeEntrega;

  LinesOrder({
    this.numeroDeLinea,
    this.codigo,
    this.descripcion,
    this.descripcionAdicional,
    this.cantidad,
    this.precioUnitario,
    this.precioDespuesImpuestos,
    this.moneda,
    this.descuento,
    this.totalLinea,
    this.codigoDeAlmacen,
    this.unidadDeMedida,
    this.codigoUnidadMedida,
    this.estadoLinea,
    this.fechaDeEntrega
  });

  double? get total => cantidad != null && precioUnitario != null
      ? cantidad! * precioUnitario!
      : null;
  double? get precioConIVA => total != null ? total! - total! * 0.13 : null;
  double? get precioConDescuento =>
      total != null ? total! - total! * descuento! / 100 : null;

  LinesOrder copyWith({
    int? numeroDeLinea,
    String? codigo,
    String? descripcion,
    String? descripcionAdicional,
    double? cantidad,
    double? precioUnitario,
    double? precioDespuesImpuestos,
    String? moneda,
    double? descuento,
    double? totalLinea,
    String? codigoDeAlmacen,
    String? unidadDeMedida,
    int? codigoUnidadMedida,
    String? estadoLinea,
    DateTime? fechaDeEntrega
  }) =>
      LinesOrder(
        numeroDeLinea: numeroDeLinea ?? this.numeroDeLinea,
        codigo: codigo ?? this.codigo,
        descripcion: descripcion ?? this.descripcion,
        descripcionAdicional: descripcionAdicional ?? this.descripcionAdicional,
        cantidad: cantidad ?? this.cantidad,
        precioUnitario: precioUnitario ?? this.precioUnitario,
        precioDespuesImpuestos:
            precioDespuesImpuestos ?? this.precioDespuesImpuestos,
        moneda: moneda ?? this.moneda,
        descuento: descuento ?? this.descuento,
        totalLinea: totalLinea ?? this.totalLinea,
        codigoDeAlmacen: codigoDeAlmacen ?? this.codigoDeAlmacen,
        unidadDeMedida: unidadDeMedida ?? this.unidadDeMedida,
        codigoUnidadMedida: codigoUnidadMedida ?? this.codigoUnidadMedida,
        estadoLinea: estadoLinea ?? this.estadoLinea,
        fechaDeEntrega: fechaDeEntrega ?? this.fechaDeEntrega
      );

  factory LinesOrder.fromJson(Map<String, dynamic> json) => LinesOrder(
        numeroDeLinea: json["numeroDeLinea"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        descripcionAdicional: json["descripcionAdicional"],
        cantidad: json["cantidad"]?.toDouble(),
        precioUnitario: json["precioUnitario"]?.toDouble(),
        precioDespuesImpuestos: json["precioDespuesImpuestos"]?.toDouble(),
        moneda: json["moneda"],
        descuento: json["descuento"]?.toDouble(),
        totalLinea: json["totalLinea"]?.toDouble(),
        codigoDeAlmacen: json["codigoDeAlmacen"],
        unidadDeMedida: json["unidadDeMedida"],
        codigoUnidadMedida: json["codigoUnidadMedida"],
        estadoLinea: json["estadoLinea"],
        fechaDeEntrega: json["fechaDeEntrega"] == null
            ? null
            : DateTime.parse(json["fechaDeEntrega"]),
      );

  Map<String, dynamic> toJson() => {
        "numeroDeLinea": numeroDeLinea,
        "codigo": codigo,
        "descripcion": descripcion,
        "descripcionAdicional": descripcionAdicional,
        "cantidad": cantidad,
        "precioUnitario": precioUnitario,
        "precioDespuesImpuestos": precioDespuesImpuestos,
        "moneda": moneda,
        "descuento": descuento,
        "totalLinea": totalLinea,
        "codigoDeAlmacen": codigoDeAlmacen,
        "unidadDeMedida": unidadDeMedida,
        "codigoUnidadMedida": codigoUnidadMedida,
        "estadoLinea": estadoLinea,
        "fechaDeEntrega": fechaDeEntrega
      };
}
