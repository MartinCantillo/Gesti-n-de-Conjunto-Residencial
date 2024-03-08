import 'dart:convert';

class Residente {
  String? detallesContactoResidente;
  String? idResidente;
  String? nombreResidente;
  String? numApartamento;
  Residente({
    this.detallesContactoResidente,
    this.idResidente,
    this.nombreResidente,
    this.numApartamento,
  });

  Map<String, dynamic> toMap() {
    return {
      'DetallesContactoResidente': detallesContactoResidente,
      'IDResidente': idResidente,
      'NombreResidente': nombreResidente,
      'NumApartamento': numApartamento,
    };
  }

  factory Residente.fromMap(Map<String, dynamic> map) {
    return Residente(
      detallesContactoResidente: map['DetallesContactoResidente'],
      idResidente: map['IDResidente'],
      nombreResidente: map['NombreResidente'],
      numApartamento: map['NumApartamento'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Residente.fromJson(String source) =>
      Residente.fromMap(json.decode(source));
}
