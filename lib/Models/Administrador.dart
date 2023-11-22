import 'package:gestionresidencial/Models/Persona.dart';

class Administrador extends Persona {
  String _horario;
  Administrador(
      {required String nombre,
      required int telefono,
      required String email,
      required int codigo,
      required String horario})
      //Inicializacion de datos
      : _horario = horario,
        super(
          nombre: nombre,
          telefono: telefono,
          email: email,
          codigo: codigo,
        );

  //Set and gett
  String get getHorario => _horario;
  set setHorario(String horario) {
    if (horario == "") {
      throw ("por favor revisar");
    }
    _horario = horario;
  }
}
