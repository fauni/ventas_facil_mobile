// To parse this JSON data, do
//
//     final ordenVentaList = ordenVentaListFromJson(jsonString);

import 'dart:convert';

import 'package:ventas_facil/models/pedido/item_pedido.dart';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
    int? id;
    int? codigoSap;
    String? nombreFactura;
    String? nitFactura;
    int? diasPlazo;
    DateTime? fechaEntrega;
    double? tipoCambio;
    String? observacion;
    DateTime? fechaRegistro;
    String? estado;
    String? idCliente;
    String? nombreCliente;
    int? idEmpleado;
    String? nombreEmpleado;
    String? moneda;
    String? personaContacto;
    List<ItemPedido>? linesPedido;
    double? totalAntesDelDescuento;
    double? descuento;
    double? impuesto;
    double? total;


    Pedido({
        this.id,
        this.codigoSap,
        this.nombreFactura,
        this.nitFactura,
        this.diasPlazo,
        this.fechaEntrega,
        this.tipoCambio,
        this.observacion,
        this.fechaRegistro,
        this.estado,
        this.idCliente,
        this.nombreCliente,
        this.idEmpleado,
        this.nombreEmpleado,
        this.moneda,
        this.personaContacto,
        this.linesPedido,
        this.totalAntesDelDescuento,
        this.descuento,
        this.impuesto,
        this.total
    });

    Pedido copyWith({
        int? id,
        int? codigoSap,
        String? nombreFactura,
        String? nitFactura,
        int? diasPlazo,
        DateTime? fechaEntrega,
        double? total,
        double? tipoCambio,
        double? descuento,
        String? observacion,
        DateTime? fechaRegistro,
        String? estado,
        String? idCliente,
        String? nombreCliente,
        int? idEmpleado,
        String? nombreEmpleado,
        String? moneda,
        String? personaContacto,
        List<ItemPedido>? linesPedido,
    }) => 
        Pedido(
            id: id ?? this.id,
            codigoSap: codigoSap ?? this.codigoSap,
            nombreFactura: nombreFactura ?? this.nombreFactura,
            nitFactura: nitFactura ?? this.nitFactura,
            diasPlazo: diasPlazo ?? this.diasPlazo,
            fechaEntrega: fechaEntrega ?? this.fechaEntrega,
            total: total ?? this.total,
            tipoCambio: tipoCambio ?? this.tipoCambio,
            descuento: descuento ?? this.descuento,
            observacion: observacion ?? this.observacion,
            fechaRegistro: fechaRegistro ?? this.fechaRegistro,
            estado: estado ?? this.estado,
            idCliente: idCliente ?? this.idCliente,
            nombreCliente: nombreCliente ?? this.nombreCliente,
            idEmpleado: idEmpleado ?? this.idEmpleado,
            nombreEmpleado: nombreEmpleado ?? this.nombreEmpleado,
            moneda: moneda ?? this.moneda,
            personaContacto: personaContacto ?? this.personaContacto,
            linesPedido: linesPedido ?? this.linesPedido
        );

    factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        id: json["id"],
        codigoSap: json["codigoSap"],
        nombreFactura: json["nombreFactura"],
        nitFactura: json["nitFactura"],
        diasPlazo: json["diasPlazo"],
        fechaEntrega: json["fechaEntrega"] == null ? null : DateTime.parse(json["fechaEntrega"]),
        total: json["total"]?.toDouble(),
        tipoCambio: json["tipoCambio"]?.toDouble(),
        descuento: json["descuento"]?.toDouble(),
        observacion: json["observacion"],
        fechaRegistro: json["fechaRegistro"] == null ? null : DateTime.parse(json["fechaRegistro"]),
        estado: json["estado"],
        idCliente: json["idCliente"],
        nombreCliente: json["nombreCliente"],
        idEmpleado: json["idEmpleado"],
        nombreEmpleado: json["nombreEmpleado"],
        moneda: json["moneda"],
        personaContacto: json["personaContacto"],
        linesPedido: json["linesPedido"] == null ? [] : List<ItemPedido>.from(json["linesPedido"]!.map((x) => ItemPedido.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigoSap": codigoSap,
        "nombreFactura": nombreFactura,
        "nitFactura": nitFactura,
        "diasPlazo": diasPlazo,
        "fechaEntrega": fechaEntrega?.toIso8601String(),
        "total": total,
        "tipoCambio": tipoCambio,
        "descuento": descuento,
        "observacion": observacion,
        "fechaRegistro": fechaRegistro?.toIso8601String(),
        "estado": estado,
        "idCliente": idCliente,
        "nombreCliente": nombreCliente,
        "idEmpleado": idEmpleado,
        "nombreEmpleado": nombreEmpleado,
        "moneda": moneda,
        "personaContacto": personaContacto,
        "linesPedido": linesPedido == null ? [] : List<dynamic>.from(linesPedido!.map((x) => x.toJson())),
    };
}
