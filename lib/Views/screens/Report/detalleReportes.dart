import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/Views/screens/Chat/chat_screen.dart';

import 'package:gestionresidencial/main.dart';

class DetalleReportes extends ConsumerStatefulWidget {
  static String nombre = 'detallesScreen';

  final AnomaliaModel anomalia;

  const DetalleReportes({Key? key, required this.anomalia}) : super(key: key);

  @override
  _DetalleReportesState createState() => _DetalleReportesState();
}

class _DetalleReportesState extends ConsumerState<DetalleReportes> {
  late Future<List<AnomaliaModel>> anomaliasList;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Reporte'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Acción para compartir
            },
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: upload(widget.anomalia), // Usar el objeto anomalia del widget
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.chat),  
        onPressed: () {
          Navigator.of(context).pushNamed(ChatPage.nombre);
        },
      ),
    );
  }

  Widget upload(AnomaliaModel? data) {
    if (data != null) {
      print(data.id);
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Asunto:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${data.asuntoAnomalia}'),
            const SizedBox(height: 20), // Añade un espacio entre los textos
            const Text(
              'Tipo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${data.tipoAnomalia}'),
            const SizedBox(height: 20), // Añade un espacio entre los textos
            const Text(
              'Descripción:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${data.descripcionAnomalia}'),
            const SizedBox(height: 20), // Añade un espacio entre los textos
            const Text(
              'Evidencia:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // Añade un espacio entre los textos
            Container(
              height: 200, // Altura reservada para la imagen
              color: Colors.grey[200], // Color de fondo
              alignment: Alignment.center,
              child: const Icon(Icons.photo),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox(); // Retorna un widget vacío si no hay datos
    }
  }
}
