import 'dart:convert';

class Residente {
  List<ResidenteModel> residenteList = [];
  List<ResidenteModel> residenteListbyUser = [];

  Residente.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        try {
          final value = ResidenteModel.fromMap(item);
          residenteList.add(value);
        } catch (e) {
          print('Error processing JSON: $e');
          throw Exception("Error al mapear ResidenteModel");
        }
      }
    }
  }

Residente.fromJsonListById(Map<String, dynamic> json) {
  if (json == null) {
    return;
  } else {
    try {
      json.forEach((key, value) {
        print(value);
        if (value is Map<String, dynamic>) {
          final val = ResidenteModel.fromMap(json);
          residenteListbyUser.add(val);
        } else {
          throw Exception("Error al deserializar los datos");
        }
      });
    } catch (e) {
      throw Exception(e);
    }
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
      'nombreResidente': nombreResidente,
      'apellidoResidente': apellidoResidente,
      'numApartamento': numApartamento,
      'numTelefono': numTelefono,
      'idUser': idUser,
    };
  }

  factory ResidenteModel.fromMap(Map<String, dynamic> map) {
  
    return ResidenteModel(
      id: map['id']?.toString()??"",
      nombreResidente: map['nombreResidente']??"",
      apellidoResidente: map['apellidoResidente']??"",
      numApartamento: map['numApartamento']?.toString()??"",
      numTelefono: map['numTelefono']?.toString()??"",
      idUser: map['IdUser']?.toString()??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidenteModel.fromJson(String source) =>
      ResidenteModel.fromMap(json.decode(source));
}