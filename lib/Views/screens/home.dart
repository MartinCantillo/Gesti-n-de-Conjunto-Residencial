import 'package:flutter/material.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  static const String nombre = 'home';

  @override
  State<HomePage> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<HomePage> {
  bool _colorsecundario = false;
  final prefs = PrefernciaUsuario();

  @override
  void initState() {
    super.initState();
    _colorsecundario = prefs.colosecundario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefs.colosecundario ? Colors.black : Colors.white,
      body: Center(
        child: Text(
          'Contenido de la página principal',
          style: TextStyle(
              color: prefs.colosecundario ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
