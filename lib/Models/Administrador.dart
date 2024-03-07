import 'dart:convert';

import 'package:gestionresidencial/Models/Persona.dart';

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
      'apellidoAdmin': apellidoAdmin,
      'detallesContactoAdmin': detallesContactoAdmin,
      'idAdmin': idAdmin,
      'nombreAdmin': nombreAdmin,
    };
  }

  factory AdministradorModel.fromMap(Map<String, dynamic> map) {
    return AdministradorModel(
      apellidoAdmin: map['apellidoAdmin'],
      detallesContactoAdmin: map['detallesContactoAdmin'],
      idAdmin: map['idAdmin'],
      nombreAdmin: map['nombreAdmin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdministradorModel.fromJson(String source) =>
      AdministradorModel.fromMap(json.decode(source));
}
