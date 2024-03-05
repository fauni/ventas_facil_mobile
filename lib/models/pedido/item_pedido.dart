// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

ItemPedido itemFromJson(String str) => ItemPedido.fromJson(json.decode(str));

String itemToJson(ItemPedido data) => json.encode(data.toJson());

class ItemPedido {
    String? codigo;
    String? descripcion;
    double? cantidad;
    double? precioPorUnidad; 
    String? indicadorDeImpuestos;
    // double? porcentajeDescuento;
    // double? precioTrasElDescuento;
    // String? monedaPrecio;


    ItemPedido({
        this.codigo,
        this.descripcion,
        this.cantidad,
        this.precioPorUnidad,
        this.indicadorDeImpuestos
    });

    double? get total => cantidad != null && precioPorUnidad != null ? cantidad! * precioPorUnidad! : null;

    ItemPedido copyWith({
        String? codigo,
        String? descripcion,
        double? cantidad,
        double? precioPorUnidad,
        String? indicadorDeImpuestos
    }) => 
        ItemPedido(
            codigo: codigo ?? this.codigo,
            descripcion: descripcion ?? this.descripcion,
            cantidad: cantidad ?? this.cantidad,
            precioPorUnidad: precioPorUnidad ?? this.precioPorUnidad,
            indicadorDeImpuestos: indicadorDeImpuestos ?? this.indicadorDeImpuestos
        );

    factory ItemPedido.fromJson(Map<String, dynamic> json) => ItemPedido(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        cantidad: json["cantidad"],
        precioPorUnidad: json["precio"],
        indicadorDeImpuestos: json["indicadorDeImpuestos"]
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descripcion": descripcion,
        "cantidad": cantidad,
        "precio": precioPorUnidad,
        "indicadorDeImpuestos": indicadorDeImpuestos
    };
}