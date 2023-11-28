import "package:flutter/material.dart";

import 'package:gestionresidencial/Views/screens/Report/report_screen.dart';

class DetailsReportPage extends StatelessWidget {
  final ReportPage report;

  const DetailsReportPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Detalles del Reporte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            DetailsReportCard(),
            ListEvidences(),
          ],
        ),
      ),
    );
  }

  SizedBox ListEvidences() {
    return SizedBox(
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
    );
  }

  Card DetailsReportCard() {
    return Card(
      elevation: 5, // Añade sombra al card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tipo: ${report.type}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Asunto: ${report.subject}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Descripción: ${report.description}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Evidencias:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
