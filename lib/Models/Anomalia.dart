import 'package:gestionresidencial/Models/Residente.dart';

class Anomalia {
  int _codigoA;
  DateTime _fechaReporte;
  String _descripcion;
  String _tipo;
  String _estado;
  String _foto;
  Residente _residente;

  Anomalia(
      {required int codigo,
      required DateTime fechaReporte,
      required String descripcion,
      required String tipo,
      required String estado,
      required String foto,
      required Residente residente})
      : _codigoA = codigo,
        _fechaReporte = fechaReporte,
        _descripcion = descripcion,
        _tipo = tipo,
        _estado = estado,
        _foto = foto,
        _residente = residente;

  int get getCodigoA => _codigoA;
  set setCodigo(int codigo) {
    if (codigo <= 0) {
      throw ("Por favor verifica");
    }
    _codigoA = codigo;
  }

  DateTime get getFechaReporte => _fechaReporte;
  set setFechaREporte(DateTime fechaReporte) {
    _fechaReporte = fechaReporte;
  }

  String get getDescripcion => _descripcion;
  set setDescripcion(String descripcion) {
    if (descripcion == "") {
      throw ("Por favor verifica");
    }
    _descripcion = descripcion;
  }

  String get getTipo => _tipo;
  set setTiipo(String tipo) {
    if (tipo == "") {
      throw ("Por favor verifica");
    }
    _tipo = tipo;
  }

  String get getEstado => _estado;
  set setEstado(String estado) {
    if (estado == "") {
      throw ("Por favor verifica");
    }
    _estado = estado;
  }

  String get getFoto => _foto;
  set setFoto(String foto) {
    if (foto == "") {
      throw ("Por favor verifica");
    }
    _foto = foto;
  }

  Residente get getResidente => _residente;
  set setResidente(Residente residente) {
    _residente = residente;
  }
}
