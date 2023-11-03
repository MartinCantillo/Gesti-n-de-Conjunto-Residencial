import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  static const String nombre = 'home';

  @override
  State<HomePage> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'), // Título de la aplicación
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Nombre de usuario'),
              accountEmail: Text('usuario@example.com'),
              
              currentAccountPicture: CircleAvatar(
              //  backgroundImage: AssetImage('assets/avatar.jpg'), // Ruta de la imagen de avatar
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Acciones cuando se toca el primer elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Acciones cuando se toca el segundo elemento del cajón de navegación.
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Contenido de la página principal'),
      ),
    );
  }
}