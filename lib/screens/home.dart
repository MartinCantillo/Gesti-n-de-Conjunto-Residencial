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
      appBar: AppBar(
        title: Text('Bienvenido',
            textAlign: TextAlign.center, 
            style: TextStyle(color: prefs.colosecundario ? Colors.white : Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        backgroundColor: prefs.colosecundario ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
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
              title: Text('Home', style: TextStyle(color: prefs.colosecundario ? Colors.white : Colors.black),),
              onTap: () {
                // Acciones cuando se toca el primer elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Explorar', style: TextStyle(color: prefs.colosecundario ? Colors.white : Colors.black),),
              onTap: () {
                // Acciones cuando se toca el segundo elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Chat', style: TextStyle(color: prefs.colosecundario ? Colors.white : Colors.black),),
              onTap: () {
                // Acciones cuando se toca el segundo elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Historal', style: TextStyle(color: prefs.colosecundario ? Colors.white : Colors.black),),
              onTap: () {
                // Acciones cuando se toca el segundo elemento del cajón de navegación.
              },
            ),
            ListTile(
              title: Text('Configuracion', style: TextStyle(color: prefs.colosecundario ? Colors.white : Colors.black),),
              onTap: () {
                // Acciones cuando se toca el segundo elemento del cajón de navegación.
              },
            ),
            const Divider(),
            SwitchListTile(
                value: _colorsecundario,
                title: Text('Tema oscuro', style: TextStyle(color: prefs.colosecundario ? Colors.white : Colors.black),),
                onChanged: (value) {
                  setState(() {
                    _colorsecundario = value;
                    prefs.colosecundario = value;
                  });
                }),
          ],
        ),
      ),
      body:  Center(
        child: Text('Contenido de la página principal', style: TextStyle(color:prefs.colosecundario ? Colors.white : Colors.black),),
      ),
    );
  }
}
