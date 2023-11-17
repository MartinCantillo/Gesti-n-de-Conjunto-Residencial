import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Widgets/drawer_widget.dart';
import 'package:gestionresidencial/Views/screens/chatPage_screen.dart';
import 'package:gestionresidencial/Views/screens/historialPage_screen.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';

class myHomePage extends StatefulWidget {
  const myHomePage({Key? key});

  static const String nombre = 'myHomePage';

  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  final prefs = PrefernciaUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
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
                    Navigator.of(context).popAndPushNamed(Historial.nombre);
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
          Navigator.of(context).popAndPushNamed(chatPage.nombre);
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
