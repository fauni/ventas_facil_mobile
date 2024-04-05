// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

ItemPedido itemFromJson(String str) => ItemPedido.fromJson(json.decode(str));

String itemToJson(ItemPedido data) => json.encode(data.toJson());

class ItemPedido {
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
    // double? porcentajeDescuento;
    // double? precioTrasElDescuento;
    // String? monedaPrecio;


    ItemPedido({
        this.codigo,
        this.descripcion,
        this.descripcionAdicional,
        this.cantidad,
        this.precioPorUnidad,
        this.descuento,
        this.indicadorDeImpuestos,
        this.unidadDeMedidaManual,
        this.codigoUnidadMedida,
        this.nombreUnidadMedida
    });

    double? get total => cantidad != null && precioPorUnidad != null ? cantidad! * precioPorUnidad! : null;
    double? get precioConIVA => total != null ? total! - total! * 0.13 : null;
    double? get precioConDescuento => total != null ? total! - total! * descuento!/100 : null;

    ItemPedido copyWith({
        String? codigo,
        String? descripcion,
        String? descripcionAdicional,
        double? cantidad,
        double? precioPorUnidad,
        double? descuento,
        String? indicadorDeImpuestos,
        double? unidadDeMedidaManual,
        int? codigoUnidadMedida,
        String? nombreUnidadMedida
    }) => 
        ItemPedido(
            codigo: codigo ?? this.codigo,
            descripcion: descripcion ?? this.descripcion,
            descripcionAdicional: descripcionAdicional ?? this.descripcionAdicional,
            cantidad: cantidad ?? this.cantidad,
            precioPorUnidad: precioPorUnidad ?? this.precioPorUnidad,
            descuento: descuento ?? this.descuento,
            indicadorDeImpuestos: indicadorDeImpuestos ?? this.indicadorDeImpuestos,
            unidadDeMedidaManual: unidadDeMedidaManual ?? this.unidadDeMedidaManual,
            codigoUnidadMedida: codigoUnidadMedida ?? this.codigoUnidadMedida,
            nombreUnidadMedida: nombreUnidadMedida ?? this.nombreUnidadMedida
        );

    factory ItemPedido.fromJson(Map<String, dynamic> json) => ItemPedido(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        descripcionAdicional: json["descripcionAdicional"],
        cantidad: json["cantidad"]?.toDouble(),
        precioPorUnidad: json["precioPorUnidad"]?.toDouble(),
        descuento: json["descuento"]?.toDouble(),
        indicadorDeImpuestos: json["indicadorDeImpuestos"],
        unidadDeMedidaManual: json["unidadDeMedidaManual"]?.toDouble(),
        codigoUnidadMedida: json["codigoUnidadMedida"],
        nombreUnidadMedida: json["nombreUnidadMedida"]
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descripcion": descripcion,
        "descripcionAdicional": descripcionAdicional,
        "cantidad": cantidad,
        "precioPorUnidad": precioPorUnidad,
        "descuento": descuento,
        "indicadorDeImpuestos": indicadorDeImpuestos,
        "unidadDeMedidaManual": unidadDeMedidaManual,
        "codigoUnidadMedida": codigoUnidadMedida,
        "nombreUnidadMedida": nombreUnidadMedida
    };
}