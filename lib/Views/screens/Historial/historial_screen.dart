import 'package:flutter/material.dart';
import 'package:gestionresidencial/Views/Widgets/hiddenDrawer/hiddenDrawer.dart';

import 'package:gestionresidencial/Views/screens/Report/report_screen.dart';
import 'package:gestionresidencial/Views/screens/Report/detailsReport_screen.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';


class HistorialPage extends StatefulWidget {
  final List<ReportPage> reports ;
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
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(HiddenDrawer.nombre);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: appState.reports.isEmpty
          ? const Center(
              child: Text('No hay reportes'),
            )
          : _ListReports(),
    );
  }

  ListView _ListReports() {
    return ListView.builder(
            itemCount: appState.reports.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsetsDirectional.all(8),
                margin: const EdgeInsetsDirectional.all(8.0),
                decoration: BoxDecoration(
                  boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(2, 4),
                      ),
                    ],
                  color:Colors.grey[100], 
                ),
                child: ListTile(
                  title: Text('Tipo: ${appState.reports[index].type}'),
                  subtitle: Text('Asunto: ${appState.reports[index].subject}'),
                  trailing:const Column(
                    children: [
                      Text('Estado: En espera',
                      style: TextStyle(color: Colors.red,
                      fontWeight: FontWeight.bold)),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsReportPage(report: appState.reports[index])),
                    );
                  },
                ),
              );
            },
          );
  }
}
