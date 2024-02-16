// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String? id;
    String? nombre;
    String? apellido;
    String? userName;
    String? email;
    bool? emailConfirmed;
    String? passwordHash;
    String? apiToken;
    String? phoneNumber;
    bool? phoneNumberConfirmed;
    bool? twoFactorEnabled;
    dynamic lockoutEnd;
    bool? lockoutEnabled;
    int? accessFailedCount;
    int? idCompany;
    String? imagen;

    User({
        this.id,
        this.nombre,
        this.apellido,
        this.userName,
        this.email,
        this.emailConfirmed,
        this.passwordHash,
        this.apiToken,
        this.phoneNumber,
        this.phoneNumberConfirmed,
        this.twoFactorEnabled,
        this.lockoutEnd,
        this.lockoutEnabled,
        this.accessFailedCount,
        this.idCompany,
        this.imagen,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        userName: json["userName"],
        email: json["email"],
        emailConfirmed: json["emailConfirmed"],
        passwordHash: json["passwordHash"],
        apiToken: json["apiToken"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        twoFactorEnabled: json["twoFactorEnabled"],
        lockoutEnd: json["lockoutEnd"],
        lockoutEnabled: json["lockoutEnabled"],
        accessFailedCount: json["accessFailedCount"],
        idCompany: json["idCompany"],
        imagen: json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "userName": userName,
        "email": email,
        "emailConfirmed": emailConfirmed,
        "passwordHash": passwordHash,
        "apiToken": apiToken,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "twoFactorEnabled": twoFactorEnabled,
        "lockoutEnd": lockoutEnd,
        "lockoutEnabled": lockoutEnabled,
        "accessFailedCount": accessFailedCount,
        "idCompany": idCompany,
        "imagen": imagen,
    };
}
