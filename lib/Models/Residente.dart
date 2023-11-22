import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/Models/Persona.dart';

class Residente extends Persona {
  int _numApartamento;
  String _detalleContacto;

  Residente({
    required String nombre,
    required int telefono,
    required String email,
    required int codigo,
    required int numApartamento,
    required String detalleContacto,
  })  
  //Inicializacion de datos
  : _numApartamento = numApartamento,
        _detalleContacto = detalleContacto,
        super(
          nombre: nombre,
          telefono: telefono,
          email: email,
          codigo: codigo,
        );

  int get numApartamento => _numApartamento;

  set numApartamento(int nuevoNumApartamento) {
    if (nuevoNumApartamento <= 0) {
      throw ("por favor revisar");
    }
    _numApartamento = nuevoNumApartamento;
  }

  String get getDetalleContacto => _detalleContacto;

  set setDetalleContacto(String nuevoDetalleContacto) {
    if (nuevoDetalleContacto == "") {
      throw ("por favor revisar");
    }
    _detalleContacto = nuevoDetalleContacto;
  }

  //Polimorfismo
  @override
  void Registrar() {
    print("${getNombre + getDetalleContacto} exitoso");
  }

  //Metodos propios
  void RegistrarAnomalia(Anomalia anomalia) {
    print(" Registro  de anomalia Rexitoso ");
  }

  void VerEstado(Anomalia anomalia) {
    print("Consulta exitosa");
  }

  void VerInforme() {
    print(" Informe Visto");
  }
}
