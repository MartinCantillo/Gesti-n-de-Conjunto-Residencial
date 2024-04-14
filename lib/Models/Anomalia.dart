import 'dart:convert';

import 'package:gestionresidencial/Models/EstadoAnomalia.dart';

class Anomalia {
  List<AnomaliaModel> anomaliaList = [];
  List<AnomaliaModel> anomaliaListByUser = [];
  List<EstadoAnomaliaModel> estadoanomaliaList = [];

  Anomalia.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      //print(json);
      json.forEach((id, val) {
        try {
          final value = AnomaliaModel.fromMap(val);
          value.id = id;
          anomaliaList.add(value);
        } catch (e) {
          throw Error();
        }
      });
    }
  }
  Anomalia.fromJsonListById(jsonList, idUser) {
    if (idUser == "") {
      return;
    } else {
      jsonList.forEach((id, val) {
        try {
          final value = AnomaliaModel.fromMap(val);

          if (value.idUser == idUser) {
            anomaliaListByUser.add(value);
          }
        } catch (e) {
          throw Exception("error $e");
        }
      });
    }
  }
}

class AnomaliaModel {
  String? descripcionAnomalia;
  String? fechaReporteAnomalia;
  String? fotoAnomalia;
  String? tipoAnomalia;
  String? asuntoAnomalia;
  String? id;
  String? idEstadoAnomalia;
  String? idUser;
  AnomaliaModel({
    this.descripcionAnomalia,
    this.fechaReporteAnomalia,
    this.fotoAnomalia,
    this.id,
    this.idEstadoAnomalia,
    this.idUser,
    this.asuntoAnomalia,
    this.tipoAnomalia,
  });

  Map<String, dynamic> toMap() {
    return {
      'DescripcionAnomalia': descripcionAnomalia,
      'FechaReporteAnomalia': fechaReporteAnomalia,
      'FotoAnomalia': fotoAnomalia,
      'id': id,
      'IDEstadoAnomalia': idEstadoAnomalia,
      'idUser': idUser,
      'tipoAnomalia': tipoAnomalia,
      'asuntoAnomalia': asuntoAnomalia,
    };
  }

  factory AnomaliaModel.fromMap(Map<String, dynamic> map) {
   
    try {
      return AnomaliaModel(
        id: map['id'] ?? "",
        tipoAnomalia: map['tipoAnomalia'] ?? "",
        asuntoAnomalia: map['asuntoAnomalia'] ?? "",
        descripcionAnomalia: map['DescripcionAnomalia'] ?? "",
        fechaReporteAnomalia: map['FechaReporteAnomalia'] ?? "",
        fotoAnomalia: map['FotoAnomalia'] ?? "",
        idEstadoAnomalia: map['IDEstadoAnomalia'] ?? "",
        idUser: map['idUser'] ?? "",
      );
    } catch (e) {
      throw Exception("error$e");
    }
  }

  String toJson() => json.encode(toMap());

  factory AnomaliaModel.fromJson(String source) =>
      AnomaliaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AnomaliaModel(descripcionAnomalia: $descripcionAnomalia, fechaReporteAnomalia: $fechaReporteAnomalia, fotoAnomalia: $fotoAnomalia, tipoAnomalia: $tipoAnomalia, asuntoAnomalia: $asuntoAnomalia, id: $id, idEstadoAnomalia: $idEstadoAnomalia, idUser: $idUser)';
  }
}
