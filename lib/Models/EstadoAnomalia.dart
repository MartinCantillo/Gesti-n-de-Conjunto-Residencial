import 'dart:convert';

class EstadoAnomalia {
  List<EstadoAnomaliaModel> anomaliaList = [];

  EstadoAnomalia.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      json.list.forEach((key, val) {
        if (json is Map<String, dynamic>) {
          try {
            final value = EstadoAnomaliaModel.fromJson(json as String);
            value.idAdmin = key;
            anomaliaList.add(value);
          } catch (e) {
            throw Error();
          }
        }
      });
    }
  }
}

class EstadoAnomaliaModel {
  String? estado;
  String? idAdmin;
  String? idEstadoAnomalia;
  EstadoAnomaliaModel({
    this.estado,
    this.idAdmin,
    this.idEstadoAnomalia,
  });

  Map<String, dynamic> toMap() {
    return {
      'estado': estado,
      'idAdmin': idAdmin,
      'idEstadoAnomalia': idEstadoAnomalia,
    };
  }

  factory EstadoAnomaliaModel.fromMap(Map<String, dynamic> map) {
    return EstadoAnomaliaModel(
      estado: map['estado'],
      idAdmin: map['idAdmin'],
      idEstadoAnomalia: map['idEstadoAnomalia'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EstadoAnomaliaModel.fromJson(String source) =>
      EstadoAnomaliaModel.fromMap(json.decode(source));
}
