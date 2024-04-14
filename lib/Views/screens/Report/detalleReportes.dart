import 'package:flutter/material.dart';

class DetalleReportes extends StatelessWidget {

  static String nombre = 'detallesScreen';

  const DetalleReportes({super.key});

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
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20), // Añade un espacio entre la parte superior y el primer texto
            const Text(
              'Asunto:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Asunto del reporte'),

            const SizedBox(height: 20), // Añade un espacio entre los textos
            const Text(
              'Tipo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Tipo del reporte'),

            const SizedBox(height: 20), // Añade un espacio entre los textos
            const Text(
              'Descripción:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Descripción del reporte'),

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () {
                      // Acción para cargar la imagen
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Añade un espacio entre los textos
            const Text(
              'Prioridad:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8), // Añade un espacio entre el texto y el DropdownButton
            DropdownButtonFormField<String>(
              value: 'Alta',
              onChanged: (value) {
                // Acción para asignar prioridad
              },
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              items: <String>['Alta', 'Media', 'Baja']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}