import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Widgets/drawer_widget.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';

class Historial extends StatefulWidget {
  const Historial({Key? key});

  static const String nombre = 'historialPage';

  @override
  State<Historial> createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
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
            'Historial',
            textAlign: TextAlign.center,
            
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pagina Historial',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 40,
              ),
            ),
            SizedBox(width: 20), 
          ],
        ),
      ),
    );
  }
}
