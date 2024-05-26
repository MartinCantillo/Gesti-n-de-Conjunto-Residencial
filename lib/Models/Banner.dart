import 'dart:convert';

class BannerList {
  List<BannerModel> bannerList = [];

  BannerList.fromJsonList(json) {
    if (json == null) {
      return;
    } else {
      //print(json);
      json.forEach((id, val) {
        try {
          final value = BannerModel.fromMap(val);
          value.id = id;
          bannerList.add(value);
        } catch (e) {
          throw Error();
        }
      });
    }
  }
}

class BannerModel {
  String? titulo;
  String? id;
  String? descripcion;
  String? fecha;
  BannerModel({
    this.titulo,
    this.id,
    this.descripcion,
    this.fecha
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'estado': titulo,
      'idEstadoBanner': descripcion,
      'fecha': fecha
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'],
      titulo: map['estado'],
      descripcion: map['idEstadoBanner'],
      fecha: map['fecha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));
}
