// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
    final String? codigo;
    final String? descripcion;
    final dynamic nombreExtranjero;
    final String? claseArticulo;
    final GrupoItem? grupoItem;
    final String? esArticuloDeInventario;
    final String? esArticuloDeVenta;
    final String? esGestionadoNumeroLote;
    final String? unidadMedidaVenta;
    final String? unidadMedidaInventario;
    final List<ListaPrecio>? listaPrecios;

    Item({
        this.codigo,
        this.descripcion,
        this.nombreExtranjero,
        this.claseArticulo,
        this.grupoItem,
        this.esArticuloDeInventario,
        this.esArticuloDeVenta,
        this.esGestionadoNumeroLote,
        this.unidadMedidaVenta,
        this.unidadMedidaInventario,
        this.listaPrecios,
    });

    Item copyWith({
        String? codigo,
        String? descripcion,
        dynamic nombreExtranjero,
        String? claseArticulo,
        GrupoItem? grupoItem,
        String? esArticuloDeInventario,
        String? esArticuloDeVenta,
        String? esGestionadoNumeroLote,
        String? unidadMedidaVenta,
        String? unidadMedidaInventario,
        List<ListaPrecio>? listaPrecios,
    }) => 
        Item(
            codigo: codigo ?? this.codigo,
            descripcion: descripcion ?? this.descripcion,
            nombreExtranjero: nombreExtranjero ?? this.nombreExtranjero,
            claseArticulo: claseArticulo ?? this.claseArticulo,
            grupoItem: grupoItem ?? this.grupoItem,
            esArticuloDeInventario: esArticuloDeInventario ?? this.esArticuloDeInventario,
            esArticuloDeVenta: esArticuloDeVenta ?? this.esArticuloDeVenta,
            esGestionadoNumeroLote: esGestionadoNumeroLote ?? this.esGestionadoNumeroLote,
            unidadMedidaVenta: unidadMedidaVenta ?? this.unidadMedidaVenta,
            unidadMedidaInventario: unidadMedidaInventario ?? this.unidadMedidaInventario,
            listaPrecios: listaPrecios ?? this.listaPrecios,
        );

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        nombreExtranjero: json["nombreExtranjero"],
        claseArticulo: json["claseArticulo"],
        grupoItem: json["grupoItem"] == null ? null : GrupoItem.fromJson(json["grupoItem"]),
        esArticuloDeInventario: json["esArticuloDeInventario"],
        esArticuloDeVenta: json["esArticuloDeVenta"],
        esGestionadoNumeroLote: json["esGestionadoNumeroLote"],
        unidadMedidaVenta: json["unidadMedidaVenta"],
        unidadMedidaInventario: json["unidadMedidaInventario"],
        listaPrecios: json["listaPrecios"] == null ? [] : List<ListaPrecio>.from(json["listaPrecios"]!.map((x) => ListaPrecio.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descripcion": descripcion,
        "nombreExtranjero": nombreExtranjero,
        "claseArticulo": claseArticulo,
        "grupoItem": grupoItem?.toJson(),
        "esArticuloDeInventario": esArticuloDeInventario,
        "esArticuloDeVenta": esArticuloDeVenta,
        "esGestionadoNumeroLote": esGestionadoNumeroLote,
        "unidadMedidaVenta": unidadMedidaVenta,
        "unidadMedidaInventario": unidadMedidaInventario,
        "listaPrecios": listaPrecios == null ? [] : List<dynamic>.from(listaPrecios!.map((x) => x.toJson())),
    };
}

class GrupoItem {
    final int? numero;
    final String? nombreGrupo;

    GrupoItem({
        this.numero,
        this.nombreGrupo,
    });

    GrupoItem copyWith({
        int? numero,
        String? nombreGrupo,
    }) => 
        GrupoItem(
            numero: numero ?? this.numero,
            nombreGrupo: nombreGrupo ?? this.nombreGrupo,
        );

    factory GrupoItem.fromJson(Map<String, dynamic> json) => GrupoItem(
        numero: json["numero"],
        nombreGrupo: json["nombreGrupo"],
    );

    Map<String, dynamic> toJson() => {
        "numero": numero,
        "nombreGrupo": nombreGrupo,
    };
}

class ListaPrecio {
    final int? numero;
    final double? precio;
    final String? moneda;

    ListaPrecio({
        this.numero,
        this.precio,
        this.moneda,
    });

    ListaPrecio copyWith({
        int? numero,
        double? precio,
        String? moneda,
    }) => 
        ListaPrecio(
            numero: numero ?? this.numero,
            precio: precio ?? this.precio,
            moneda: moneda ?? this.moneda,
        );

    factory ListaPrecio.fromJson(Map<String, dynamic> json) => ListaPrecio(
        numero: json["numero"],
        precio: json["precio"]?.toDouble(),
        moneda: json["moneda"],
    );

    Map<String, dynamic> toJson() => {
        "numero": numero,
        "precio": precio,
        "moneda": moneda,
    };
}
