import 'dart:convert';

class User {
  List<UserModel> userList = [];
  List<UserModel> usersAuthenticatedList = [];
  User.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      json.list.forEach((key, val) {
        if (json is Map<String, dynamic>) {
          try {
            final value = UserModel.fromJson(json as String);
            value.id = key;
            userList.add(value);
          } catch (e) {
            throw Error();
          }
        }
      });
    }
  }
  User.fromJsonListUserAuthenticate(mapList, String username, String password) {
    if (mapList == null || username == "" || password == "") {
      return;
    } else {
      mapList.forEach((key, val) {
        try {
          final value = UserModel.fromMap(val);
          if (value.username == username && value.password == password) {
            usersAuthenticatedList.add(value);
          }
        } catch (e) {
          throw Exception("Usuario no encontrado o incorrectos");
        }
      });
    }
  }
}

class UserModel {
  String? id;
  String? username;
  String? password;
  UserModel({
    this.id,
    this.username,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': id,
      'Username"': username,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['Username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
