import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';

class MapGeneric {
  static Pedido pedidoListToPedido(PedidoList data) {
    Pedido pedido = Pedido(linesPedido: []);
    pedido.id = data.codigoSap;
    pedido.codigoSap = data.codigoSap;
    pedido.numeroDocumento = data.numeroDocumento.toString();
    pedido.nombreFactura = data.nombreFactura;
    pedido.nitFactura = data.nitFactura;
    pedido.diasPlazo = 0;
    pedido.fechaEntrega = data.fechaDeEntrega;
    pedido.tipoCambio = 0;
    pedido.observacion = data.comentarios;
    pedido.fechaRegistro = data.fechaDelDocumento;
    pedido.estado = data.estado;
    pedido.estadoCancelado = data.estadoCancelado;
    pedido.idCliente = data.codigoCliente;
    pedido.nombreCliente = data.nombreCliente;
    pedido.cliente = data.cliente;
    pedido.idEmpleado = data.codigoEmpleadoDeVentas;
    pedido.nombreEmpleado = data.empleado!.nombreEmpleado;
    pedido.empleado = data.empleado;
    pedido.moneda = data.moneda;
    pedido.personaContacto = data.codigoPersonaDeContacto;
    pedido.contacto = data.contacto;
    pedido.linesPedido = itemPedidoToLinesOrder(data.linesOrder!);
    pedido.usuarioVentaFacil = data.usuarioVentaFacil;
    pedido.latitud = data.latitud;
    pedido.longitud = data.longitud;
    pedido.fechaRegistroApp = data.fechaRegistroApp;
    pedido.horaRegistroApp = data.horaRegistroApp;
    pedido.descuento = data.descuento;
    pedido.impuesto = data.impuesto;
    pedido.total = data.total;
    return pedido;
  }

  static List<ItemPedido> itemPedidoToLinesOrder(List<LinesOrder> data) {
    List<ItemPedido> listaItem = [];
    for (var element in data) {
      ItemPedido item = ItemPedido();
      item.numeroDeLinea = element.numeroDeLinea;
      item.codigo = element.codigo;
      item.descripcion = element.descripcion;
      item.descripcionAdicional = element.descripcionAdicional;
      item.cantidad = element.cantidad;
      item.descuento = element.descuento;
      item.precioPorUnidad = element.precioUnitario;
      item.indicadorDeImpuestos = "IVA";
      item.codigoUnidadMedida = element.codigoUnidadMedida;
      item.nombreUnidadMedida = element.unidadDeMedida;
      item.fechaDeEntrega = element.fechaDeEntrega;
      listaItem.add(item);
    }
    return listaItem;
  }
}
