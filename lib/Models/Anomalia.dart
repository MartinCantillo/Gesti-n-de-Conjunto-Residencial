import 'dart:convert';

class Anomalia {
  List<AnomaliaModel> anomaliaList = [];

  Anomalia.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      json.list.forEach((key, val) {
        if (json is Map<String, dynamic>) {
          try {
            final value = AnomaliaModel.fromJson(json as String);
            value.idAnomalia = key;
            anomaliaList.add(value);
          } catch (e) {
            throw Error();
          }
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
  String? idAnomalia;
  String? idEstadoAnomalia;
  String? idResidente;
  AnomaliaModel({
    this.descripcionAnomalia,
    this.fechaReporteAnomalia,
    this.fotoAnomalia,
    this.idAnomalia,
    this.idEstadoAnomalia,
    this.idResidente,
    this.asuntoAnomalia,
    this.tipoAnomalia,
  });

  Map<String, dynamic> toMap() {
    return {
      ' DescripcionAnomalia': descripcionAnomalia,
      'FechaReporteAnomalia': fechaReporteAnomalia,
      'FotoAnomalia': fotoAnomalia,
      'IDAnomalia': idAnomalia,
      'IDEstadoAnomalia': idEstadoAnomalia,
      'IDResidente': idResidente,
      'tipoAnomalia': tipoAnomalia,
      'asuntoAnomalia': asuntoAnomalia,
    };
  }

  factory AnomaliaModel.fromMap(Map<String, dynamic> map) {
    return AnomaliaModel(
      descripcionAnomalia: map['DescripcionAnomalia'],
      fechaReporteAnomalia: map['FechaReporteAnomalia'],
      fotoAnomalia: map['FotoAnomalia'],
      idAnomalia: map['IDAnomalia'],
      idEstadoAnomalia: map['IDEstadoAnomalia'],
      idResidente: map['IDResidente'],
      tipoAnomalia:map['tipoAnomalia'],
      asuntoAnomalia :map['asuntoAnomalia'], 
    );
  }

  String toJson() => json.encode(toMap());

  factory AnomaliaModel.fromJson(String source) =>
      AnomaliaModel.fromMap(json.decode(source));
}
