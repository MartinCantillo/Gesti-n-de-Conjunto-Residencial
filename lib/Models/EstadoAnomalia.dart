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
  String? fecha;
  EstadoAnomaliaModel({
    this.estado,
    this.id,
    this.idEstadoAnomalia,
    this.fecha
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'estado': estado,
      'idEstadoAnomalia': idEstadoAnomalia,
      'fecha': fecha
    };
  }

  factory EstadoAnomaliaModel.fromMap(Map<String, dynamic> map) {
    return EstadoAnomaliaModel(
      id: map['id'],
      estado: map['estado'],
      idEstadoAnomalia: map['idEstadoAnomalia'],
      fecha: map['fecha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EstadoAnomaliaModel.fromJson(String source) =>
      EstadoAnomaliaModel.fromMap(json.decode(source));
}
