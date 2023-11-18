import 'package:flutter/material.dart';

import 'package:gestionresidencial/Views/Widgets/drawer_widget.dart';
import 'package:gestionresidencial/Views/screens/chat_screen.dart';
import 'package:gestionresidencial/Views/screens/historial_screen.dart';
import 'package:gestionresidencial/Views/screens/settings_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String nombre = 'myHomePage';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ignore: camel_case_types
class _MyHomePageState extends State<MyHomePage> {
  final prefs = PrefernciaUsuario();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed(settingsPage.nombre);
            },
             icon: const Icon(Icons.settings))
        ],
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenidos al home',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(
                      context,
                       HistorialPage.nombre
                    );
                  },
                  child: const Text('Ir'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Cancelar'),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).popAndPushNamed(ChatPage.nombre);
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
