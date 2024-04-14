import 'dart:convert';

class Administrador {
  List<AdministradorModel> adminList = [];

  Administrador.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      json.list.forEach((key, val) {
        if (json is Map<String, dynamic>) {
          try {
            final value = AdministradorModel.fromJson(json as String);
            value.id = key;
            adminList.add(value);
          } catch (e) {
            throw Error();
          }
        }
      });
    }
  }
}

class AdministradorModel {
  String? apellidoAdmin;
  String? telefono;
  String? id;
  String? nombreAdmin;
  AdministradorModel({
    this.apellidoAdmin,
    this.telefono,
    this.id,
    this.nombreAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'ApellidoAdmin': apellidoAdmin,
      'DetallesContactoAdmin': telefono,
      'id': id,
      'NombreAdmin': nombreAdmin,
    };
  }

  factory AdministradorModel.fromMap(Map<String, dynamic> map) {
    return AdministradorModel(
      apellidoAdmin: map['ApellidoAdmin'],
      telefono: map['telefono'],
      id: map['id'],
      nombreAdmin: map['NombreAdmin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdministradorModel.fromJson(String source) =>
      AdministradorModel.fromMap(json.decode(source));
}
