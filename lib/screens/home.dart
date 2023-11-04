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
        title: Text('Bienvenido',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      drawer: Drawer(
        //backgroundColor: Colors.amber,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Usuario'),
              accountEmail: Text('usuario@example.com'),
              currentAccountPicture: CircleAvatar(
                  //  backgroundImage: AssetImage('assets/avatar.jpg'), // Ruta de la imagen de avatar
                  ),
              decoration: BoxDecoration(
                color: Colors
                    .blue, // Cambia el color de fondo a azul
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Acciones cuando se toca el primer elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Explorar'),
              onTap: () {
                // Acciones cuando se toca el segundo elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Chat'),
              onTap: () {
                // Acciones cuando se toca el segundo elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Historal'),
              onTap: () {
                // Acciones cuando se toca el segundo elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Configuracion'),
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
