class Persona {
  String _nombre;
  int _telefono;
  String _email;
  int _codigo;

  // Constructor
  Persona({
    required String nombre,
    required int telefono,
    required String email,
    required int codigo,
  })  : _nombre = nombre,
        _telefono = telefono,
        _email = email,
        _codigo = codigo;

  //Set and Get
  set setNombre(String nombre) {
    if (nombre == "") {
      throw ("El nombre esta vacio");
    }
    _nombre = nombre;
  }

  String get getNombre => _nombre;

  set setTelefono(int telefono) {
    if (telefono <= 0) {
      throw ("Por favor verifica");
    }
    _telefono = telefono;
  }

  int get getTelefono => _telefono;

  set setEmail(String email) {
    if (email == "") {
      throw ("El email esta vacio");
    }
    _email = email;
  }

  String get getEmail => _email;

  set setCodigo(int codigo) {
    if (codigo <= 0) {
      throw ("Por favor verifica");
    }
    _codigo = codigo;
  }

  int get getCodigo => _codigo;

  //Metodo

  void Registrar(){
    print("Registro exitoso");
  }
}
