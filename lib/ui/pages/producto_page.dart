import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/bloc/bloc.dart';

class ProductoPage extends StatefulWidget {
  const ProductoPage({super.key});

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductoBloc>(context).add(LoadProductos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: BlocConsumer<ProductoBloc, ProductoState>(
        listener: (context, state) {
          if (state is ProductoError){
            context.go('/login');
          } else if(state is ProductosNotLoaded){
            context.go('/login');
          }
        },
        builder: (context, state) {
          if (state is ProductosLoading) {
            return CircularProgressIndicator();
          } else if (state is ProductosLoaded) {
            return ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox();
            },
              itemCount: state.productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.productos[index].nombre!),
                  subtitle: Text(state.productos[index].fechaRegistro.toString()),
                );
              },
            );
          } else if (state is ProductosEmpty) {
            return Center(child: Text("No hay productos disponibles."));
          } else if (state is ProductosUnauthorized) {
            return Text('state.message');
          } else {
            return Container(child: Text('Container'),); // Estado inicial o desconocido
          }
        },
      )
    );
  }
}