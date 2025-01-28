import 'dart:convert';

Tfe itemUnidadMedidaFromJson(String str) => Tfe.fromJson(json.decode(str));

String itemUnidadMedidaToJson(Tfe data) => json.encode(data.toJson());

class Tfe {
    String? id;
    String? code;
    String? name;

    Tfe({
        this.id,
        this.code,
        this.name,
    });

    Tfe copyWith({
        String? id,
        String? code,
        String? name,
    }) => 
        Tfe(
            id: id ?? this.id,
            code: code ?? this.code,
            name: name ?? this.name,
        );

    factory Tfe.fromJson(Map<String, dynamic> json) => Tfe(
        id: json["id"],
        code: json["code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
    };
}
