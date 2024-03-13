// To parse this JSON data, do
//
//     final pedidoList = pedidoListFromJson(jsonString);

import 'dart:convert';

import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/venta/persona_contacto.dart';

PedidoList pedidoListFromJson(String str) => PedidoList.fromJson(json.decode(str));

String pedidoListToJson(PedidoList data) => json.encode(data.toJson());

class PedidoList {
    final int? id;
    final int? codigoSap;
    final String? tipoDocumento;
    final DateTime? fechaDeEntrega;
    final DateTime? fechaDelDocumento;
    final String? codigoCliente;
    final String? nombreCliente;
    final int? codigoPersonaDeContacto;
    final PersonaContacto? contacto;
    final String? moneda;
    final String? comentarios;
    final int? codigoEmpleadoDeVentas;
    final EmpleadoVenta? empleado;
    final String? nombreFactura;
    final String? nitFactura;
    final String? estado;
    final double? descuento;
    final double? impuesto;
    final double? total;
    final List<LinesOrder>? linesOrder;

    PedidoList({
        this.id,
        this.codigoSap,
        this.tipoDocumento,
        this.fechaDeEntrega,
        this.fechaDelDocumento,
        this.codigoCliente,
        this.nombreCliente,
        this.codigoPersonaDeContacto,
        this.contacto,
        this.moneda,
        this.comentarios,
        this.codigoEmpleadoDeVentas,
        this.empleado,
        this.nombreFactura,
        this.nitFactura,
        this.estado,
        this.descuento,
        this.impuesto,
        this.total,
        this.linesOrder,
    });

    double get totalAntesDelDescuento {
      return total! - impuesto!;
    }

    PedidoList copyWith({
        int? id,
        int? codigoSap,
        String? tipoDocumento,
        DateTime? fechaDeEntrega,
        DateTime? fechaDelDocumento,
        String? codigoCliente,
        String? nombreCliente,
        int? codigoPersonaDeContacto,
        PersonaContacto? contacto,
        String? moneda,
        String? comentarios,
        int? codigoEmpleadoDeVentas,
        EmpleadoVenta? empleado,
        String? nombreFactura,
        String? nitFactura,
        String? estado,
        double? descuento,
        double? impuesto,
        double? total,
        List<LinesOrder>? linesOrder,
    }) => 
        PedidoList(
            id: id ?? this.id,
            codigoSap: codigoSap ?? this.codigoSap,
            tipoDocumento: tipoDocumento ?? this.tipoDocumento,
            fechaDeEntrega: fechaDeEntrega ?? this.fechaDeEntrega,
            fechaDelDocumento: fechaDelDocumento ?? this.fechaDelDocumento,
            codigoCliente: codigoCliente ?? this.codigoCliente,
            nombreCliente: nombreCliente ?? this.nombreCliente,
            codigoPersonaDeContacto: codigoPersonaDeContacto ?? this.codigoPersonaDeContacto,
            contacto:  contacto ?? this.contacto,
            moneda: moneda ?? this.moneda,
            comentarios: comentarios ?? this.comentarios,
            codigoEmpleadoDeVentas: codigoEmpleadoDeVentas ?? this.codigoEmpleadoDeVentas,
            empleado: empleado ?? this.empleado,
            nombreFactura: nombreFactura ?? this.nombreFactura,
            nitFactura: nitFactura ?? this.nitFactura,
            estado: estado ?? this.estado,
            descuento: descuento ?? this.descuento,
            impuesto: impuesto ?? this.impuesto,
            total: total ?? this.total,
            linesOrder: linesOrder ?? this.linesOrder,
        );

    factory PedidoList.fromJson(Map<String, dynamic> json) => PedidoList(
        id: json["id"],
        codigoSap: json["codigoSap"],
        tipoDocumento: json["tipoDocumento"],
        fechaDeEntrega: json["fechaDeEntrega"] == null ? null : DateTime.parse(json["fechaDeEntrega"]),
        fechaDelDocumento: json["fechaDelDocumento"] == null ? null : DateTime.parse(json["fechaDelDocumento"]),
        codigoCliente: json["codigoCliente"],
        nombreCliente: json["nombreCliente"],
        codigoPersonaDeContacto: json["codigoPersonaDeContacto"],
        contacto: json["contacto"] == null ? null : PersonaContacto.fromJson(json["contacto"]),
        moneda: json["moneda"],
        comentarios: json["comentarios"],
        codigoEmpleadoDeVentas: json["codigoEmpleadoDeVentas"],
        empleado: json["empleado"] == null ? null : EmpleadoVenta.fromJson(json["empleado"]),
        nombreFactura: json["nombreFactura"],
        nitFactura: json["nitFactura"],
        estado: json["estado"],
        descuento: json["descuento"]?.toDouble(),
        impuesto: json["impuesto"]?.toDouble(),
        total: json["total"]?.toDouble(),
        linesOrder: json["linesOrder"] == null ? [] : List<LinesOrder>.from(json["linesOrder"]!.map((x) => LinesOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigoSap": codigoSap,
        "tipoDocumento": tipoDocumento,
        "fechaDeEntrega": fechaDeEntrega?.toIso8601String(),
        "fechaDelDocumento": fechaDelDocumento?.toIso8601String(),
        "codigoCliente": codigoCliente,
        "nombreCliente": nombreCliente,
        "codigoPersonaDeContacto": codigoPersonaDeContacto,
        "contacto": contacto,
        "moneda": moneda,
        "comentarios": comentarios,
        "codigoEmpleadoDeVentas": codigoEmpleadoDeVentas,
        "empleado": empleado,
        "nombreFactura": nombreFactura,
        "nitFactura": nitFactura,
        "estado": estado,
        "descuento": descuento,
        "impuesto": impuesto,
        "total": total,
        "linesOrder": linesOrder == null ? [] : List<dynamic>.from(linesOrder!.map((x) => x.toJson())),
    };
}

class LinesOrder {
    final String? codigo;
    final String? descripcion;
    final double? cantidad;
    final double? precioUnitario;
    final double? precioDespuesImpuestos;
    final String? moneda;
    final double? totalLinea;
    final String? codigoDeAlmacen;
    final String? unidadDeMedida;
    final String? estadoLinea;

    LinesOrder({
        this.codigo,
        this.descripcion,
        this.cantidad,
        this.precioUnitario,
        this.precioDespuesImpuestos,
        this.moneda,
        this.totalLinea,
        this.codigoDeAlmacen,
        this.unidadDeMedida,
        this.estadoLinea,
    });

    LinesOrder copyWith({
        String? codigo,
        String? descripcion,
        double? cantidad,
        double? precioUnitario,
        double? precioDespuesImpuestos,
        String? moneda,
        double? totalLinea,
        String? codigoDeAlmacen,
        String? unidadDeMedida,
        String? estadoLinea,
    }) => 
        LinesOrder(
            codigo: codigo ?? this.codigo,
            descripcion: descripcion ?? this.descripcion,
            cantidad: cantidad ?? this.cantidad,
            precioUnitario: precioUnitario ?? this.precioUnitario,
            precioDespuesImpuestos: precioDespuesImpuestos ?? this.precioDespuesImpuestos,
            moneda: moneda ?? this.moneda,
            totalLinea: totalLinea ?? this.totalLinea,
            codigoDeAlmacen: codigoDeAlmacen ?? this.codigoDeAlmacen,
            unidadDeMedida: unidadDeMedida ?? this.unidadDeMedida,
            estadoLinea: estadoLinea ?? this.estadoLinea,
        );

    factory LinesOrder.fromJson(Map<String, dynamic> json) => LinesOrder(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        cantidad: json["cantidad"]?.toDouble(),
        precioUnitario: json["precioUnitario"]?.toDouble(),
        precioDespuesImpuestos: json["precioDespuesImpuestos"]?.toDouble(),
        moneda: json["moneda"],
        totalLinea: json["totalLinea"]?.toDouble(),
        codigoDeAlmacen: json["codigoDeAlmacen"],
        unidadDeMedida: json["unidadDeMedida"],
        estadoLinea: json["estadoLinea"],
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descripcion": descripcion,
        "cantidad": cantidad,
        "precioUnitario": precioUnitario,
        "precioDespuesImpuestos": precioDespuesImpuestos,
        "moneda": moneda,
        "totalLinea": totalLinea,
        "codigoDeAlmacen": codigoDeAlmacen,
        "unidadDeMedida": unidadDeMedida,
        "estadoLinea": estadoLinea,
    };
}
