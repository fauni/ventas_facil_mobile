import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_facil/database/database_provider.dart';
import 'package:ventas_facil/models/usuario.dart';
import 'package:ventas_facil/services/usuario_service.dart';

class UsuariosRepository {
  final UsuarioService _usuarioService;
  final DatabaseProvider _databaseProvider;

  UsuariosRepository(this._usuarioService, this._databaseProvider);

  Future<List<Usuario>> fetchAndStoreUsuarios() async {
    try {
      final usuarios = await _usuarioService.fetchUsuarios();
      for (var usuario in usuarios) {
        await _databaseProvider.insertUsuario(usuario);
      }
      return usuarios;
    } catch (e) {
      throw Exception('Error al obtener los usuarios: $e');
    }
  }

  Future<List<Usuario>> getLocalUsuarios() async {
    try {
      return await _databaseProvider.getUsuarios();
    } catch (e) {
      throw Exception('Error al obtener los usuarios de la bas ede datos $e');
    }
  }

  Future<DateTime?> getLastSyncDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? lastSyncString = prefs.getString('lastSync');
    if(lastSyncString != null){
      return DateTime.parse(lastSyncString);
    }
    return null;
  }
}