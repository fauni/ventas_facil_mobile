class Usuario {
  final String id;
  final String nombre;
  final String apellido;
  final String userName;
  final String email;
  final bool emailConfirmed;
  final String passwordHash;
  final String apiToken;
  final String phoneNumber;
  final bool phoneNumberConfirmed;
  final bool twoFactorEnabled;
  final dynamic lockoutEnd; // Puede ser nulo, así que usamos dynamic
  final bool lockoutEnabled;
  final int accessFailedCount;
  final int idCompany;
  final String imagen;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.userName,
    required this.email,
    required this.emailConfirmed,
    required this.passwordHash,
    required this.apiToken,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    this.lockoutEnd,
    required this.lockoutEnabled,
    required this.accessFailedCount,
    required this.idCompany,
    required this.imagen,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      userName: json['userName'],
      email: json['email'],
      emailConfirmed: json['emailConfirmed'] == 'true'? true: false,
      passwordHash: json['passwordHash'],
      apiToken: json['apiToken'],
      phoneNumber: json['phoneNumber'],
      phoneNumberConfirmed: json['phoneNumberConfirmed'] == 'true'? true: false,
      twoFactorEnabled: json['twoFactorEnabled'] == 'true'? true: false,
      lockoutEnd: json['lockoutEnd'],
      lockoutEnabled: json['lockoutEnabled'] == 'true'? true: false,
      accessFailedCount: json['accessFailedCount'],
      idCompany: json['idCompany'],
      imagen: json['imagen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'userName': userName,
      'email': email,
      'emailConfirmed': emailConfirmed ? 1 : 0,
      'passwordHash': passwordHash,
      'apiToken': apiToken,
      'phoneNumber': phoneNumber,
      'phoneNumberConfirmed': phoneNumberConfirmed ? 1 : 0,
      'twoFactorEnabled': twoFactorEnabled ? 1 : 0,
      'lockoutEnd': lockoutEnd, // Asegúrate de manejar esto correctamente en tu DB
      'lockoutEnabled': lockoutEnabled ? 1 : 0,
      'accessFailedCount': accessFailedCount,
      'idCompany': idCompany,
      'imagen': imagen,
    };
  }
}
