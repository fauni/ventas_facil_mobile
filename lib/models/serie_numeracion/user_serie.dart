// To parse this JSON data, do
//
//     final userSerie = userSerieFromJson(jsonString);

import 'dart:convert';

UserSerie userSerieFromJson(String str) => UserSerie.fromJson(json.decode(str));

String userSerieToJson(UserSerie data) => json.encode(data.toJson());

class UserSerie {
    final int? id;
    final String? idUsuario;
    final int? idSerie;
    final String? nombreSerie;

    UserSerie({
        this.id,
        this.idUsuario,
        this.idSerie,
        this.nombreSerie
    });

    UserSerie copyWith({
        int? id,
        String? idUsuario,
        int? idSerie,
        String? nombreSerie,
    }) => 
        UserSerie(
            id: id ?? this.id,
            idUsuario: idUsuario ?? this.idUsuario,
            idSerie: idSerie ?? this.idSerie,
            nombreSerie: nombreSerie ?? this.nombreSerie
        );

    factory UserSerie.fromJson(Map<String, dynamic> json) => UserSerie(
        id: json["id"],
        idUsuario: json["idUsuario"],
        idSerie: json["idSerie"],
        nombreSerie: json["nombreSerie"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idUsuario": idUsuario,
        "idSerie": idSerie,
        "nombreSerie": nombreSerie,
    };
}
