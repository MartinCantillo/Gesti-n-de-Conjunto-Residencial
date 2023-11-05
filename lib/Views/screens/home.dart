import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Widgets/drawer.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key});

  static const String nombre = 'home2';

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
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
  appBar: AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.blue,
  ),
  drawer: CustomDrawer(),
  body: Center(
    child: Text(
      'Contenido de la página principal home ',
      style: TextStyle(
        color: prefs.colosecundario ? Colors.white : Colors.black,
      ),
    ),
  ),
);

  }
}
