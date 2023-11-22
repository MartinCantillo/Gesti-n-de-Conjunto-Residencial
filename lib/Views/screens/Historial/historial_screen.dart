import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/screens/Home/myHomePage_screen.dart';

import 'package:gestionresidencial/Views/screens/Report/report_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/detailsReport_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';


class HistorialPage extends StatefulWidget {
  final List<Report> reports ;
  const HistorialPage({Key? key, required this.reports}) : super(key: key);
  
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
        leading: IconButton(
          onPressed: () {Navigator.of(context).popAndPushNamed(MyHomePage.nombre);
          }, 
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
      ),
      body: widget.reports.isEmpty
          ? const Center(
              child: Text('No hay reportes'),
            )
          : ListView.builder(
              itemCount: widget.reports.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsetsDirectional.all(8),
                  margin: const EdgeInsetsDirectional.all(8.0),
                  decoration: BoxDecoration(
                    color:Colors.grey[200], 
                  ),
                  child: ListTile(
                    title: Text('Tipo: ${widget.reports[index].anomaly}'),
                    subtitle: Text('Asunto: ${widget.reports[index].subject}'),
                    trailing:const Column(
                      children: [
                        Text('Estado: En espera',
                        style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ReportDetalles(report: widget.reports[index])),);
                    },
                  ),
                );
              },
            ),
    );
  }
}
