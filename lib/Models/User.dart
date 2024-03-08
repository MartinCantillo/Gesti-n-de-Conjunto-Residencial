import 'dart:convert';

class User {
  List<UserModel> adminList = [];

  User.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      json.list.forEach((key, val) {
        if (json is Map<String, dynamic>) {
          try {
            final value = UserModel.fromJson(json as String);
            value.idUsuario = key;
            adminList.add(value);
          } catch (e) {
            throw Error();
          }
        }
      });
    }
  }
}

class UserModel {
  String? idUsuario;
  String? username;
  String? password;
  UserModel({
    this.idUsuario,
    this.username,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'Username"': username,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      idUsuario: map['idUsuario'],
      username: map['Username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
