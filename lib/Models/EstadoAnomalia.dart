import 'dart:convert';

class EstadoAnomalia {
  List<EstadoAnomaliaModel> estadoanomaliaList = [];

  EstadoAnomalia.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      json.list.forEach((key, val) {
        if (json is Map<String, dynamic>) {
          try {
            final value = EstadoAnomaliaModel.fromJson(json as String);
            value.id = key;
            estadoanomaliaList.add(value);
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
  String? id;
  String? idEstadoAnomalia;
  EstadoAnomaliaModel({
    this.estado,
    this.id,
    this.idEstadoAnomalia,
  });

  Map<String, dynamic> toMap() {
    return {
      'estado': estado,
      'id': id,
      'idEstadoAnomalia': idEstadoAnomalia,
    };
  }

  factory EstadoAnomaliaModel.fromMap(Map<String, dynamic> map) {
    return EstadoAnomaliaModel(
      estado: map['estado'],
      id: map['id'],
      idEstadoAnomalia: map['idEstadoAnomalia'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EstadoAnomaliaModel.fromJson(String source) =>
      EstadoAnomaliaModel.fromMap(json.decode(source));
}
