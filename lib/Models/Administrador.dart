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
            value.idAdmin = key;
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
  String? detallesContactoAdmin;
  String? idAdmin;
  String? nombreAdmin;
  AdministradorModel({
    this.apellidoAdmin,
    this.detallesContactoAdmin,
    this.idAdmin,
    this.nombreAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'ApellidoAdmin': apellidoAdmin,
      'DetallesContactoAdmin': detallesContactoAdmin,
      'IDAdmin': idAdmin,
      'NombreAdmin': nombreAdmin,
    };
  }

  factory AdministradorModel.fromMap(Map<String, dynamic> map) {
    return AdministradorModel(
      apellidoAdmin: map['ApellidoAdmin'],
      detallesContactoAdmin: map['DetallesContactoAdmin'],
      idAdmin: map['IDAdmin'],
      nombreAdmin: map['NombreAdmin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdministradorModel.fromJson(String source) =>
      AdministradorModel.fromMap(json.decode(source));
}
