import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/sales_employee_bloc/sales_employee_event.dart';
import 'package:ventas_facil/bloc/sales_employee_bloc/sales_employee_state.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/models/empleado_venta/empleado_venta.dart';
import 'package:ventas_facil/repository/sales_employee_repository.dart';

class SalesEmployeeBloc extends Bloc<SalesEmployeeEvent, SalesEmployeeState>{
  final SalesEmployeeRepository _employeeRepository;
  SalesEmployeeBloc(this._employeeRepository): super(SalesEmployeeInitial()){
    on<GetSalesEmployee>(_onLoadSalesEmployees);
    on<GetSalesEmployeeById>(_onLoadSalesEmployee);
  }

  Future<void> _onLoadSalesEmployees(GetSalesEmployee event, Emitter<SalesEmployeeState> emit) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(SalesEmployeeLoading());
    try {
      List<EmpleadoVenta> empleados = await _employeeRepository.getAllEmpleados(token);
      emit(SalesEmployeeLoaded(empleados));
    } on UnauthorizedException catch(_){
      emit(SalesEmployeeUnauthorized());
    } on GenericEmptyException catch(_){
      emit(SalesEmployeeEmpty());
    } catch (e) {
      emit(SalesEmployeeError(e.toString()));
    }
  }

  Future<void> _onLoadSalesEmployee(GetSalesEmployeeById event, Emitter<SalesEmployeeState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(SalesEmployeeLoading());
    try {
      final empleado = await _employeeRepository.getEmpleadoById(token, event.empleado);
      emit(SalesEmployeeByIdLoaded(empleado));
    } catch (e) {
      emit( const SalesEmployeeError('Ocurrio un error al obtener el Empleado'));
    }
  }
}