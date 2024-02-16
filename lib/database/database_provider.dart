import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ventas_facil/models/usuario.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db" es el nombre de nuestra base de datos
    String path = join(documentsDirectory.path, "UserDatabase.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //Será llamado al crear la base de datos
  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE Usuario ("
        "id TEXT PRIMARY KEY, "
        "nombre TEXT, "
        "apellido TEXT, "
        "userName TEXT, "
        "email TEXT, "
        "emailConfirmed BIT, "
        "passwordHash TEXT, "
        "apiToken TEXT, "
        "phoneNumber TEXT, "
        "phoneNumberConfirmed BIT, "
        "twoFactorEnabled BIT, "
        "lockoutEnd TEXT, "
        "lockoutEnabled BIT, "
        "accessFailedCount INTEGER, "
        "idCompany INTEGER, "
        "imagen TEXT"
        ")");
  }

  // Usado para realizar actualizaciones a la base de datos
  void onUpgrade(Database database, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      // Si tienes una nueva versión, puedes realizar actualizaciones a la estructura aquí
    }
  }

  Future<int> insertUsuario(Usuario usuario) async {
    final db = await database;
    var result = db.insert(
      "Usuario", 
      usuario.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    return result;
  }

  Future<List<Usuario>> getUsuarios() async {
    final db = await database;
    var result = await db.query("Usuario");
    List<Usuario> usuarios = result.isNotEmpty ? result.map((item) => Usuario.fromJson(item)).toList() : [];
    return usuarios;
  }
}