// To parse this JSON data, do
//
//     final socioNegocio = socioNegocioFromJson(jsonString);

import 'dart:convert';

import 'package:ventas_facil/models/venta/persona_contacto.dart';

SocioNegocio socioNegocioFromJson(String str) => SocioNegocio.fromJson(json.decode(str));

String socioNegocioToJson(SocioNegocio data) => json.encode(data.toJson());

class SocioNegocio {
    final String? id;
    final String? codigoSn;
    final String? nombreSn;
    final String? cardFName;
    final String? claseSn;
    final int? codigoGrupo;
    final String? monedaSn;
    final String? nit;
    final String? telefono1;
    final String? telefono2;
    final String? telefonoMovil;
    final String? correoElectronico;
    final String? personaContacto;
    final List<PersonaContacto>? contactosEmpleado;
    final int? codigoEmpleadoVentas;
    final String? direccion;
    final int? codigoCondicionPago;
    final int? numeroListaPrecio;

    SocioNegocio({
        this.id,
        this.codigoSn,
        this.nombreSn,
        this.cardFName,
        this.claseSn,
        this.codigoGrupo,
        this.monedaSn,
        this.nit,
        this.telefono1,
        this.telefono2,
        this.telefonoMovil,
        this.correoElectronico,
        this.personaContacto,
        this.contactosEmpleado,
        this.codigoEmpleadoVentas,
        this.direccion,
        this.codigoCondicionPago,
        this.numeroListaPrecio,
    });

    SocioNegocio copyWith({
        String? id,
        String? codigoSn,
        String? nombreSn,
        String? cardFName,
        String? claseSn,
        int? codigoGrupo,
        String? monedaSn,
        String? nit,
        String? telefono1,
        String? telefono2,
        String? telefonoMovil,
        String? correoElectronico,
        String? personaContacto,
        List<PersonaContacto>? contactosEmpleado,
        int? codigoEmpleadoVentas,
        String? direccion,
        int? codigoCondicionPago,
        int? numeroListaPrecio,
    }) => 
        SocioNegocio(
            id: id ?? this.id,
            codigoSn: codigoSn ?? this.codigoSn,
            nombreSn: nombreSn ?? this.nombreSn,
            cardFName: cardFName ?? this.cardFName,
            claseSn: claseSn ?? this.claseSn,
            codigoGrupo: codigoGrupo ?? this.codigoGrupo,
            monedaSn: monedaSn ?? this.monedaSn,
            nit: nit ?? this.nit,
            telefono1: telefono1 ?? this.telefono1,
            telefono2: telefono2 ?? this.telefono2,
            telefonoMovil: telefonoMovil ?? this.telefonoMovil,
            correoElectronico: correoElectronico ?? this.correoElectronico,
            personaContacto: personaContacto ?? this.personaContacto,
            contactosEmpleado: contactosEmpleado ?? this.contactosEmpleado,
            codigoEmpleadoVentas: codigoEmpleadoVentas ?? this.codigoEmpleadoVentas,
            direccion: direccion ?? this.direccion,
            codigoCondicionPago: codigoCondicionPago ?? this.codigoCondicionPago,
            numeroListaPrecio: numeroListaPrecio ?? this.numeroListaPrecio,
        );

    factory SocioNegocio.fromJson(Map<String, dynamic> json) => SocioNegocio(
        id: json["id"],
        codigoSn: json["codigoSN"],
        nombreSn: json["nombreSN"],
        cardFName: json["cardFName"],
        claseSn: json["claseSN"],
        codigoGrupo: json["codigoGrupo"],
        monedaSn: json["monedaSN"],
        nit: json["nit"],
        telefono1: json["telefono1"],
        telefono2: json["telefono2"],
        telefonoMovil: json["telefonoMovil"],
        correoElectronico: json["correoElectronico"],
        personaContacto: json["personaContacto"],
        contactosEmpleado: json["contactosEmpleado"] == null ? [] : List<PersonaContacto>.from(json["contactosEmpleado"]!.map((x) => PersonaContacto.fromJson(x))),
        codigoEmpleadoVentas: json["codigoEmpleadoVentas"],
        direccion: json["direccion"],
        codigoCondicionPago: json["codigoCondicionPago"],
        numeroListaPrecio: json["numeroListaPrecio"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigoSN": codigoSn,
        "nombreSN": nombreSn,
        "cardFName": cardFName,
        "claseSN": claseSn,
        "codigoGrupo": codigoGrupo,
        "monedaSN": monedaSn,
        "nit": nit,
        "telefono1": telefono1,
        "telefono2": telefono2,
        "telefonoMovil": telefonoMovil,
        "correoElectronico": correoElectronico,
        "personaContacto": personaContacto,
        "contactosEmpleado": contactosEmpleado == null ? [] : List<dynamic>.from(contactosEmpleado!.map((x) => x.toJson())),
        "codigoEmpleadoVentas": codigoEmpleadoVentas,
        "direccion": direccion,
        "codigoCondicionPago": codigoCondicionPago,
        "numeroListaPrecio": numeroListaPrecio,
    };
}

