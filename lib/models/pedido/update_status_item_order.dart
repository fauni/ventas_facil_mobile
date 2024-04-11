// To parse this JSON data, do
//
//     final updateStatusItemOrder = updateStatusItemOrderFromJson(jsonString);

import 'dart:convert';

UpdateStatusItemOrder updateStatusItemOrderFromJson(String str) => UpdateStatusItemOrder.fromJson(json.decode(str));

String updateStatusItemOrderToJson(UpdateStatusItemOrder data) => json.encode(data.toJson());

class UpdateStatusItemOrder {
    int? id;
    int? codigoSap;
    List<LinesPedido>? linesPedido;

    UpdateStatusItemOrder({
        this.id,
        this.codigoSap,
        this.linesPedido,
    });

    UpdateStatusItemOrder copyWith({
        int? id,
        int? codigoSap,
        List<LinesPedido>? linesPedido,
    }) => 
        UpdateStatusItemOrder(
            id: id ?? this.id,
            codigoSap: codigoSap ?? this.codigoSap,
            linesPedido: linesPedido ?? this.linesPedido,
        );

    factory UpdateStatusItemOrder.fromJson(Map<String, dynamic> json) => UpdateStatusItemOrder(
        id: json["id"],
        codigoSap: json["codigoSap"],
        linesPedido: json["linesPedido"] == null ? [] : List<LinesPedido>.from(json["linesPedido"]!.map((x) => LinesPedido.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigoSap": codigoSap,
        "linesPedido": linesPedido == null ? [] : List<dynamic>.from(linesPedido!.map((x) => x.toJson())),
    };
}

class LinesPedido {
    int? numeroDeLinea;

    LinesPedido({
        this.numeroDeLinea,
    });

    LinesPedido copyWith({
        int? numeroDeLinea,
    }) => 
        LinesPedido(
            numeroDeLinea: numeroDeLinea ?? this.numeroDeLinea,
        );

    factory LinesPedido.fromJson(Map<String, dynamic> json) => LinesPedido(
        numeroDeLinea: json["numeroDeLinea"],
    );

    Map<String, dynamic> toJson() => {
        "numeroDeLinea": numeroDeLinea,
    };
}
