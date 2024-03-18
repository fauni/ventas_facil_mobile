import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';

class EmpleadoVentaPage extends StatefulWidget {
  final EmpleadoVenta empleadoSeleccionado; 
  const EmpleadoVentaPage({super.key, required this.empleadoSeleccionado });

  @override
  State<EmpleadoVentaPage> createState() => _EmpleadoVentaPageState();
}

class _EmpleadoVentaPageState extends State<EmpleadoVentaPage> {
  EmpleadoVenta? newEmpleadoSeleccionado;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SalesEmployeeBloc>(context).add(GetSalesEmployee());
    newEmpleadoSeleccionado = widget.empleadoSeleccionado;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'Empleados de Venta'),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: (){
      //     GoRouter.of(context).pop(newEmpleadoSeleccionado);
      //   }, 
      //   label: const Text('Seleccionar'),
      //   icon: const Icon(Icons.check),
      // ),
      body: BlocConsumer<SalesEmployeeBloc, SalesEmployeeState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          if(state is SalesEmployeeLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is SalesEmployeeLoaded){
            return ListView.separated(
              itemBuilder: (context, index) {
                EmpleadoVenta empleado = state.empleados[index];
                bool isSelected = widget.empleadoSeleccionado.codigoEmpleado == empleado.codigoEmpleado;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    child: isSelected ? const Icon(Icons.check) : const Icon(Icons.info_outline),
                  ),
                  selected: isSelected,
                  title: Text(empleado.nombreEmpleado!),
                  onTap: () {
                    newEmpleadoSeleccionado = empleado;
                    GoRouter.of(context).pop(empleado);
                  },
                );
              }, 
              separatorBuilder: (context, index) {
                return const Divider();
              }, 
              itemCount: state.empleados.length
            );
          } else {
            return const Text('Error al obtener los empleados');
          }
        },
      ),
    );
  }
}