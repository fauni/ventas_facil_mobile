import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/bloc/producto_bloc/producto_event.dart';
import 'package:ventas_facil/bloc/producto_bloc/producto_state.dart';
import 'package:ventas_facil/config/helpers/exceptions.dart';
import 'package:ventas_facil/repository/producto_repository.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState>{
  final ProductoRepository _productoRepository;

  ProductoBloc(this._productoRepository) : super(ProductosLoading()){
    on<LoadProductos>(_onLoadProductos);
  }

  Future<void> _onLoadProductos(LoadProductos event, Emitter<ProductoState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token').toString();
    emit(ProductosLoading());
    try {
      final productos = await _productoRepository.getAllProductos(token);
      emit(ProductosLoaded(productos));
    } on UnauthorizedException catch(_){
      emit(ProductosUnauthorized());
    } on ProductsEmptyException catch(_){
      emit(ProductosEmpty());
    } catch(e){
      emit(ProductosNotLoaded(e.toString()));
    }
  }
}