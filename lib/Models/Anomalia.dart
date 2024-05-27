import 'dart:convert';

import 'package:gestionresidencial/Models/EstadoAnomalia.dart';

class Anomalia {
  List<AnomaliaModel> anomaliaList = [];
  List<AnomaliaModel> anomaliaListByUser = [];
  List<EstadoAnomaliaModel> estadoanomaliaList = [];

  Anomalia.fromJsonList(List<dynamic> json) {
    if (json == null) {
      return;
    } else {
      for (var item in json) {
        try {
          final value = AnomaliaModel.fromMap(item);
          anomaliaList.add(value);
        } catch (e) {
          // Cambiar Error() a Exception()
          throw Exception("Error al mapear AnomaliaModel: $e");
        }
      }
    }
  }

  Anomalia.fromJsonListById(List<dynamic> jsonList, String idUser) {
    if (idUser.isEmpty) {
      return;
    } else {
      for (var item in jsonList) {
        try {
          final value = AnomaliaModel.fromMap(item);
          if (value.IdUser == idUser) {
            anomaliaListByUser.add(value);
          }
        } catch (e) {
          // Cambiar Error() a Exception()
          throw Exception("Error al mapear AnomaliaModel por ID: $e");
        }
      }
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
  String? IdUser;
  String? prioridad;
  AnomaliaModel({
    this.descripcionAnomalia,
    this.fechaReporteAnomalia,
    this.fotoAnomalia,
    this.id,
    this.idEstadoAnomalia,
    this.IdUser,
    this.asuntoAnomalia,
    this.tipoAnomalia,
    this.prioridad,
  });

  Map<String, dynamic> toMap() {
    return {
      'descripcionAnomalia': descripcionAnomalia,
      'fechaReporteAnomalia': fechaReporteAnomalia,
      'fotoAnomalia': fotoAnomalia,
      'id': id,
      'idEstadoAnomalia': idEstadoAnomalia,
      'IdUser': IdUser,
      'tipoAnomalia': tipoAnomalia,
      'asuntoAnomalia': asuntoAnomalia,
      'prioridad': prioridad,
    };
  }

  factory AnomaliaModel.fromMap(Map<String, dynamic> map) {
    try {
      return AnomaliaModel(
        id: map['id']?.toString() ?? "",
        tipoAnomalia: map['tipoAnomalia'] ?? "",
        asuntoAnomalia: map['asuntoAnomalia'] ?? "",
        descripcionAnomalia: map['descripcionAnomalia'] ?? "",
        fechaReporteAnomalia: map['FechaReporteAnomalia'] ?? "",
        fotoAnomalia: map['FotoAnomalia'] ?? "",
        idEstadoAnomalia: map['IDEstadoAnomalia'] ?? "",
        IdUser: map['idUser']?.toString() ?? "",
        prioridad: map['prioridad']?.toString() ?? "",
      );
    } catch (e) {
      // print("Entro");
      throw Exception("error de a ui$e");
    }
  }

  String toJson() => json.encode(toMap());

  factory AnomaliaModel.fromJson(String source) =>
      AnomaliaModel.fromMap(json.decode(source));
}
