// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    String? userName;
    String? passwordHash;
    int? idCompany;

    Login({
        this.userName,
        this.passwordHash,
        this.idCompany
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        userName: json["userName"],
        passwordHash: json["passwordHash"],
        idCompany: json["idCompany"]
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "passwordHash": passwordHash,
        "idCompany": idCompany
    };
}
