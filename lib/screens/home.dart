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
        title: const Text('Bienvenido',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        backgroundColor: prefs.colosecundario ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Usuario'),
              accountEmail: const Text('usuario@example.com'),
              currentAccountPicture: CircleAvatar(
                child: const Icon(
                  Icons.person,
                  size: 68.0,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),

            ListTile(
              leading: Icon(Icons.home, color:Colors.blue), 
              title: Text('Home',
                  style: TextStyle(
                      color:
                          prefs.colosecundario ? Colors.white : Colors.black)),
              onTap: () {
                // Acciones cuando se toca el elemento "Home" del cajón de navegación.
              },
            ),
            ListTile(
              leading: Icon(Icons.explore, color:Colors.blue), 
              title: Text('Explorar',
                  style: TextStyle(
                      color:
                          prefs.colosecundario ? Colors.white : Colors.black)),
              onTap: () {
                // Acciones cuando se toca el elemento "Explorar" del cajón de navegación.
              },
            ),
            ListTile(
              leading: Icon(Icons.chat, color:Colors.blue), 
              title: Text('Chat',
                  style: TextStyle(
                      color:
                          prefs.colosecundario ? Colors.white : Colors.black)),
              onTap: () {
                // Acciones cuando se toca el elemento "Chat" del cajón de navegación.
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color:Colors.blue), 
              title: Text('Historial',
                  style: TextStyle(
                      color:
                          prefs.colosecundario ? Colors.white : Colors.black)),
              onTap: () {
                // Acciones cuando se toca el elemento "Historial" del cajón de navegación.
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color:Colors.blue), 
              title: Text('Configuración',
                  style: TextStyle(
                      color:
                          prefs.colosecundario ? Colors.white : Colors.black)),
              onTap: () {
                // Acciones cuando se toca el elemento "Configuración" del cajón de navegación.
              },
            ),
            const Divider(
              height: 3,
              thickness: 0,
              indent: 3,
              endIndent: 3,
              color: Colors.grey,
            ),
            SwitchListTile(
                value: _colorsecundario,
                title: Text(
                  'Tema oscuro',
                  style: TextStyle(
                      color:
                          prefs.colosecundario ? Colors.white : Colors.black),
                ),
                onChanged: (value) {
                  setState(() {
                    _colorsecundario = value;
                    prefs.colosecundario = value;
                  });
                }),
          ],
        ),
      ),
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
