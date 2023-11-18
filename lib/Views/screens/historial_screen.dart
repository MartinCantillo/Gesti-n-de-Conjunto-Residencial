import 'package:flutter/material.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({Key? key}) : super(key: key);

  static const String nombre = 'historialPage';

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
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
