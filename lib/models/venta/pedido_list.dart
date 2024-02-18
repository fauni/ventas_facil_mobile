// To parse this JSON data, do
//
//     final ordenVentaList = ordenVentaListFromJson(jsonString);

import 'dart:convert';

PedidoList ordenVentaListFromJson(String str) => PedidoList.fromJson(json.decode(str));

String pedidoListToJson(PedidoList data) => json.encode(data.toJson());

class PedidoList {
    final int? id;
    final int? codigoSap;
    final String? nombreFactura;
    final String? nitFactura;
    final int? diasPlazo;
    final DateTime? fechaEntrega;
    final double? total;
    final double? tipoCambio;
    final double? descuento;
    final String? observacion;
    final DateTime? fechaRegistro;
    final String? estado;
    final String? idCliente;
    final String? nombreCliente;
    final String? idEmpleado;
    final String? moneda;
    final String? personaContacto;

    PedidoList({
        this.id,
        this.codigoSap,
        this.nombreFactura,
        this.nitFactura,
        this.diasPlazo,
        this.fechaEntrega,
        this.total,
        this.tipoCambio,
        this.descuento,
        this.observacion,
        this.fechaRegistro,
        this.estado,
        this.idCliente,
        this.nombreCliente,
        this.idEmpleado,
        this.moneda,
        this.personaContacto,
    });

    PedidoList copyWith({
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
        String? idEmpleado,
        String? moneda,
        String? personaContacto,
    }) => 
        PedidoList(
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
            moneda: moneda ?? this.moneda,
            personaContacto: personaContacto ?? this.personaContacto,
        );

    factory PedidoList.fromJson(Map<String, dynamic> json) => PedidoList(
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
        moneda: json["moneda"],
        personaContacto: json["personaContacto"],
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
        "moneda": moneda,
        "personaContacto": personaContacto,
    };
}
