import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/screens/report_screen.dart';
import 'package:gestionresidencial/Views/screens/detailsReport_screen.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';


class HistorialPage extends StatefulWidget {
  const HistorialPage({Key? key, required this.reports}) : super(key: key);

  final List<Report> reports ;
  static const String nombre = 'historialPage';

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> { 
  final prefs = PrefernciaUsuario();
  List<Report> reports = [];
  
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
      body: reports.isEmpty
          ? const Center(
              child: Text('No hay reportes'),
            )
          : ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Tipo: ${reports[index].type}'),
                  subtitle: Text('Asunto: ${reports[index].subject}'),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ReportDetalles(report: reports[index])),);
                  },
                );
              },
            ),
    );
  }
}
