// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

import 'package:ventas_facil/models/venta/socio_negocio.dart';

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
    final String? esGestionadoPorNumeroSerie;
    final String? unidadMedidaVenta;
    final String? unidadMedidaInventario;
    final double? cantidadEnStock;
    final double? grupoUnidadMedida;
    final String? codigoProveedor;
    final SocioNegocio? proveedorPrincipal;
    final String? codigoUnidadTfe;
    final List<ListaPrecio>? listaPrecios;
    final List<ItemAlmacen>? informacionItemAlmacen;
    final List<ItemLote>? informacionItemLote;

    Item({
        this.codigo,
        this.descripcion,
        this.nombreExtranjero,
        this.claseArticulo,
        this.grupoItem,
        this.esArticuloDeInventario,
        this.esArticuloDeVenta,
        this.esGestionadoNumeroLote,
        this.esGestionadoPorNumeroSerie,
        this.unidadMedidaVenta,
        this.unidadMedidaInventario,
        this.grupoUnidadMedida,
        this.codigoProveedor,
        this.proveedorPrincipal,
        this.cantidadEnStock,
        this.codigoUnidadTfe,
        this.listaPrecios,
        this.informacionItemAlmacen,
        this.informacionItemLote
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
        String? esGestionadoPorNumeroSerie,
        String? unidadMedidaVenta,
        String? unidadMedidaInventario,
        double? grupoUnidadMedida,
        String? codigoProveedor,
        SocioNegocio? proveedorPrincipal,
        double? cantidadEnStock,
        String? codigoUnidadTfe,
        List<ListaPrecio>? listaPrecios,
        List<ItemAlmacen>? informacionItemAlmacen,
        List<ItemLote>? informacionItemLote
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
            esGestionadoPorNumeroSerie: esGestionadoPorNumeroSerie ?? this.esGestionadoPorNumeroSerie,
            unidadMedidaVenta: unidadMedidaVenta ?? this.unidadMedidaVenta,
            unidadMedidaInventario: unidadMedidaInventario ?? this.unidadMedidaInventario,
            grupoUnidadMedida: grupoUnidadMedida ?? this.grupoUnidadMedida,
            codigoProveedor: codigoProveedor ?? this.codigoProveedor,
            proveedorPrincipal: proveedorPrincipal ?? this.proveedorPrincipal,
            cantidadEnStock: cantidadEnStock ?? this.cantidadEnStock,
            codigoUnidadTfe: codigoUnidadTfe ?? this.codigoUnidadTfe,
            listaPrecios: listaPrecios ?? this.listaPrecios,
            informacionItemAlmacen: informacionItemAlmacen ?? this.informacionItemAlmacen,
            informacionItemLote: informacionItemLote ?? this.informacionItemLote,
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
        esGestionadoPorNumeroSerie: json["esGestionadoPorNumeroSerie"],
        unidadMedidaVenta: json["unidadMedidaVenta"],
        unidadMedidaInventario: json["unidadMedidaInventario"],
        grupoUnidadMedida: json["grupoUnidadMedida"]?.toDouble(),
        codigoProveedor: json["codigoProveedor"],
        proveedorPrincipal: json["proveedorPrincipal"] == null ? null : SocioNegocio.fromJson(json["proveedorPrincipal"]),
        cantidadEnStock: json["cantidadEnStock"]?.toDouble(),
        codigoUnidadTfe: json["codigoUnidadTfe"],
        listaPrecios: json["listaPrecios"] == null ? [] : List<ListaPrecio>.from(json["listaPrecios"]!.map((x) => ListaPrecio.fromJson(x))),
        informacionItemAlmacen: json["informacionItemAlmacen"] == null ? [] : List<ItemAlmacen>.from(json["informacionItemAlmacen"]!.map((x) => ItemAlmacen.fromJson(x))),
        informacionItemLote: json["informacionItemLote"] == null ? [] : List<ItemLote>.from(json["informacionItemLote"]!.map((x) => ItemLote.fromJson(x))),
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
        "esGestionadoPorNumeroSerie": esGestionadoPorNumeroSerie,
        "unidadMedidaVenta": unidadMedidaVenta,
        "unidadMedidaInventario": unidadMedidaInventario,
        "grupoUnidadMedida": grupoUnidadMedida,
        "codigoProveedor": codigoProveedor,
        "proveedorPrincipal": proveedorPrincipal?.toJson(),
        "cantidadEnStock": cantidadEnStock,
        "codigoUnidadTfe": codigoUnidadTfe,
        "listaPrecios": listaPrecios == null ? [] : List<dynamic>.from(listaPrecios!.map((x) => x.toJson())),
        "informacionItemAlmacen": informacionItemAlmacen == null ? [] : List<dynamic>.from(informacionItemAlmacen!.map((x) => x.toJson())),
        "informacionItemLote": informacionItemLote == null ? [] : List<dynamic>.from(informacionItemLote!.map((x) => x.toJson())),
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


class ItemAlmacen {
    final String? codigoItem;
    final String? codigoAlmacen;
    final double? enStock;
    final double? comprometida;
    final double? solicitada;
    final double? disponible;

    ItemAlmacen({
        this.codigoItem,
        this.codigoAlmacen,
        this.enStock,
        this.comprometida,
        this.solicitada,
        this.disponible
    });

    ItemAlmacen copyWith({
      String? codigoItem,
      String? codigoAlmacen,
      double? enStock,
      double? comprometida,
      double? solicitada,
      double? disponible
    }) => 
        ItemAlmacen(
            codigoItem: codigoItem ?? this.codigoItem,
            codigoAlmacen: codigoAlmacen ?? this.codigoAlmacen,
            enStock: enStock ?? this.enStock,
            comprometida: comprometida ?? this.comprometida,
            solicitada: solicitada ?? this.solicitada,
            disponible: disponible ?? this.disponible
        );

    factory ItemAlmacen.fromJson(Map<String, dynamic> json) => ItemAlmacen(
        codigoItem: json["codigoItem"],
        codigoAlmacen: json["codigoAlmacen"],
        enStock: json["enStock"]?.toDouble(),
        comprometida: json["comprometida"]?.toDouble(),
        solicitada: json["solicitada"]?.toDouble(),
        disponible: json["disponible"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "codigoItem": codigoItem,
        "codigoAlmacen": codigoAlmacen,
        "enStock": enStock,
        "comprometida": comprometida,
        "solicitada": solicitada,
        "disponible": disponible,
    };
}

class ItemLote {
    final String? almacen;
    final String? codigoArticulo;
    final String? nombreArticulo;
    final String? numeroLote;
    final double? stock;
    final DateTime? fechaVencimiento;

    ItemLote({
        this.almacen,
        this.codigoArticulo,
        this.nombreArticulo,
        this.numeroLote,
        this.stock,
        this.fechaVencimiento
    });

    ItemLote copyWith({
      final String? almacen,
      final String? codigoArticulo,
      final String? nombreArticulo,
      final String? numeroLote,
      final double? stock,
      final DateTime? fechaVencimiento
    }) => 
        ItemLote(
            almacen: almacen ?? this.almacen,
            codigoArticulo: codigoArticulo ?? this.codigoArticulo,
            nombreArticulo: nombreArticulo ?? this.nombreArticulo,
            numeroLote: numeroLote ?? this.numeroLote,
            stock: stock ?? this.stock,
            fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento
        );

    factory ItemLote.fromJson(Map<String, dynamic> json) => ItemLote(
        almacen: json["almacen"],
        codigoArticulo: json["codigoArticulo"],
        nombreArticulo: json["nombreArticulo"],
        numeroLote: json["numeroLote"],
        stock: json["stock"]?.toDouble(),
        fechaVencimiento: json["fechaVencimiento"] == null ? null : DateTime.parse(json["fechaVencimiento"]),
    );

    Map<String, dynamic> toJson() => {
        "almacen": almacen,
        "codigoArticulo": codigoArticulo,
        "nombreArticulo": nombreArticulo,
        "numeroLote": numeroLote,
        "stock": stock,
        "fechaVencimiento": fechaVencimiento?.toIso8601String(),
    };
}