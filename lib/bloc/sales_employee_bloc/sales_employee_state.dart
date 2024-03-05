import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';

abstract class SalesEmployeeState {
  const SalesEmployeeState();
}

class SalesEmployeeInitial extends SalesEmployeeState{}

class SalesEmployeeLoading extends SalesEmployeeState{}

class SalesEmployeeLoaded extends SalesEmployeeState{
  final List<EmpleadoVenta> empleados;
  const SalesEmployeeLoaded(this.empleados);
}

class SalesEmployeeByIdLoaded extends SalesEmployeeState{
  EmpleadoVenta empleado;
  
  SalesEmployeeByIdLoaded(this.empleado);
}

class SalesEmployeeError extends SalesEmployeeState{
  final String message;

  const SalesEmployeeError(this.message);
}

class SalesEmployeeUnauthorized extends SalesEmployeeState{}
class SalesEmployeeEmpty extends SalesEmployeeState{}