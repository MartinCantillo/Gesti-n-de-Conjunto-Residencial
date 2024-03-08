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
  ResidenteModel({
    this.detallesContactoResidente,
    this.id,
    this.nombreResidente,
    this.numApartamento,
  });

  Map<String, dynamic> toMap() {
    return {
      'DetallesContactoResidente': detallesContactoResidente,
      'id': id,
      'NombreResidente': nombreResidente,
      'NumApartamento': numApartamento,
    };
  }

  factory ResidenteModel.fromMap(Map<String, dynamic> map) {
    return ResidenteModel(
      detallesContactoResidente: map['DetallesContactoResidente'],
      id: map['id'],
      nombreResidente: map['NombreResidente'],
      numApartamento: map['NumApartamento'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidenteModel.fromJson(String source) =>
      ResidenteModel.fromMap(json.decode(source));
}
