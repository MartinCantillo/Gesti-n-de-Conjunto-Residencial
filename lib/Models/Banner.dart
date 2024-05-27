import 'dart:convert';

import 'package:flutter/material.dart';

class BannerList {
  List<BannerModel> bannerList = [];

  BannerList.fromJsonList(List<dynamic> json) {
    if (json == null) {
      return;
    } else {
      for (var item in json) {
        try {
          final value = BannerModel.fromMap(item);
          bannerList.add(value);
        } catch (e) {
          // Cambiar Error() a Exception()
          throw Exception("Error al mapear AnomaliaModel: $e");
        }
      }
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
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'].toString(),
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      fecha: map['fecha'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));
}
