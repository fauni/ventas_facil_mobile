// To parse this JSON data, do
//
//     final tfeUnidadMedida = tfeUnidadMedidaFromJson(jsonString);

import 'dart:convert';

TfeUnidadMedida tfeUnidadMedidaFromJson(String str) => TfeUnidadMedida.fromJson(json.decode(str));

String tfeUnidadMedidaToJson(TfeUnidadMedida data) => json.encode(data.toJson());

class TfeUnidadMedida {
    final String? code;
    final String? name;
    final String? uUnidadimp;

    TfeUnidadMedida({
        this.code,
        this.name,
        this.uUnidadimp,
    });

    TfeUnidadMedida copyWith({
        String? code,
        String? name,
        String? uUnidadimp,
    }) => 
        TfeUnidadMedida(
            code: code ?? this.code,
            name: name ?? this.name,
            uUnidadimp: uUnidadimp ?? this.uUnidadimp,
        );

    factory TfeUnidadMedida.fromJson(Map<String, dynamic> json) => TfeUnidadMedida(
        code: json["code"],
        name: json["name"],
        uUnidadimp: json["u_unidadimp"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "u_unidadimp": uUnidadimp,
    };
}
