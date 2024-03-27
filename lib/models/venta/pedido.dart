// To parse this JSON data, do
//
//     final ordenVentaList = ordenVentaListFromJson(jsonString);

import 'dart:convert';

import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/persona_contacto.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';

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
    String? estadoCancelado;
    String? idCliente;
    String? nombreCliente;
    SocioNegocio? cliente;
    int? idEmpleado;
    String? nombreEmpleado;
    EmpleadoVenta? empleado;
    String? moneda;
    int? personaContacto;
    PersonaContacto? contacto;
    List<ItemPedido> linesPedido;
    String? usuarioVentaFacil;
    String? latitud;
    String? longitud;
    DateTime? fechaRegistroApp;
    DateTime? horaRegistroApp;
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
        this.estadoCancelado,
        this.idCliente,
        this.nombreCliente,
        this.cliente,
        this.idEmpleado,
        this.nombreEmpleado,
        this.empleado,
        this.moneda,
        this.personaContacto,
        this.contacto,
        required this.linesPedido,
        this.usuarioVentaFacil,
        this.latitud,
        this.longitud,
        this.fechaRegistroApp,
        this.horaRegistroApp,
        this.descuento,
        this.impuesto,
        this.total
    });

    double get totalAntesDelDescuento {
      double totalADTemp = 0;
      for (var element in linesPedido) {
        totalADTemp += element.total!;
      }
      return double.parse(totalADTemp.toStringAsFixed(2));
    }

    double get totalDescuento {
      double totalAD = 0;
      for (var element in linesPedido) {
        var precioDescuento = element.total! * element.descuento! / 100;
        totalAD += precioDescuento;
      }
      return double.parse(totalAD.toStringAsFixed(2));
    }

    double get totalDespuesDelDescuento{
      return double.parse((totalAntesDelDescuento - totalDescuento).toStringAsFixed(2)) ;
    }

    double get totalImpuesto {
      return totalAntesDelDescuento * 0.13;
    }

    double get totalDespuesdelImpuesto{
      return totalAntesDelDescuento + totalImpuesto;
    }

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
        String? estadoCancelado,
        String? idCliente,
        String? nombreCliente,
        SocioNegocio? cliente,
        int? idEmpleado,
        String? nombreEmpleado,
        EmpleadoVenta? empleado,
        String? moneda,
        int? personaContacto,
        PersonaContacto? contacto,
        List<ItemPedido>? linesPedido,
        String? usuarioVentaFacil,
        String? latitud,
        String? longitud,
        DateTime? fechaRegistroApp,
        DateTime? horaRegistroApp,
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
            estadoCancelado: estadoCancelado ?? this.estadoCancelado,
            idCliente: idCliente ?? this.idCliente,
            nombreCliente: nombreCliente ?? this.nombreCliente,
            cliente: cliente ?? this.cliente,
            idEmpleado: idEmpleado ?? this.idEmpleado,
            nombreEmpleado: nombreEmpleado ?? this.nombreEmpleado,
            empleado: empleado ?? this.empleado,
            moneda: moneda ?? this.moneda,
            personaContacto: personaContacto ?? this.personaContacto,
            contacto: contacto ?? this.contacto,
            linesPedido: linesPedido ?? this.linesPedido,
            usuarioVentaFacil: usuarioVentaFacil ?? this.usuarioVentaFacil,
            latitud: latitud ?? this.latitud,
            longitud: longitud ?? this.longitud,
            fechaRegistroApp: fechaRegistroApp ?? this.fechaRegistroApp,
            horaRegistroApp: horaRegistroApp ?? this.horaRegistroApp,
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
        estadoCancelado: json["estadoCancelado"],
        idCliente: json["idCliente"],
        nombreCliente: json["nombreCliente"],
        cliente: json["cliente"] == null ? null : SocioNegocio.fromJson(json["cliente"]),
        idEmpleado: json["idEmpleado"],
        nombreEmpleado: json["nombreEmpleado"],
        empleado: json["empleado"] == null ? null : EmpleadoVenta.fromJson(json["empleado"]),
        moneda: json["moneda"],
        personaContacto: json["personaContacto"],
        contacto: json["contacto"] == null ? null : PersonaContacto.fromJson(json["contacto"]),
        linesPedido: json["linesPedido"] == null ? [] : List<ItemPedido>.from(json["linesPedido"]!.map((x) => ItemPedido.fromJson(x))),
        usuarioVentaFacil: json["usuarioVentaFacil"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        fechaRegistroApp: json["fechaRegistroApp"] == null ? null : DateTime.parse(json["fechaRegistroApp"]),
        horaRegistroApp: json["horaRegistroApp"] == null ? null : DateTime.parse(json["horaRegistroApp"]),
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
        "estadoCancelado": estadoCancelado,
        "idCliente": idCliente,
        "nombreCliente": nombreCliente,
        "cliente": cliente,
        "idEmpleado": idEmpleado,
        "nombreEmpleado": nombreEmpleado,
        "empleado": empleado,
        "moneda": moneda,
        "personaContacto": personaContacto,
        "contacto": contacto,
        "linesPedido": linesPedido.isEmpty ? [] : List<dynamic>.from(linesPedido.map((x) => x.toJson())),
        "usuarioVentaFacil": usuarioVentaFacil,
        "latitud": latitud,
        "longitud": longitud,
        "fechaRegistroApp": fechaRegistroApp?.toIso8601String(),
        "horaRegistroApp": horaRegistroApp?.toIso8601String(),
    };
}