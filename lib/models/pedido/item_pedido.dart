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
        this.indicadorDeImpuestos
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
        String? indicadorDeImpuestos
    }) => 
        ItemPedido(
            codigo: codigo ?? this.codigo,
            descripcion: descripcion ?? this.descripcion,
            descripcionAdicional: descripcionAdicional ?? this.descripcionAdicional,
            cantidad: cantidad ?? this.cantidad,
            precioPorUnidad: precioPorUnidad ?? this.precioPorUnidad,
            descuento: descuento ?? this.descuento,
            indicadorDeImpuestos: indicadorDeImpuestos ?? this.indicadorDeImpuestos
        );

    factory ItemPedido.fromJson(Map<String, dynamic> json) => ItemPedido(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        descripcionAdicional: json["descripcionAdicional"],
        cantidad: json["cantidad"]?.toDouble(),
        precioPorUnidad: json["precioPorUnidad"]?.toDouble(),
        descuento: json["descuento"]?.toDouble(),
        indicadorDeImpuestos: json["indicadorDeImpuestos"]
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descripcion": descripcion,
        "descripcionAdicional": descripcionAdicional,
        "cantidad": cantidad,
        "precioPorUnidad": precioPorUnidad,
        "descuento": descuento,
        "indicadorDeImpuestos": indicadorDeImpuestos
    };
}