import 'dart:convert';

class Residente {
  List<ResidenteModel> residenteList = [];
  List<ResidenteModel> residenteListbyUser = [];

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
  Residente.fromJsonListById(jsonList, idUser) {
    if (idUser == null) {
      return;
    } else {
      jsonList.forEach((id, val) {
          try {
            final value = ResidenteModel.fromMap(val);
            value.id = id;
          if (value.idUser == idUser) {
            residenteListbyUser.add(value);
          }
          } catch (e) {
            throw Error();
          }
        }
      );
    }
  }
}
 


class ResidenteModel {
  String? id;
  String? nombreResidente;
  String? apellidoResidente;
  String? numApartamento;
  String? numTelefono;
  String? idUser;
  ResidenteModel({
    this.id,
    this.nombreResidente,
    this.apellidoResidente,
    this.numApartamento,
    this.numTelefono,
    this.idUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'NombreResidente': nombreResidente,
      'ApellidoResidente': apellidoResidente,
      'NumApartamento': numApartamento,
      'NumTelefono': numTelefono,
      'idUser': idUser,
    };
  }

  factory ResidenteModel.fromMap(Map<String, dynamic> map) {
    return ResidenteModel(
      id: map['id'],
      nombreResidente: map['NombreResidente'],
      apellidoResidente: map['ApellidoResidente'], 
      numApartamento: map['NumApartamento'],
      numTelefono: map['NumTelefono'],
      idUser: map['idUser'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidenteModel.fromJson(String source) =>
      ResidenteModel.fromMap(json.decode(source));
}
