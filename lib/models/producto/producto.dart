import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
    final int? id;
    final String? codigoSap;
    final String? nombre;
    final String? descripcion;
    final double? precioUnitario;
    final double? stock;
    final int? peso;
    final dynamic imagen;
    final DateTime? fechaRegistro;
    final String? unidadMedida;

    Producto({
        this.id,
        this.codigoSap,
        this.nombre,
        this.descripcion,
        this.precioUnitario,
        this.stock,
        this.peso,
        this.imagen,
        this.fechaRegistro,
        this.unidadMedida,
    });

    Producto copyWith({
        int? id,
        String? codigoSap,
        String? nombre,
        String? descripcion,
        double? precioUnitario,
        double? stock,
        int? peso,
        dynamic imagen,
        DateTime? fechaRegistro,
        String? unidadMedida,
    }) => 
        Producto(
            id: id ?? this.id,
            codigoSap: codigoSap ?? this.codigoSap,
            nombre: nombre ?? this.nombre,
            descripcion: descripcion ?? this.descripcion,
            precioUnitario: precioUnitario ?? this.precioUnitario,
            stock: stock ?? this.stock,
            peso: peso ?? this.peso,
            imagen: imagen ?? this.imagen,
            fechaRegistro: fechaRegistro ?? this.fechaRegistro,
            unidadMedida: unidadMedida ?? this.unidadMedida,
        );

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        codigoSap: json["codigoSap"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precioUnitario: json["precioUnitario"]?.toDouble(),
        stock: json["stock"]?.toDouble(),
        peso: json["peso"],
        imagen: json["imagen"],
        fechaRegistro: json["fechaRegistro"] == null ? null : DateTime.parse(json["fechaRegistro"]),
        unidadMedida: json["unidadMedida"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigoSap": codigoSap,
        "nombre": nombre,
        "descripcion": descripcion,
        "precioUnitario": precioUnitario,
        "stock": stock,
        "peso": peso,
        "imagen": imagen,
        "fechaRegistro": fechaRegistro?.toIso8601String(),
        "unidadMedida": unidadMedida,
    };
}
