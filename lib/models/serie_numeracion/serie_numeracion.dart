import 'dart:convert';

SerieNumeracion serieNumeracionFromJson(String str) => SerieNumeracion.fromJson(json.decode(str));

String serieNumeracionToJson(SerieNumeracion data) => json.encode(data.toJson());

class SerieNumeracion {
    final int? codigoDocumento;
    final String? tipoDocumento;
    final int? numeroInicial;
    final int? ultimoNumero;
    final int? siguienteNumero;
    final String? nombre;
    final int? series;
    final String? tipoDeSerie;

    SerieNumeracion({
        this.codigoDocumento,
        this.tipoDocumento,
        this.numeroInicial,
        this.ultimoNumero,
        this.siguienteNumero,
        this.nombre,
        this.series,
        this.tipoDeSerie,
    });

    SerieNumeracion copyWith({
        int? codigoDocumento,
        String? tipoDocumento,
        int? numeroInicial,
        int? ultimoNumero,
        int? siguienteNumero,
        String? nombre,
        int? series,
        String? tipoDeSerie,
    }) => 
        SerieNumeracion(
            codigoDocumento: codigoDocumento ?? this.codigoDocumento,
            tipoDocumento: tipoDocumento ?? this.tipoDocumento,
            numeroInicial: numeroInicial ?? this.numeroInicial,
            ultimoNumero: ultimoNumero ?? this.ultimoNumero,
            siguienteNumero: siguienteNumero ?? this.siguienteNumero,
            nombre: nombre ?? this.nombre,
            series: series ?? this.series,
            tipoDeSerie: tipoDeSerie ?? this.tipoDeSerie,
        );

    factory SerieNumeracion.fromJson(Map<String, dynamic> json) => SerieNumeracion(
        codigoDocumento: json["codigoDocumento"],
        tipoDocumento: json["tipoDocumento"],
        numeroInicial: json["numeroInicial"],
        ultimoNumero: json["ultimoNumero"],
        siguienteNumero: json["siguienteNumero"],
        nombre: json["nombre"],
        series: json["series"],
        tipoDeSerie: json["tipoDeSerie"],
    );

    Map<String, dynamic> toJson() => {
        "codigoDocumento": codigoDocumento,
        "tipoDocumento": tipoDocumento,
        "numeroInicial": numeroInicial,
        "ultimoNumero": ultimoNumero,
        "siguienteNumero": siguienteNumero,
        "nombre": nombre,
        "series": series,
        "tipoDeSerie": tipoDeSerie,
    };
}
