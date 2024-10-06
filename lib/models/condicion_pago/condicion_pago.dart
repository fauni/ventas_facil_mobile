import 'dart:convert';

CondicionDePago condicionDePagoFromJson(String str) => CondicionDePago.fromJson(json.decode(str));

String condicionDePagoToJson(CondicionDePago data) => json.encode(data.toJson());

class CondicionDePago {
    final int? numeroGrupo;
    final String? nombreCondicionPago;
    final int? idListaPrecio;

    CondicionDePago({
        this.numeroGrupo,
        this.nombreCondicionPago,
        this.idListaPrecio,
    });

    CondicionDePago copyWith({
        int? numeroGrupo,
        String? nombreCondicionPago,
        int? idListaPrecio,
    }) => 
        CondicionDePago(
            numeroGrupo: numeroGrupo ?? this.numeroGrupo,
            nombreCondicionPago: nombreCondicionPago ?? this.nombreCondicionPago,
            idListaPrecio: idListaPrecio ?? this.idListaPrecio,
        );

    factory CondicionDePago.fromJson(Map<String, dynamic> json) => CondicionDePago(
        numeroGrupo: json["numeroGrupo"],
        nombreCondicionPago: json["nombreCondicionPago"],
        idListaPrecio: json["idListaPrecio"],
    );

    Map<String, dynamic> toJson() => {
        "numeroGrupo": numeroGrupo,
        "nombreCondicionPago": nombreCondicionPago,
        "idListaPrecio": idListaPrecio,
    };
}
