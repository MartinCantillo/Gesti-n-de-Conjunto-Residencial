import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
   return  Scaffold(
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
  body: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0), // Puedes ajustar el espaciado según tus preferencias
        child: Text(
          "Bienvenido User",
          style: TextStyle(
            fontSize: 24, // Ajusta el tamaño de la fuente
            fontWeight: FontWeight.bold, // Otras propiedades de estilo de texto
          ),
        ),
      ),
      Expanded(
        child: GridView.count(
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          crossAxisCount: 2,
          children: <Widget>[
            Container(
  width: 20, // Ajusta el ancho de la Card
  height: 15, // Ajusta la altura de la Card
  child: Card(
    color: Colors.blue,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Home1"),
        ],
      ),
    ),
  ),
), 
 Container(
  width: 20, // Ajusta el ancho de la Card
  height: 15, // Ajusta la altura de la Card
  child: Card(
    color: Colors.blue,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Home2"),
        ],
      ),
    ),
  ),
), 
 Container(
  width: 20, // Ajusta el ancho de la Card
  height: 15, // Ajusta la altura de la Card
  child: Card(
    color: Colors.blue,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Home3"),
        ],
      ),
    ),
  ),
), 
 Container(
  width: 20, // Ajusta el ancho de la Card
  height: 15, // Ajusta la altura de la Card
  child: Card(
    color: Colors.blue,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Home4"),
        ],
      ),
    ),
  ),
), 



          ],
        ),
      ),
    ],
  ),
);


  }
}
