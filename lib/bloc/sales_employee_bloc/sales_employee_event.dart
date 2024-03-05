

import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';

abstract class SalesEmployeeEvent {
  const SalesEmployeeEvent();
}

class GetSalesEmployee extends SalesEmployeeEvent{}

class GetSalesEmployeeById extends SalesEmployeeEvent{
  final EmpleadoVenta empleado;

  GetSalesEmployeeById(this.empleado);
}
