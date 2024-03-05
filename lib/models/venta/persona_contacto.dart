class PersonaContacto {
    final int? numeroInterno;
    final String? codigoCliente;
    final String? nombreCliente;
    final String? nombreContacto;
    final String? apellidoContacto;

    PersonaContacto({
        this.numeroInterno,
        this.codigoCliente,
        this.nombreCliente,
        this.nombreContacto,
        this.apellidoContacto,
    });

    PersonaContacto copyWith({
        int? numeroInterno,
        String? codigoCliente,
        String? nombreCliente,
        String? nombreContacto,
        String? apellidoContacto,
    }) => 
        PersonaContacto(
            numeroInterno: numeroInterno ?? this.numeroInterno,
            codigoCliente: codigoCliente ?? this.codigoCliente,
            nombreCliente: nombreCliente ?? this.nombreCliente,
            nombreContacto: nombreContacto ?? this.nombreContacto,
            apellidoContacto: apellidoContacto ?? this.apellidoContacto,
        );

    factory PersonaContacto.fromJson(Map<String, dynamic> json) => PersonaContacto(
        numeroInterno: json["numeroInterno"],
        codigoCliente: json["codigoCliente"],
        nombreCliente: json["nombreCliente"],
        nombreContacto: json["nombreContacto"],
        apellidoContacto: json["apellidoContacto"],
    );

    Map<String, dynamic> toJson() => {
        "numeroInterno": numeroInterno,
        "codigoCliente": codigoCliente,
        "nombreCliente": nombreCliente,
        "nombreContacto": nombreContacto,
        "apellidoContacto": apellidoContacto,
    };
}
