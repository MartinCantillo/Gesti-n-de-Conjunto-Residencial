import "package:flutter/material.dart";
import 'package:gestionresidencial/Views/screens/report_screen.dart';

class ReportDetalles extends StatelessWidget {
  final Report report;

  const ReportDetalles({super.key, 
    required this.report
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Reporte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tipo: ${report.type}',
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
            const SizedBox(height: 8.0),
            Text('Asunto: ${report.subject}'),
            
            const SizedBox(height: 8.0),
            Text('Descripción: ${report.description}'),
            const SizedBox(height: 16.0),
            const Text('Evidencias:'),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: report.evidences.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(report.evidences[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}