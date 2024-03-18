

import 'package:ventas_facil/models/pedido/item_pedido.dart';
import 'package:ventas_facil/models/venta/pedido.dart';
import 'package:ventas_facil/models/venta/pedido_list.dart';

class MapGeneric {
  static Pedido pedidoListToPedido(PedidoList data){
    Pedido pedido = Pedido(linesPedido: []);
    pedido.id =
    pedido.codigoSap = data.codigoSap;
    pedido.nombreFactura = data.nombreFactura;
    pedido.nitFactura = data.nitFactura;
    pedido.diasPlazo = 0;
    pedido.fechaEntrega = data.fechaDeEntrega;
    pedido.tipoCambio = 0;
    pedido.observacion = data.comentarios;
    pedido.fechaRegistro = data.fechaDelDocumento;
    pedido.estado = data.estado;
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
    pedido.ubicacion = data.ubicacion;
    pedido.descuento = data.descuento;
    pedido.impuesto = data.impuesto;
    pedido.total = data.total;
    return pedido;
  }

  static List<ItemPedido> itemPedidoToLinesOrder(List<LinesOrder> data){
    List<ItemPedido> listaItem = [];
    for (var element in data) {
      ItemPedido item = ItemPedido();
      item.codigo = element.codigo;
      item.descripcion = element.descripcion;
      item.cantidad = element.cantidad;
      item.precioPorUnidad = element.precioUnitario;
      item.indicadorDeImpuestos = "IVA";
      listaItem.add(item);
    }
    return listaItem;
  }
}