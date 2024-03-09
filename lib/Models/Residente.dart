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
  ResidenteModel({
    this.id,
    this.nombreResidente,
    this.numApartamento,
    this.numTelefono,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'NombreResidente': nombreResidente,
      'NumApartamento': numApartamento,
      'NumTelefono': numTelefono,
    };
  }

  factory ResidenteModel.fromMap(Map<String, dynamic> map) {
    return ResidenteModel(
      id: map['id'],
      nombreResidente: map['NombreResidente'],
      numApartamento: map['NumApartamento'],
      numTelefono: map['NumTelefono'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidenteModel.fromJson(String source) =>
      ResidenteModel.fromMap(json.decode(source));
}
