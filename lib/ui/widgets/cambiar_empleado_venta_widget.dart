// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/repository/sales_employee_repository.dart';
import 'package:ventas_facil/ui/widgets/item_nuevo_pedido_widget.dart';

class CambiarEmpleadoVentaWidget extends StatefulWidget {
  CambiarEmpleadoVentaWidget({required this.empleadoSeleccionado, super.key});

  EmpleadoVenta empleadoSeleccionado = EmpleadoVenta();

  @override
  State<CambiarEmpleadoVentaWidget> createState() => _CambiarEmpleadoVentaWidgetState();
}

class _CambiarEmpleadoVentaWidgetState extends State<CambiarEmpleadoVentaWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalesEmployeeBloc(SalesEmployeeRepository())..add(GetSalesEmployeeById(widget.empleadoSeleccionado)),
      child: BlocBuilder<SalesEmployeeBloc, SalesEmployeeState>(
        builder: (context, state) {
          if(state is SalesEmployeeLoading){
            return const Center(child: CircularProgressIndicator(),);
          } else if(state is SalesEmployeeByIdLoaded){
            widget.empleadoSeleccionado = state.empleado;
            // widget.empleadoSeleccionado.codigoEmpleado = widget.empleadoSeleccionado.codigoEmpleado;
            // widget.empleadoSeleccionado.nombreEmpleado = widget.empleadoSeleccionado.nombreEmpleado;
            return ItemNuevoPedidoWidget(
              titulo: 'Empleado de Venta', 
              valor: '${widget.empleadoSeleccionado.nombreEmpleado}', // '${state.empleado.nombreEmpleado}', 
              isSeleccionable: true, 
              onPush: () async {
                final result = await context.push<EmpleadoVenta>('/EmpleadoVentas', extra: widget.empleadoSeleccionado);
                if (result != null){
                  setState(() {
                    widget.empleadoSeleccionado = result;
                    state.empleado = result;
                  });
                }
              },
            );
          } else if(state is SalesEmployeeError){
            return const Center(child: Text('Ocurrio un error al cargar los datos'),);
          }
          return const Center(child: Text('Requerido'),);
        },
      ),
    );
  }
}