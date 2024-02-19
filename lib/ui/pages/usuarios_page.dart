import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ventas_facil/bloc/bloc.dart';
class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  DateTime? _lastSyncDate;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UsuarioBloc>(context).add(LoadLocalUsuarios());
    BlocProvider.of<UsuarioBloc>(context).add(LoadLastSyncDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        actions: [
          IconButton(
            onPressed: (){
              BlocProvider.of<UsuarioBloc>(context).add(LoadUsuarios());
            }, 
            icon: const Icon(Icons.refresh)
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context).add(ThemeToggle());
            }, 
            icon: const Icon(Icons.light_mode)
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<UsuarioBloc>(context).add(LoadUsuarios());   
        },
        tooltip: 'Descargar Usuarios',
        child: const Icon(Icons.download),
      ),
      body: Column(
        children: [
          if(_lastSyncDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Última sincronización: ${DateFormat('dd/MM/yyyy hh:mm:ss').format(_lastSyncDate!)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          Expanded(
            child: BlocConsumer<UsuarioBloc, UsuarioState>(
              listener: (context, state) {
                if(state is LastSyncDateLoaded){
                  setState(() {
                    _lastSyncDate = state.lastSyncDate;
                  });
                } else if (state is UsuariosLoaded){
                  setState(() {
                    _lastSyncDate = state.lastSynced;
                  });
                }
              },
              builder: (context, state) {
                if(state is UsuariosLoading){
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is UsuariosLoaded){
                  return ListView.builder(
                    itemCount: state.usuarios.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('${state.usuarios[index].nombre} ${state.usuarios[index].apellido}'),
                        subtitle: Text(state.usuarios[index].email),
                      );
                    },
                  );
                } else if (state is UsuariosLoadLocalSuccess){
                  return ListView.builder(
                    itemCount: state.usuarios.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('${state.usuarios[index].nombre} ${state.usuarios[index].apellido}'),
                        subtitle: Text(state.usuarios[index].email),
                      );
                    },
                  );
                } else if (state is UsuariosNotLoaded) {
                  return Center(child: Text('Error al cargar usuarios: ${state.error}'),);
                }
                return const Center(child: Text('Estado no soportado'),);
              },
            ),
          ),
        ],
      ),
    );
  }
}