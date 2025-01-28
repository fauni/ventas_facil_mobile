import 'dart:convert';

UnidadMedida unidadMedidaFromJson(String str) => UnidadMedida.fromJson(json.decode(str));

String unidadMedidaToJson(UnidadMedida data) => json.encode(data.toJson());

class UnidadMedida {
    final String? itemCode;
    final int? ugpEntry;
    final int? uomEntry;
    final String? uomCode;
    final String? ugpCode;
    final String? descripcion;

    UnidadMedida({
        this.itemCode,
        this.ugpEntry,
        this.uomEntry,
        this.uomCode,
        this.ugpCode,
        this.descripcion,
    });

    UnidadMedida copyWith({
        String? itemCode,
        int? ugpEntry,
        int? uomEntry,
        String? uomCode,
        String? ugpCode,
        String? descripcion,
    }) => 
        UnidadMedida(
            itemCode: itemCode ?? this.itemCode,
            ugpEntry: ugpEntry ?? this.ugpEntry,
            uomEntry: uomEntry ?? this.uomEntry,
            uomCode: uomCode ?? this.uomCode,
            ugpCode: ugpCode ?? this.ugpCode,
            descripcion: descripcion ?? this.descripcion,
        );

    factory UnidadMedida.fromJson(Map<String, dynamic> json) => UnidadMedida(
        itemCode: json["itemCode"],
        ugpEntry: json["ugpEntry"],
        uomEntry: json["uomEntry"],
        uomCode: json["uomCode"],
        ugpCode: json["ugpCode"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "itemCode": itemCode,
        "ugpEntry": ugpEntry,
        "uomEntry": uomEntry,
        "uomCode": uomCode,
        "ugpCode": ugpCode,
        "descripcion": descripcion,
    };
}
