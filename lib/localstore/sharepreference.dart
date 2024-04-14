import 'package:shared_preferences/shared_preferences.dart';

class PrefernciaUsuario {
  static final PrefernciaUsuario _instancia = PrefernciaUsuario._internal();

  factory PrefernciaUsuario() {
    return _instancia;
  }

  PrefernciaUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get usuario {
    return _prefs.getString('usuario') ?? "usuario no encontrado";
  }

  set usuario(String value) {
    _prefs.setString('usuario', value);
  }

  String get contrasena {
    return _prefs.getString('contrasena') ?? "contrasena incorrecta";
  }

  set contrasena(String value) {
    _prefs.setString('contrasena', value);
  }

  String get ultimapagina {
    return _prefs.getString('ultimapagina') ?? 'home';
  }

  set ultimapagina(String value) {
    _prefs.setString('ultimapagina', value);
  }

  bool get colosecundario {
    return _prefs.getBool('colosecundario') ?? false;
  }

  set colosecundario(bool value) {
    _prefs.setBool('colosecundario', value);
  }

  Future<void> guardarNombreUsuario(String nombreUsuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombreUsuario', nombreUsuario);
  }

  Future<String?> obtenerNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombreUsuario');
  }

  String get apartment {
    return _prefs.getString('apartment') ?? "apartment no encontrado";
  }

  set apartment(String value) {
    _prefs.setString('apartment', value);
  }
}
