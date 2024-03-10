import 'dart:convert';

class Residente {
  List<ResidenteModel> residenteList = [];

  Residente.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      json.list.forEach((key, val) {
        if (json is Map<String, dynamic>) {
          try {
            final value = ResidenteModel.fromJson(json as String);
            value.id = key;
            residenteList.add(value);
          } catch (e) {
            throw Error();
          }
        }
      });
    }
  }
}

class ResidenteModel {
  String? detallesContactoResidente;
  String? id;
  String? nombreResidente;
  String? numApartamento;
  String? numTelefono;
  String? idUser;
  ResidenteModel({
    this.detallesContactoResidente,
    this.id,
    this.nombreResidente,
    this.numApartamento,
    this.numTelefono,
    this.idUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'NombreResidente': nombreResidente,
      'NumApartamento': numApartamento,
      'NumTelefono': numTelefono,
      'idUser': idUser,
    };
  }

  factory ResidenteModel.fromMap(Map<String, dynamic> map) {
    return ResidenteModel(
      id: map['id'],
      nombreResidente: map['NombreResidente'],
      numApartamento: map['NumApartamento'],
      numTelefono: map['NumTelefono'],
      idUser: map['idUser'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidenteModel.fromJson(String source) =>
      ResidenteModel.fromMap(json.decode(source));
}
