// To parse this JSON data, do
//
//     final itemUnidadMedida = itemUnidadMedidaFromJson(jsonString);

import 'dart:convert';

ItemUnidadMedida itemUnidadMedidaFromJson(String str) => ItemUnidadMedida.fromJson(json.decode(str));

String itemUnidadMedidaToJson(ItemUnidadMedida data) => json.encode(data.toJson());

class ItemUnidadMedida {
    int? absEntry;
    String? code;

    ItemUnidadMedida({
        this.absEntry,
        this.code,
    });

    ItemUnidadMedida copyWith({
        int? absEntry,
        String? code,
    }) => 
        ItemUnidadMedida(
            absEntry: absEntry ?? this.absEntry,
            code: code ?? this.code,
        );

    factory ItemUnidadMedida.fromJson(Map<String, dynamic> json) => ItemUnidadMedida(
        absEntry: json["absEntry"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "absEntry": absEntry,
        "code": code,
    };
}
